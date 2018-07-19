#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

groupadd -g 1000 sonar
useradd -u 1000 -g 1000 sonar

echo "sonar   ALL=(ALL:ALL) ALL" >> /etc/sudoers
