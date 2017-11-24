#!/bin/bash
this_dir=`dirname $0`

$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager