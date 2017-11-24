FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-single

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_single.ini"
RUN mkdir -p /hadoop/dfs/namenode && \
    mkdir -p /hadoop/dfs/datanode
VOLUME ["/hadoop/dfs/namenode", "/hadoop/dfs/datanode"]

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

#50070 Namenode web ui
#50075 Datanode web ui
#8088 ResourceManager web ui
#8042 

EXPOSE 50070 50470 9000 50075 50475 50010 50020 8032 8033 8088 8090 8042 19888

CMD ["/docker-hadoop-single/run.sh"]
