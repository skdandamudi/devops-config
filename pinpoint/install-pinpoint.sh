#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel



wget -O /tmp/hbase.tar.gz http://archive.apache.org/dist/hbase/1.2.6/hbase-1.2.6-bin.tar.gz

tar -xvf /tmp/hbase.tar.gz -C /opt/
 
/opt/habse/start-hbase.sh

yum install tomcat8 


service tomcat8 start

sleep 10

su - tomcat -c  "wget -O /usr/share/tomcat8/webapps/ROOT.war  https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-web-1.7.3.war"

sleep 10

su - tomcat -c "wget -O /usr/share/tomcat8/webapps/collector.war https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-collector-1.7.3.war"

sleep 10
