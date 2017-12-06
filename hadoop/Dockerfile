# FROM debian:stretch-backports
FROM ubuntu:xenial

RUN apt-get clean && rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing \
    openjdk-8-jre-headless ca-certificates-java sudo ssh rsync \
    net-tools curl vim python iputils-ping unzip

    # && rm -rf /var/lib/apt/lists/*

ENV HADOOP_VERSION 2.8.2

ARG install_path=/usr/lib/hadoop
ARG hadoop_conf_dir=/etc/hadoop

ARG hadoop_var_dir=/var/hadoop
ARG hadoop_log_dir=/var/hadoop/log
ARG hadoop_yarn_log_dir=/var/hadoop/yarn/log
ARG hadoop_mapred_log_dir=/var/hadoop/mapred/log

ADD . /docker-hadoop
RUN chmod +x /docker-hadoop/**/*.sh && \
    mkdir -p ${hadoop_log_dir} && \
    mkdir -p ${hadoop_yarn_log_dir} && \
    mkdir -p ${hadoop_mapred_log_dir}

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ \
    HADOOP_HOME=${install_path} \
    HADOOP_PREFIX=${install_path} \
    HADOOP_HDFS_HOME=${install_path} \
    HADOOP_YARN_HOME=${install_path} \
    HADOOP_MAPRED_HOME=${install_path} \
    HADOOP_CONF_DIR=${hadoop_conf_dir} \
    PATH=${install_path}/bin/:$PATH

ENV    HADOOP_LOG_DIR=${hadoop_log_dir} \
    YARN_LOG_DIR=${hadoop_yarn_log_dir} \
    HADOOP_MAPRED_LOG_DIR=${hadoop_mapred_log_dir}

## DOWNLOAD HADOOP BINARY and EXTRACT
RUN /bin/sh -c "/docker-hadoop/setup/extract_hadoop.sh" && \
    /bin/sh -c "/docker-hadoop/setup/setup_hadoop.sh" && \
    /bin/sh -c "/docker-hadoop/setup/update_hadoop_env.sh"

#USER CONFIG DATA PLACEHOLDER
ENV HADOOP_CONF_DATA_PREDEF="" \
    HADOOP_CONF_DATA_PREDEF_FILES="" \
    HADOOP_CONF_DATA="" \
    HADOOP_CONF_DATA_FILES="" \
    EXTRA_SETUP_SCRIPTS_PLACEHOLDER="" \
    ADDITIONAL_USERS=""

ENTRYPOINT ["/docker-hadoop/entrypoint.sh"]
