#!/bin/bash
this_dir=`dirname $0`

image_name=andy/hadoop-mapred:latest
container_name=mapred-debugging-a

# docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm -v
# docker images | grep none | awk '{print $3}' | xargs docker image rm

if [[ $1 == b ]]; then
	${this_dir}/build.sh
fi

docker stop  ${container_name}
docker rm -v ${container_name}
#docker run --rm -d --name ${container_name} andy/hadoop:latest
# docker run --rm -it -P --hostname ${container_name} --name ${container_name} $image_name /run.sh -bash

docker run --rm -it --net=docker_hadoop-net -P -e HADOOP_CONF_DATA="core:fs.defaultFS=hdfs://namenode1-a:9000 yarn:yarn.resourcemanager.hostname=resourcemanager-a" --hostname mapred-debugging-a --name mapred-debugging-a andy/hadoop-mapred:latest /docker-hadoop-mapred/run.sh -bash
