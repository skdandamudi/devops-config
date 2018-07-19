#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

wget -O /tmp/keycloak.zip https://downloads.jboss.org/keycloak/4.1.0.Final/keycloak-4.1.0.Final.zip
