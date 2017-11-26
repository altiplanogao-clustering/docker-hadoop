#!/bin/bash


sed -i 's|^export SPARK_DIST_CLASSPATH=.*$||g' ${SPARK_CONF_DIR}/spark-env.sh
echo "export SPARK_DIST_CLASSPATH=$(${HADOOP_HOME}/bin/hadoop --config ${HADOOP_CONF_DIR} classpath)" >> ${SPARK_CONF_DIR}/spark-env.sh


if [ -n "$SPARK_PROPERTY_CONF_DATA" ] ; then
	source /docker-spark/setup/set_spark_property.sh
	set_properties "$SPARK_PROPERTY_CONF_DATA"
fi
