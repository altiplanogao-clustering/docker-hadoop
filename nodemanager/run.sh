#!/bin/bash
this_dir=`dirname $0`

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R yarn:hadoop ${YARN_LOG_DIR}
sudo chmod 0775 ${YARN_LOG_DIR}

su - yarn   -l -c "${this_dir}/scripts/start-nodemanager.sh"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
