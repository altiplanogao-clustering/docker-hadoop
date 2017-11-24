#!/bin/bash

# Parameters: username userid

user=$1
user_id=$2

HADOOP_GROUP=hadoop
HADOOP_GROUP_ID=1000

HADOOP_PREDEF_USERS=(hadoop hdfs yarn mapred)
HADOOP_PREDEF_USER_IDS=(1001 1002 1003 1004)

for key in ${!HADOOP_PREDEF_USERS[@]}
do
	predef_user=${HADOOP_PREDEF_USERS[$key]}
	predef_user_id=${HADOOP_PREDEF_USER_IDS[$key]}
	if [[ ${user}"" == ${predef_user}"" ]] ; then
		user_id=$predef_user_id
	fi
done
echo "USER and id: $user, $user_id"

user_home=/home/${user}
useradd -u ${user_id} -g ${HADOOP_GROUP} -d ${user_home} -s /bin/bash ${user} && \
	mkdir ${user_home} && mkdir ${user_home}/.ssh
ssh-keygen -t rsa -P '' -f ${user_home}/.ssh/id_rsa && \
  cat ${user_home}/.ssh/id_rsa.pub >> ${user_home}/.ssh/authorized_keys && \
  chmod 0600 ${user_home}/.ssh/authorized_keys
chown -R ${user}:${HADOOP_GROUP} ${user_home}
