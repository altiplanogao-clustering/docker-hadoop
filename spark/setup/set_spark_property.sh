#!/bin/bash

function set_spark_property(){
	local prop=$1
	kvp=(${prop//=/ })
	name=${kvp[0]}
	value=${kvp[1]}
	conf_file=${SPARK_CONF_DIR}/spark-defaults.conf

    echo "SETTING SPARK PROPERTY $name=$value"
	sed -i 's|^'$name'.*$||g' ${conf_file}
    echo $name $value >> ${conf_file}
}

function set_spark_properties(){
	local conf_str=$1
	local conf_str_len=${#conf_str}
	local first_letter=${conf_str:0:1}
	if [[ ${conf_str:0:1} == '"' ]] ; then
		((sub_len=$conf_str_len-2))
		conf_str=${conf_str:1:$sub_len}
	fi
	if [ -n "$conf_str" ] ; then
		echo "Processing configuration string: [$conf_str]"
		for conf_item in ${conf_str[*]}
		do
			set_spark_property $conf_item
		done
	fi
}
