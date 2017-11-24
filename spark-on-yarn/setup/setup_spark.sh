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


# cp ${spark_conf_dir}/mapred-site.xml.template ${spark_conf_dir}/mapred-site.xml

# # Update hadoop's JAVA_HOME
# sed -i 's/^export JAVA_HOME=.*$/export JAVA_HOME='$(echo $JAVA_HOME | sed -e 's:\/:\\\/:g')'/g' ${hadoop_conf_dir}/hadoop-env.sh
# # Update HADOOP_LOG_DIR
# sed -i 's|^\#\?export HADOOP_LOG_DIR=.*$|export HADOOP_LOG_DIR='$(echo ${hadoop_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/hadoop-env.sh
# # # Update YARN_LOG_DIR
# # sed -i 's|^\#\?export YARN_LOG_DIR=.*$|export YARN_LOG_DIR='$(echo ${yarn_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/yarn-env.sh
# # Update HADOOP_MAPRED_LOG_DIR
# sed -i 's|^\#\?export HADOOP_MAPRED_LOG_DIR=.*$|export HADOOP_MAPRED_LOG_DIR='$(echo ${hadoop_mapred_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/mapred-env.sh

# Update connection stuff
# sed -i 's/^#   StrictHostKeyChecking.*$/    StrictHostKeyChecking no/g' /etc/ssh/ssh_config

# ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
#   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
#   chmod 0600 ~/.ssh/authorized_keys

# HADOOP_GROUP=hadoop
# HADOOP_GROUP_ID=1000
# groupadd -g ${HADOOP_GROUP_ID} ${HADOOP_GROUP}
# ${this_dir}/create_hadoop_user.sh hadoop
# usermod -a -G sudo hadoop
# echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
