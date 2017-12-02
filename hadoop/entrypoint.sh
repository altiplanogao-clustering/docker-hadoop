#!/bin/bash
this_dir=`dirname $0`

source ${this_dir}/set_properties.sh
source ${this_dir}/create_users.sh

echo "Start ssh service"
sudo service ssh start

hadoop_var_dirs=( `dirname $HADOOP_LOG_DIR` $HADOOP_LOG_DIR )
for hvd in ${hadoop_var_dirs[*]}
do
	chown hadoop:hadoop ${hvd}
	chmod 0775 ${hvd}
done

create_users "$ADDITIONAL_USERS"

echo "Set Hadoop properties "
# set_property "core:hadoop.tmp.dir=/tmp/hadoop_tmp/"
set_properties_files "$HADOOP_CONF_DATA_PREDEF_FILES"
set_properties $HADOOP_CONF_DATA_PREDEF

set_properties_files "$HADOOP_CONF_DATA_FILES"
set_properties "$HADOOP_CONF_DATA"

${this_dir}/setup/run_extra_setup.sh

echo Run CMD: $@
exec $@

