#!/bin/bash
this_dir=`dirname $0`


echo "Namenode starting ..."
namenode_filedir=`/docker-hadoop/conf_editor.py ${HADOOP_CONF_DIR} print hdfs:dfs.namenode.name.dir`
echo "    namenode dir: $namenode_filedir"
namenode_dir=`echo $namenode_filedir | sed 's|^file://||'`
echo "    namenode dir: $namenode_dir"

if [ ! -d $namenode_dir ]; then
  echo "Namenode directory not exists: $namenode_dir"
  exit 1
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit 1
fi

if [ ! -f $namenode_dir/current/VERSION ]; then
  echo "Formatting namenode ..."
  echo "        Directory:    $namenode_dir"
  echo "        Cluster Name: $CLUSTER_NAME"
  $HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode -format $CLUSTER_NAME 
fi

# $HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR namenode
$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode