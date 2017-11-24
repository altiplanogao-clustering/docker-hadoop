#!/bin/bash
this_dir=`dirname $0`

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R yarn:hadoop /var/hadoop/log
sudo chmod 0775 /var/hadoop/log

su - yarn   -l -c "${this_dir}/scripts/start-resourcemanager.sh"

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
