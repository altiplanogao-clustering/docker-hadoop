#!/bin/bash

# env_files=( /etc/environment /etc/bash.bashrc /etc/profile )

env_files=( "/etc/environment" "/etc/bash.bashrc" "/etc/profile" )
for env_file in ${env_files[*]}
do
	exp="export "
	if [[ ${env_file}"" == "/etc/environment" ]] ; then
		exp=""
	fi
	echo "${exp}SPARK_VERSION=${SPARK_VERSION}" >> ${env_file}
	echo "${exp}SPARK_HOME=${install_path}" >> ${env_file}
	echo "${exp}SPARK_CONF_DIR=${spark_conf_dir}" >> ${env_file}
	echo "${exp}SPARK_LOG_DIR=${spark_log_dir}" >> ${env_file}
done


