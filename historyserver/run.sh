#!/bin/bash
this_dir=`dirname $0`

mapred_user=mapred

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R ${mapred_user}:hadoop ${HADOOP_MAPRED_LOG_DIR}
sudo chmod 0775 ${HADOOP_MAPRED_LOG_DIR}

su - mapred -l -c "${this_dir}/scripts/start-mr-jobhistory.sh"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
