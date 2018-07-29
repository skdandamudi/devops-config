
#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

 

yum remove -y java

yum install -y java-1.8.0-openjdk-devel


groupadd -g 1009 prometheus
useradd -u 1009 -g 1009 prometheus

echo "prometheus   ALL=(ALL:ALL) ALL" >> /etc/sudoers


wget -O /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.3.2/prometheus-2.3.2.linux-amd64.tar.gz

tar -xvf /tmp/prometheus.tar.gz -C /opt/

chown -R prometheus:prometheus /opt/prometheus

