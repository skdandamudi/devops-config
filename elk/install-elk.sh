
#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

 

yum remove -y java

yum install -y java-1.8.0-openjdk-devel


wget -O /tmp/elasticsearch.rpm https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.3.2.rpm

rpm --install /tmp/elasticsearch.rpm

chkconfig --add elasticsearch

wget  -O /tmp/kibana.rpm https://artifacts.elastic.co/downloads/kibana/kibana-6.3.2-x86_64.rpm
 
rpm --install /tmp/kibana.rpm

chkconfig --add kibana
