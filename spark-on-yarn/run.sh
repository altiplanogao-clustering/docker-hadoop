#!/bin/bash
this_dir=`dirname $0`

sudo chmod +x ${this_dir}/**/*.sh

sed -i 's|^export SPARK_DIST_CLASSPATH=.*$||g' $SPARK_CONF_DIR/spark-env.sh
echo "export SPARK_DIST_CLASSPATH=$(hadoop --config ${HADOOP_CONF_DIR} classpath)" >> ${SPARK_CONF_DIR}/spark-env.sh

# sudo chown -R hdfs:hadoop /var/hadoop/log
# sudo chmod 0775 /var/hadoop/log

# sudo chown -R hdfs:hadoop /hadoop/dfs/datanode
# sudo chmod 0775 /hadoop/dfs/datanode
# su - hdfs   -l -c "${this_dir}/scripts/start-datanode.sh"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
