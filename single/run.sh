#!/bin/bash
this_dir=`dirname $0`

single_user=false

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R hadoop:hadoop /var/hadoop/log
sudo chmod 0775 /var/hadoop/log

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
