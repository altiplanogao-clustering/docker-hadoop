FROM andy/spark:2.8.2

ARG docker_dir=/docker-spark-on-yarn

ADD . ${docker_dir}
RUN chmod +x ${docker_dir}/**/*.sh


# #USER CONFIG DATA PLACEHOLDER
# ENV HADOOP_CONF_DATA_PREDEF="" \
# 	HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/setup/pre_conf.ini" \
# 	HADOOP_CONF_DATA="" \
# 	HADOOP_CONF_DATA_FILES="" 
# 
# ENTRYPOINT ["/docker-spark/entrypoint.sh"]
