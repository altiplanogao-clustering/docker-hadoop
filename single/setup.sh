#!/bin/bash
this_dir=`dirname $0`

HADOOP_USERS=(hdfs yarn mapred)
HADOOP_USER_IDS=(1002 1003 1004)

for key in ${!HADOOP_USERS[@]}
do
	user=${HADOOP_USERS[$key]}
	user_id=${HADOOP_USER_IDS[$key]}
	/docker-hadoop/setup/create_hadoop_user.sh $user $user_id
done

hadoop_and_hdfs=(hadoop hdfs)
for user in ${hadoop_and_hdfs[*]}
do
	echo "CLUSTER_NAME=${CLUSTER_NAME}" >> /home/${user}/.pam_environment
	echo "export CLUSTER_NAME=${CLUSTER_NAME}" >> /home/${user}/.bashrc
	echo "export CLUSTER_NAME=${CLUSTER_NAME}" >> /home/${user}/.profile
done

