#!/bin/bash

hadoop_user=$1
# NameNode - http://localhost:50070/
# ResourceManager - http://localhost:8088/
echo "================================================="
echo "===       RUN DEMO       ========================"
echo "================================================="

echo "Check HDFS status ..."
until $HADOOP_HOME/bin/hdfs dfsadmin -report 2>/dev/null ; do
	echo "HDFS not running, waiting ..."
	sleep 5
done
echo "=== dfs -rm /user                ================"
$HADOOP_PREFIX/bin/hdfs dfs -rm -f -r  /user
echo "=== dfs -mkdir /user             ================"
$HADOOP_PREFIX/bin/hdfs dfs -mkdir /user
echo "=== dfs -mkdir /user/xxx         ================"
$HADOOP_PREFIX/bin/hdfs dfs -mkdir /user/${hadoop_user}
echo "=== dfs -put HADOOP_PREFIX/etc/hadoop input   ==="
$HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop input
echo "=== Run demo                    ================="
$HADOOP_PREFIX/bin/hadoop jar $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-${HADOOP_VERSION}.jar grep input output 'dfs[a-z.]+'
echo "=== Cat result                  ================="
$HADOOP_PREFIX/bin/hdfs dfs -cat output/*
