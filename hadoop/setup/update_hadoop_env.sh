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
	echo "${exp}YARN_LOG_DIR=${hadoop_log_dir}" >> ${env_file}
	echo "${exp}HADOOP_MAPRED_LOG_DIR=${hadoop_log_dir}" >> ${env_file}
done




