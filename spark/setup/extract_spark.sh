#!/bin/bash

spark_filename="spark-${SPARK_VERSION}-bin-without-hadoop.tgz"
spark_filename_extracted="spark-${SPARK_VERSION}-bin-without-hadoop"
spark_res_filename="/docker-spark/res/${spark_filename}"
spark_tmp_filename="/tmp/${spark_filename}"
spark_url="https://www.apache.org/dyn/closer.lua/spark/spark-${SPARK_VERSION}/${spark_filename}"

echo "Prepare ${spark_filename}"
if [ -e "${spark_res_filename}" ] ; then
	echo "  mv ${spark_res_filename} ${spark_tmp_filename}"
	mv ${spark_res_filename} ${spark_tmp_filename}
else
	echo "  curl -fSL ${spark_url} -o ${spark_tmp_filename}"
	curl -fSL "${spark_url}" -o "${spark_tmp_filename}"
fi

tar -zxf ${spark_tmp_filename} -C /tmp
mv /tmp/${spark_filename_extracted} `dirname ${install_path}`
rm ${spark_tmp_filename}

ln -s /usr/lib/${spark_filename_extracted} ${install_path}
# rm -rf ${install_path}/share/doc
