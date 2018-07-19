#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel



wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo

yum -y install sonar

yum -y  install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs


chkconfig sonar on
chkconfig postgresql on 
service postgresql initdb


