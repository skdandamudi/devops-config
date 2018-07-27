#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel



wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo

yum -y install sonar

chkconfig sonar on

rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-x86_64/pgdg-ami201503-95-9.5-3.noarch.rpm

yum -y install postgresql95  postgresql95-server



service postgresql95 initdb

service postgresql95 start


chkconfig postgresql on 





wget -O /tmp/pg.sql https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/sonar/pg.sql

sudo -u postgres psql -f /tmp/pg.sql


wget -O /tmp/pg_hba.conf https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/sonar/pg_hba.conf

mv /tmp/pg_hba.conf /var/lib/pgsql95/data/pg_hba.conf

chown postgres:postgres /var/lib/pgsql95/data/pg_hba.conf

service postgresql95 stop
service postgresql95 start



service sonar start


