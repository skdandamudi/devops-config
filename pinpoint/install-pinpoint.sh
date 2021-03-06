#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

groupadd -g 1009 tomcat
useradd -u 1009 -g 1009 tomcat

echo "tomcat   ALL=(ALL:ALL) ALL" >> /etc/sudoers

wget -O /tmp/tomcat.zip  https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.zip 


unzip /tmp/tomcat.zip -d /opt

mv /opt/apache-tomcat-8.5.29 /opt/tomcat

chown -R tomcat:tomcat /opt/tomcat

chmod 777 /opt/tomcat/bin/*.sh

rm -rf /opt/tomcat/webapps/*


wget -O /tmp/hbase.tar.gz http://archive.apache.org/dist/hbase/1.2.6/hbase-1.2.6-bin.tar.gz

tar -xvf /tmp/hbase.tar.gz -C /opt/
 
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk"

/opt/hbase-1.2.6/bin/start-hbase.sh

sleep 10

su - tomcat -c  "wget -O /opt/tomcat/webapps/ROOT.war  https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-web-1.7.3.war"

sleep 10

su - tomcat -c "wget -O /opt/tomcat/webapps/collector.war https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-collector-1.7.3.war"

sleep 10

su - tomcat -c "/opt/tomcat/bin/startup.sh"
