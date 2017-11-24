FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-datanode

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_datanode.ini"
RUN mkdir -p /hadoop/dfs/datanode
VOLUME ["/hadoop/dfs/datanode"]

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

#50070 Namenode web ui
#50075 Datanode web ui
#8088 ResourceManager web ui
#8042 

# https://hadoop.apache.org/docs/r2.8.2/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml
EXPOSE 50075 50475 50010 50020

CMD ["/docker-hadoop-datanode/run.sh"]
