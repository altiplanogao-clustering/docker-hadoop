#!/usr/bin/env python

import os, sys, getopt
from xml.dom import minidom
import xml.etree.cElementTree as etree

class ConfigEditor(object):
    ACTION_SET = 'set'
    ACTION_GET = 'get'
    ACTION_DEL = 'del'
    ACTION_OUTPUT = 'print'
    ACTIONS = [ACTION_SET, ACTION_GET, ACTION_DEL, ACTION_OUTPUT]

    def __init__(self, conf_dir, fn_postfix='-site.xml'):
        self._conf_dir = conf_dir
        self._fn_postfix = fn_postfix

    def _scope_conf_file(self, scope):
        return os.path.join(self._conf_dir, scope + self._fn_postfix)

    @staticmethod
    def extractScopeKv(skv):
        skv = skv.replace('\n', "").strip()
        scopePos = skv.find(":")
        keyPos = skv.find("=")
        scope = skv[0:scopePos]
        key = ""
        val = ""
        if keyPos < 0:
            key = skv[scopePos+1:]
        else:
            key = skv[scopePos+1:keyPos]
            val = skv[keyPos+1:]
        return (scope, key, val)

    def operateProperty(self, scope, key, val=None, desc=None, action=ACTION_GET):
        if action not in ConfigEditor.ACTIONS:
            raise Exception("Unexpected action %s" % action)
        try:
            firstVal = val
            parser = etree.XMLParser()
            file = self._scope_conf_file(scope)
            propEle = self._make_property_ele(key=key, val=val, desc=desc)

            doc = etree.parse(file, parser=parser)
            confEle = doc.getroot()
            existings = confEle.findall("property[name='%s']" % key)
            if len(existings) > 0:
                firstVal = existings[0].findtext("value")
            if action == ConfigEditor.ACTION_GET:
                return firstVal
            elif action == ConfigEditor.ACTION_OUTPUT:
                print(firstVal)
                return firstVal
            for node in existings:
                confEle.remove(node)
            if action == ConfigEditor.ACTION_SET:
                confEle.append(propEle)
            self._drop_prop_ele_texts(confEle)

            try: # Wite by minidom for pretty-print
                minidom_doc = minidom.parse(file)
                minidom_conf = minidom_doc.lastChild

                new_conf = minidom.parseString(etree.tostring(confEle, encoding="UTF-8")).lastChild
                minidom_doc.removeChild(minidom_conf)
                minidom_doc.appendChild(new_conf)
                with open(file, "w") as f:
                    f.write(minidom_doc.toprettyxml(indent="    "))
            except Exception as ie:
                doc.write(file, encoding="UTF-8", xml_declaration=True)
        except Exception as e:
            print (e.message)
        return firstVal

    def _drop_prop_ele_texts(self, prop_ele):
        tag = prop_ele.tag
        if tag not in ["name", "value", "description"]:
            prop_ele.text = None
        prop_ele.tail = None
        for e in prop_ele:
            self._drop_prop_ele_texts(e)

    def _make_property_ele(self, key, val, desc=None):
        propEle = etree.Element("property")
        etree.SubElement(propEle, "name").text = key
        etree.SubElement(propEle, "value").text = val
        if not desc:
            etree.SubElement(propEle, "description").text = desc
        propEle.text = propEle.tail = None
        return propEle

def main(argv):
    conf_dir = argv[0]
    action = argv[1]
    specStr = argv[2]
    spec = ConfigEditor.extractScopeKv(specStr)
    coreConf = ConfigEditor(conf_dir=conf_dir)
    coreConf.operateProperty(scope=spec[0], action=action, key=spec[1], val=spec[2])

if __name__ == "__main__":
   main(sys.argv[1:])