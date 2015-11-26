#!/bin/bash

################## install java and wget  ####################
yum clean all
yum install -y java-1.7.0-openjdk wget

################## install Cloudera RPM  ####################
wget archive.cloudera.com/cdh5/one-click-install/redhat/6/x86_64/cloudera-cdh-5-0.x86_64.rpm
yum -y --nogpgcheck localinstall cloudera-cdh-5-0.x86_64.rpm

################## install packages  ####################
yum -y install hadoop-conf-pseudo hue hue-plugins sqoop

################## Copy conf files  ####################
cp /vagrant/conf/core-site.xml /etc/hadoop/conf/core-site.xml
cp /vagrant/conf/hdfs-site.xml /etc/hadoop/conf/hdfs-site.xml
cp /vagrant/conf/mapred-site.xml /etc/hadoop/conf/mapred-site.xml
cp /vagrant/conf/yarn-site.xml /etc/hadoop/conf/yarn-site.xml

################## Create necessary dirs  ####################
mkdir /var/hadoop
chmod 777 -R /var/hadoop
mkdir /var/hadoop/var/hadoop/hadoop-datanode
chmod 777 -R /var/hadoop/var/hadoop/hadoop-datanode
mkdir /var/hadoop/var/hadoop/hadoop-namenode
chmod 777 -R /var/hadoop/var/hadoop/hadoop-namenode

################## format namenode  ####################
hdfs namenode -format

chmod 777 -R /var/hadoop/hadoop-namenode

################## Start hadoop  ####################
service hadoop-hdfs-namenode start
service hadoop-hdfs-datanode start

################## Create files in Hadoop  ####################
hdfs dfs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate
hdfs dfs -chown -R mapred:mapred /tmp/hadoop-yarn/staging
hdfs dfs -chmod -R 1777 /tmp
hdfs dfs -mkdir -p /var/log/hadoop-yarn
hdfs dfs -chown yarn:mapred /var/log/hadoop-yarn

################## Start YARN  ####################
service hadoop-yarn-resourcemanager start
service hadoop-yarn-nodemanager start
service hadoop-mapreduce-historyserver start

HADOOP_USER_NAME=hdfs hdfs dfs -mkdir -p /user/hdfs
HADOOP_USER_NAME=hdfs hdfs dfs -chown hdfs /user/hdfs
