#!/bin/bash


sed -i 's|^export SPARK_DIST_CLASSPATH=.*$||g' ${SPARK_CONF_DIR}/spark-env.sh
echo "export SPARK_DIST_CLASSPATH=$(${HADOOP_HOME}/bin/hadoop --config ${HADOOP_CONF_DIR} classpath)" >> ${SPARK_CONF_DIR}/spark-env.sh
