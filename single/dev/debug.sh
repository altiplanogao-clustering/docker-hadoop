#!/bin/bash
this_dir=`dirname $0`

image_name=andy/hadoop-single:latest
container_name=single-debugging

# docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm -v
# docker images | grep none | awk '{print $3}' | xargs docker image rm

if [[ $1 == b ]]; then
	${this_dir}/build.sh
fi

docker stop  ${container_name}
docker rm -v ${container_name}
#docker run --rm -d --name ${container_name} andy/hadoop:latest
# docker run --rm -it -P --hostname ${container_name} --name ${container_name} $image_name /run.sh -bash

docker run --rm -it -p 8088:8088 -p 50070:50070 -p 50075:50075 -p 8042:8042 -P --hostname single-debugging --name single-debugging andy/hadoop-single:latest /docker-hadoop-single/run.sh -bash
