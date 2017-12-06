#!/bin/bash

# env_files=( /etc/environment /etc/bash.bashrc /etc/profile )

profd_sh_file=/etc/profile.d/spark.sh
touch $profd_sh_file
env_files=( $profd_sh_file )
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

	echo "${exp}PATH=${install_path}/bin:\$PATH" >> ${env_file}

done

