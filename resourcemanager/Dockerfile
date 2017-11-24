FROM andy/hadoop:2.8.2

ENV CLUSTER_NAME=cluster-x
ARG docker_dir=/docker-hadoop-resourcemanager

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_resourcemanager.ini"

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

# https://hadoop.apache.org/docs/r2.8.2/hadoop-yarn/hadoop-yarn-common/yarn-default.xml
EXPOSE 8032 8033 8088 8090

CMD ["/docker-hadoop-resourcemanager/run.sh"]
