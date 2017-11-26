#!/bin/bash
this_dir=`dirname $0`

source /docker-hadoop/set_properties.sh
export NAMENODE_HOSTNAME=${NAMENODE_HOSTNAME:-`hostname -f`}
set_property "core:fs.defaultFS=hdfs://${NAMENODE_HOSTNAME}:9000"

sudo chmod +x ${this_dir}/**/*.sh
sudo chown -R hdfs:hadoop /var/hadoop/log
sudo chmod 0775 /var/hadoop/log

sudo chown -R hdfs:hadoop /hadoop/dfs/namenode
sudo chmod 0775 /hadoop/dfs/namenode
su - hdfs   -l -c "${this_dir}/scripts/start-namenode.sh"

# idx=1
# while true
# do
#   ((idx++))
#   # (1) prompt user, and read command line argument
#   read -p "Namenode is running, exit now? (y or n) " answer
#   # (2) handle the input we were given
#   case $answer in
#    [yY]* ) exit;;
#    [nN]* ) continue;;
#    * )     echo "Dude, just enter Y or N, please. not $idx -$answer-";;
#   esac
# done

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
