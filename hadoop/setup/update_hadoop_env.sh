#!/bin/bash

# env_files=( /etc/environment /etc/bash.bashrc /etc/profile )
#env_files=( "/etc/environment" "/etc/bash.bashrc" "/etc/profile" )

profd_sh_file=/etc/profile.d/hadoop.sh
touch $profd_sh_file
env_files=( $profd_sh_file )
for env_file in ${env_files[*]}
do
	exp="export "
	if [[ ${env_file}"" == "/etc/environment" ]] ; then
		exp=""
	fi
	echo "${exp}JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> ${env_file}
	echo "${exp}HADOOP_VERSION=${HADOOP_VERSION}" >> ${env_file}
	echo "${exp}HADOOP_HOME=${install_path}" >> ${env_file}
	echo "${exp}HADOOP_PREFIX=${install_path}" >> ${env_file}
	echo "${exp}PATH=${install_path}/bin:\$PATH" >> ${env_file}

	echo "${exp}HADOOP_HDFS_HOME=${install_path}" >> ${env_file}
	echo "${exp}HADOOP_YARN_HOME=${install_path}" >> ${env_file}
	echo "${exp}HADOOP_MAPRED_HOME=${install_path}" >> ${env_file}

	echo "${exp}HADOOP_CONF_DIR=${hadoop_conf_dir}" >> ${env_file}
	
	echo "${exp}HADOOP_LOG_DIR=${hadoop_log_dir}" >> ${env_file}
	echo "${exp}YARN_LOG_DIR=${hadoop_yarn_log_dir}" >> ${env_file}
	echo "${exp}HADOOP_MAPRED_LOG_DIR=${hadoop_mapred_log_dir}" >> ${env_file}
done


# Update hadoop's JAVA_HOME
hadoop_env_sh=${hadoop_conf_dir}/hadoop-env.sh
sed -i 's/^export JAVA_HOME=.*$/export JAVA_HOME='$(echo $JAVA_HOME | sed -e 's:\/:\\\/:g')'/g' ${hadoop_env_sh}
# Update HADOOP_LOG_DIR
echo "export HADOOP_LOG_DIR=${hadoop_log_dir}" >> ${hadoop_env_sh}
sed -i 's|^\#\?export HADOOP_LOG_DIR=.*$|export HADOOP_LOG_DIR='$(echo ${hadoop_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${hadoop_env_sh}

# # Update YARN_LOG_DIR
yarn_env_sh=${hadoop_conf_dir}/yarn-env.sh
echo "export YARN_LOG_DIR=${hadoop_yarn_log_dir}" >> ${yarn_env_sh}
sed -i 's|^\#\?export YARN_LOG_DIR=.*$|export YARN_LOG_DIR='$(echo ${hadoop_yarn_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${yarn_env_sh}

# Update HADOOP_MAPRED_LOG_DIR
mapred_env_sh=${hadoop_conf_dir}/mapred-env.sh
echo "export HADOOP_MAPRED_LOG_DIR=${hadoop_mapred_log_dir}" >> ${mapred_env_sh}
sed -i 's|^\#\?export HADOOP_MAPRED_LOG_DIR=.*$|export HADOOP_MAPRED_LOG_DIR='$(echo ${hadoop_mapred_log_dir} | sed -e 's:\/:\\\/:g')'|g' ${mapred_env_sh}

