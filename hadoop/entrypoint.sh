#!/bin/bash
this_dir=`dirname $0`

source ${this_dir}/set_properties.sh
source ${this_dir}/create_users.sh

echo "Start ssh service"
sudo service ssh start

create_users "$ADDITIONAL_USERS"

echo "Set Hadoop properties "
# set_property "core:hadoop.tmp.dir=/tmp/hadoop_tmp/"
set_properties_files "$HADOOP_CONF_DATA_PREDEF_FILES"
set_properties $HADOOP_CONF_DATA_PREDEF

set_properties_files "$HADOOP_CONF_DATA_FILES"
set_properties "$HADOOP_CONF_DATA"

echo Run CMD: $@
exec $@

