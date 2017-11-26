#!/bin/bash

function set_property(){
	local prop=$1
	local this_dir=/docker-hadoop
	if [ -n "$prop" ] ; then
			if [[ ${prop:0:1} == '-' ]] ; then
				echo "    Property [DEL]: ${prop:1}"
				sudo python ${this_dir}/conf_editor.py ${HADOOP_CONF_DIR} del ${prop:1}
			else
				echo "    Property [SET]: ${prop}"
				sudo python ${this_dir}/conf_editor.py ${HADOOP_CONF_DIR} set ${prop}
			fi
	fi
}

function set_properties(){
	local conf_str=$1
	local conf_str_len=${#conf_str}
	local first_letter=${conf_str:0:1}
	if [[ ${conf_str:0:1} == '"' ]] ; then
		((sub_len=$conf_str_len-2))
		conf_str=${conf_str:1:$sub_len}
	fi
	echo "Processing configuration string: [$conf_str]"
	if [ -n "$conf_str" ] ; then
		for conf_item in ${conf_str[*]}
		do
			set_property $conf_item
		done
	fi
}

function set_properties_file(){
	local file=$1
	if [ -f "$file" ] ; then
		echo "Processing configuration file: [$file]"
		while IFS= read -r line
		do
			if [[ ${line:0:1} == '#' ]] ; then
				echo "  $line"
				continue
			elif [[ ! $line =~ [^[:space:]] ]] ; then
				continue
			fi
			set_property $line
		done <"$file"
	fi
}

function set_properties_files(){
	local files_chain=$1
	files=(${files_chain//:/ })
	for file in "${files[@]}" ;
	do
		set_properties_file $file
	done
}

