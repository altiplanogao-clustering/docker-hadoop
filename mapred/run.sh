#!/bin/bash
this_dir=`dirname $0`

mapred_user=mapred

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R ${mapred_user}:hadoop ${HADOOP_MAPRED_LOG_DIR}
sudo chmod 0775 ${HADOOP_MAPRED_LOG_DIR}

su - ${mapred_user} -l -c "${this_dir}/scripts/run-demo.sh ${mapred_user}"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
