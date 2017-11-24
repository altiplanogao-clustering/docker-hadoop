FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-mapred

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_mapred.ini"

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

CMD ["/docker-hadoop-mapred/run.sh"]
