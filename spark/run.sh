#!/bin/bash
this_dir=`dirname $0`

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R spark:hadoop /var/spark/log
sudo chmod 0775 /var/spark/log

on_options=(on yes true)

hs_switch=`echo "$SPARK_RUN_HISTORYSERVER" | awk '{print tolower($0)}'`
for key in ${on_options[*]}
do
	if [[ ${key}"" == ${hs_switch}"" ]] ; then
		su - spark -l -c "${this_dir}/scripts/run-historyserver.sh"
		break
	fi
done

demo_switch=`echo "$SPARK_RUN_DEMO" | awk '{print tolower($0)}'`
for key in ${on_options[*]}
do
	if [[ ${key}"" == ${demo_switch}"" ]] ; then
		su - spark -l -c "${this_dir}/scripts/run-demo.sh"
		break
	fi
done



if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
