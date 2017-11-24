FROM andy/hadoop:2.8.2

ARG docker_dir=/docker-hadoop-historyserver

ENV HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/config_historyserver.ini"

ADD . ${docker_dir}
RUN chmod a+x ${docker_dir}/*.sh
RUN ${docker_dir}/setup.sh

EXPOSE 19888

CMD ["/docker-hadoop-historyserver/run.sh"]
