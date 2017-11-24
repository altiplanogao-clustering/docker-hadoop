#!/bin/bash

hadoop_filename="hadoop-${HADOOP_VERSION}.tar.gz"
hadoop_res_filename="/docker-hadoop/res/hadoop-${HADOOP_VERSION}.tar.gz"
hadoop_tmp_filename="/tmp/hadoop-${HADOOP_VERSION}.tar.gz"
hadoop_url="http://www-eu.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"

echo "Prepare ${hadoop_filename}"
if [ -e "${hadoop_res_filename}" ] ; then
	echo "  mv ${hadoop_res_filename} ${hadoop_tmp_filename}"
	mv ${hadoop_res_filename} ${hadoop_tmp_filename}
else
	echo "  curl -fSL ${hadoop_url} -o ${hadoop_tmp_filename}"
	curl -fSL "${hadoop_url}" -o "${hadoop_tmp_filename}"
fi
echo "Prepare ${hadoop_filename}.asc"
if [ -e "${hadoop_res_filename}.asc" ] ; then
	echo "  mv ${hadoop_res_filename}.asc ${hadoop_tmp_filename}.asc"
	mv ${hadoop_res_filename}.asc ${hadoop_tmp_filename}.asc
else
	echo "  curl -fSL ${hadoop_url}.asc -o ${hadoop_tmp_filename}.asc"
	curl -fSL "${hadoop_url}.asc" -o "${hadoop_tmp_filename}.asc"
fi

tar -zxf ${hadoop_tmp_filename} -C /tmp
mv /tmp/hadoop-${HADOOP_VERSION} `dirname ${install_path}`
rm ${hadoop_tmp_filename}

ln -s /usr/lib/hadoop-${HADOOP_VERSION} ${install_path}
rm -rf ${install_path}/share/doc
