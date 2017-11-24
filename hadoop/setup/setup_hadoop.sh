#!/bin/bash
this_dir=`dirname $0`

# Prepare Hadoop DIRs
hadoop_dirs=(${hadoop_conf_dir} ${hadoop_log_dir} ${namenode_dir} ${datanode_dir})
for hdp_dir in ${hadoop_dirs[*]}
do
	echo Process: ${hdp_dir}
	mkdir -p ${hdp_dir}
	chmod 0775 ${hdp_dir}
	# chown -R hadoop:${HADOOP_GROUP} ${hdp_dir}
done

# Prepare Hadoop Conf dir
echo COPY: cp -rf ${install_path}/etc/hadoop/* ${hadoop_conf_dir}
cp -rf ${install_path}/etc/hadoop/* ${hadoop_conf_dir}
cp ${hadoop_conf_dir}/mapred-site.xml.template ${hadoop_conf_dir}/mapred-site.xml

# Update hadoop's JAVA_HOME
sed -i 's/^export JAVA_HOME=.*$/export JAVA_HOME='$(echo $JAVA_HOME | sed -e 's:\/:\\\/:g')'/g' ${hadoop_conf_dir}/hadoop-env.sh
# Update HADOOP_LOG_DIR
sed -i 's|^\#\?export HADOOP_LOG_DIR=.*$|export HADOOP_LOG_DIR='$(echo ${hadoop_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/hadoop-env.sh
# # Update YARN_LOG_DIR
# sed -i 's|^\#\?export YARN_LOG_DIR=.*$|export YARN_LOG_DIR='$(echo ${yarn_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/yarn-env.sh
# Update HADOOP_MAPRED_LOG_DIR
sed -i 's|^\#\?export HADOOP_MAPRED_LOG_DIR=.*$|export HADOOP_MAPRED_LOG_DIR='$(echo ${hadoop_mapred_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_conf_dir}/mapred-env.sh

# Update connection stuff
sed -i 's/^#   StrictHostKeyChecking.*$/    StrictHostKeyChecking no/g' /etc/ssh/ssh_config

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 0600 ~/.ssh/authorized_keys

HADOOP_GROUP=hadoop
HADOOP_GROUP_ID=1000
groupadd -g ${HADOOP_GROUP_ID} ${HADOOP_GROUP}
${this_dir}/create_hadoop_user.sh hadoop
usermod -a -G sudo hadoop
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
