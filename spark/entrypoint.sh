#!/bin/bash
this_dir=`dirname $0`

/docker-hadoop/entrypoint.sh

${this_dir}/setup/update_spark_runtime_env.sh

echo Run CMD: $@
exec $@
