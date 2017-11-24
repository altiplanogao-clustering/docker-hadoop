FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-namenode

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_namenode.ini"
RUN mkdir -p /hadoop/dfs/namenode
VOLUME ["/hadoop/dfs/namenode"]

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

# https://hadoop.apache.org/docs/r2.8.2/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml
EXPOSE 50070 50470 9000

CMD ["/docker-hadoop-namenode/run.sh"]
