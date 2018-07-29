
#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

 

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

wget -O /etc/yum.repos.d/elasticsearch.repo  https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/elk/elasticsearch.repo
wget -O /etc/yum.repos.d/kibana.repo  https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/elk/kibana.repo
wget -O /etc/yum.repos.d/logstash.repo  https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/elk/logstash.repo

yum intall -y elasticsearch kibana logstash

chkconfig --add elasticsearch

chkconfig --add kibana

chkconfig --add logstash

service elasticsearch start

