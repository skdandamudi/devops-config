#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

groupadd -g 1100 keycloak
useradd -u 1100 -g 1100 keycloak

echo "keycloak   ALL=(ALL:ALL) ALL" >> /etc/sudoers

wget -O /tmp/keycloak.zip https://downloads.jboss.org/keycloak/4.1.0.Final/keycloak-4.1.0.Final.zip

unzip /tmp/keycloak.zip -d /opt

mv /opt/keycloak-4.1.0.Final /opt/keycloak

chown -R keycloak:keycloak /opt/keycloak

wget -O /opt/keycloak/start.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/keycloak/start.sh

chmod 755 /opt/keycloak/start.sh 

chown -R keycloak:keycloak /opt/keycloak



sudo  -u keycloak /opt/keycloak/start.sh 
