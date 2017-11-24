#!/bin/bash
THIS_PATH=`dirname $0`


# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"
# echo "RUN SPARK ENTRYPOINT"

# sed -i 's|^export SPARK_DIST_CLASSPATH=.*$||g' $SPARK_CONF_DIR/spark-env.sh
# echo "export SPARK_DIST_CLASSPATH=$(hadoop --config ${HADOOP_CONF_DIR} classpath)" >> ${SPARK_CONF_DIR}/spark-env.sh

echo Run CMD: $@
exec $@

