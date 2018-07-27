#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel


yum install tomcat8 


service tomcat8 start


wget -O /usr/share/tomcat8/webapps/pinpoint-collector-1.7.3.war https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-collector-1.7.3.war 

wget -O /usr/share/tomcat8/webapps/pinpoint-web-1.7.3.war  https://github.com/naver/pinpoint/releases/download/1.7.3/pinpoint-web-1.7.3.war
