FROM andy/hadoop:2.8.2

ENV SPARK_VERSION 2.2.0
ARG docker_dir=/docker-spark

ARG install_path=/usr/lib/spark
ARG spark_conf_dir=/etc/spark
ARG spark_log_dir=/var/spark/log

ADD . ${docker_dir}
RUN chmod +x ${docker_dir}/**/*.sh && \
    mkdir -p ${spark_log_dir}

ENV SPARK_HOME=${install_path} \
	SPARK_CONF_DIR=${spark_conf_dir} \
	SPARK_LOG_DIR=${spark_log_dir} \
	PATH=${install_path}/bin:$PATH

ENV EXTRA_SETUP_SCRIPTS_PLACEHOLDER="${docker_dir}/setup/update_spark_runtime_env.sh"

## DOWNLOAD SPARK BINARY and EXTRACT
RUN /bin/sh -c "${docker_dir}/setup/extract_spark.sh" && \
	/bin/sh -c "${docker_dir}/setup/update_spark_env.sh" && \
	/bin/sh -c "${docker_dir}/setup/setup_spark.sh"

EXPOSE 4040

# #USER CONFIG DATA PLACEHOLDER
# ENV HADOOP_CONF_DATA_PREDEF="" \
# 	HADOOP_CONF_DATA_PREDEF_FILES="${docker_dir}/setup/pre_conf.ini" \
# 	HADOOP_CONF_DATA="" \
# 	HADOOP_CONF_DATA_FILES="" 
# 
# ENTRYPOINT ["/docker-spark/entrypoint.sh"]
