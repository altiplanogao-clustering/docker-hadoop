#!/bin/bash


function create_user(){
	local prop=$1
	local this_dir=/docker-hadoop/setup
	if [ -n "$prop" ] ; then
		user=`echo $prop | perl -pe 's|^(\S*?)(\(([0-9]*)\))?$|\1|g'`
		uid=`echo $prop | perl -pe 's|^(\S*?)(\(([0-9]*)\))?$|\3|g'`

		echo "    CREATE USER : $user $uid"
	 	${this_dir}/create_hadoop_user.sh $user $uid
	fi
}

function create_users(){
	local conf_str=$1
	if [ -n "$conf_str" ] ; then
		echo "Create Users string: [$conf_str]"
		local _users=(${conf_str//:/ })
		for u in "${_users[@]}" ;
		do
			create_user $u
		done
	fi
}
