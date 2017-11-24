#!/bin/bash
this_dir=`dirname $0`

HADOOP_USERS=(hdfs)
HADOOP_USER_IDS=(1002)

for key in ${!HADOOP_USERS[@]}
do
	user=${HADOOP_USERS[$key]}
	user_id=${HADOOP_USER_IDS[$key]}
	/docker-hadoop/setup/create_hadoop_user.sh $user $user_id
done


