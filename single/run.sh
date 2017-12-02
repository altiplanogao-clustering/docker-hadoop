#!/bin/bash
this_dir=`dirname $0`

single_user=false

source /docker-hadoop/set_properties.sh
export NAMENODE_HOSTNAME=${NAMENODE_HOSTNAME:-`hostname -f`}
set_property "core:fs.defaultFS=hdfs://${NAMENODE_HOSTNAME}:9000"

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R hadoop:hadoop ${YARN_LOG_DIR}
sudo chmod 0775 ${YARN_LOG_DIR}
sudo chown -R hadoop:hadoop ${HADOOP_LOG_DIR}
sudo chmod 0775 ${HADOOP_LOG_DIR}
sudo chown -R hadoop:hadoop ${HADOOP_MAPRED_LOG_DIR}
sudo chmod 0775 ${HADOOP_MAPRED_LOG_DIR}

if [[ $single_user"" == "true" ]] ; then
  sudo chown -R hadoop:hadoop /hadoop/dfs/namenode
  sudo chown -R hadoop:hadoop /hadoop/dfs/datanode
else
  sudo chown -R hdfs:hadoop /hadoop/dfs/namenode
  sudo chown -R hdfs:hadoop /hadoop/dfs/datanode
fi

sudo chmod 0775 /hadoop/dfs/namenode
sudo chmod 0775 /hadoop/dfs/datanode

if [[ $single_user"" == "true" ]] ; then
  su - hadoop -l -c "${this_dir}/scripts/start-dfs.sh"
  su - hadoop -l -c "${this_dir}/scripts/start-yarn.sh"
  su - hadoop -l -c "${this_dir}/scripts/run-demo.sh hadoop"
else
  su - hdfs   -l -c "${this_dir}/scripts/start-dfs.sh"
  su - yarn   -l -c "${this_dir}/scripts/start-yarn.sh"
  # su - mapred -l -c "${this_dir}/scripts/start-mr-jobhistory.sh"
  su - mapred -l -c "${this_dir}/scripts/run-demo.sh mapred"
fi

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
