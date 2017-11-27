# Docker-hadoop

This project contains Dockerfiles for setting up a basic hadoop cluster.

## Images

The project contains hadoop modules in corresponding directories:

### Basic Hadoop image:
* hadoop (All other images are built base on this image.)

### HDFS images:
* namenode
* datanode

### YARN images:
* resourcemanager
* nodemanager

### Mapreduce images:
* mapred
* historyserver

### Hadoop all-in-one image:
* single

### Spark image:
* spark

## Hadoop Configuration:
Set container's hadoop configuration by setting envirnment HADOOP_CONF_DATA

## Example docker-compose.yml

There is a docker-compose.yml file provided to run demo examples
Run with:
```
docker-compose up
```
Destory with
```
docker-compose down
```

Web ui
| Node type           | url                    |
| :------------------ |:-----------------------|
| namenode:           | http://localhost:50070 |
| datanode:           | http://localhost:50075 |
| resourcemanager:    | http://localhost:8088  |
| nodemanager:        | http://localhost:8042  |
| job historyserver:  | http://localhost:19888 |
| spark historyserver | http://localhost:18080 |


