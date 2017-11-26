#!/bin/bash
this_dir=`dirname $0`

# Prepare Hadoop DIRs
spark_dirs=(${spark_conf_dir} ${spark_log_dir} )
for spk_dir in ${spark_dirs[*]}
do
	echo Process: ${spk_dir}
	mkdir -p ${spk_dir}
	chmod 0775 ${spk_dir}
	# chown -R hadoop:${HADOOP_GROUP} ${spk_dir}
done

# Prepare Hadoop Conf dir
echo COPY: cp -rf ${install_path}/conf/* ${spark_conf_dir}
cp -rf ${install_path}/conf/* ${spark_conf_dir}
for i in ${spark_conf_dir}/*
do
  if [[ "$i" == *.template ]];  then
  	new_name=`echo $i | sed -e 's|\.template$||g'`
    mv $i $new_name
  fi;
done


SPARK_USERS=(spark)
SPARK_USER_IDS=(2001)

for key in ${!SPARK_USERS[@]}
do
	user=${SPARK_USERS[$key]}
	user_id=${SPARK_USER_IDS[$key]}
	/docker-hadoop/setup/create_hadoop_user.sh $user $user_id
done
