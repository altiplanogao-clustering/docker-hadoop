#!/bin/bash
this_dir=`dirname $0`

$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager