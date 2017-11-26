#!/bin/bash
this_dir=`dirname $0`

function run_script(){
	local script=$1
	if [ -f "$script" ] ; then
		echo "Run: $script"
		su -c "$script"
	fi
}

function run_scripts(){
	local scripts=$1
	files=(${scripts//:/ })
	for file in  "${files[@]}" ;
	do
		run_script $file
	done
}

if [ -n "$EXTRA_SETUP_SCRIPTS_PLACEHOLDER" ] ; then
	run_scripts $EXTRA_SETUP_SCRIPTS_PLACEHOLDER
fi
