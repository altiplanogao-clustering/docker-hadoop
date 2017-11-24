#!/bin/bash
this_dir=`dirname $0`

$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver