#!/bin/bash
this_dir=`dirname $0`
source /docker-spark/setup/set_spark_property.sh

sed -i 's|^export SPARK_DIST_CLASSPATH=.*$||g' ${SPARK_CONF_DIR}/spark-env.sh
echo "export SPARK_DIST_CLASSPATH=$(${HADOOP_HOME}/bin/hadoop --config ${HADOOP_CONF_DIR} classpath)" >> ${SPARK_CONF_DIR}/spark-env.sh


if [ -n "$SPARK_PROPERTY_CONF_DATA" ] ; then
	set_spark_properties "$SPARK_PROPERTY_CONF_DATA"
fi


function enableLocalFsEventLog(){
	local default_spark_history_fs_logDirectory=/tmp/spark-events
	local ld=$default_spark_history_fs_logDirectory
	echo "WILL ENABLE LOCAL FS EVENTLOG @ $ls"

	if [ ! -d "$ld" ]; then
	    mkdir -p $ld
	    chown spark:hadoop $ld
	    chmod 0775 $ld
	fi

	set_spark_property "spark.eventLog.enabled=true"
}
function enableRemoteFsEventLog(){
	local spark_eventlog_dir=/spark_eventlog
	fs=$1
	local path=$fs$spark_eventlog_dir
	echo "WILL ENABLE REMOTE FS EVENTLOG @ $path"

	su - spark -l -c "${this_dir}/../scripts/create-remote-dir.sh $spark_eventlog_dir"

	set_spark_property "spark.eventLog.enabled=true"
	set_spark_property "spark.eventLog.dir=$path"
	set_spark_property "spark.history.fs.logDirectory=$path"
}
function enableEventLog(){
	local fs=`/docker-hadoop/conf_editor.py $HADOOP_CONF_DIR print core:fs.defaultFS`
	if [ -n "$fs" ] ; then
		enableRemoteFsEventLog $fs
	else
		enableLocalFsEventLog
	fi
}

on_options=(on yes true enable)
eventlog_switch=`echo "$SPARK_EVENTLOG_ENABLE" | awk '{print tolower($0)}'`
for key in ${on_options[*]}
do
	if [[ ${key}"" == ${eventlog_switch}"" ]] ; then
		enableEventLog
		break
	fi
done

