FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-nodemanager

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_nodemanager.ini"

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

# https://hadoop.apache.org/docs/r2.8.2/hadoop-yarn/hadoop-yarn-common/yarn-default.xml
EXPOSE 8042

CMD ["/docker-hadoop-nodemanager/run.sh"]
