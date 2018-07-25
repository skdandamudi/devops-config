
#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl epel-release

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

echo '* soft nofile 65000' >> /etc/security/limits.conf
echo '* hard nofile 65000' >> /etc/security/limits.conf

rpm -Uvh https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-x86_64/pgdg-ami201503-95-9.5-3.noarch.rpm

yum -y install postgresql95  postgresql95-server

service postgresql95 initdb

service postgresql95 start





wget -O /tmp/pg.sql https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/pg.sql


wget -O kong-community-edition-0.14.0.aws.rpm https://bintray.com/kong/kong-community-edition-aws/download_file?file_path=dists/kong-community-edition-0.14.0.aws.rpm


yum install -y kong-community-edition-0.14.0.aws.rpm --nogpgcheck



wget -O /tmp/pg_hba.conf https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/pg_hba.conf

mv /tmp/pg_hba.conf /var/lib/pgsql95/data/pg_hba.conf
chown postgres:postgres /var/lib/pgsql95/data/pg_hba.conf

service postgresql95 stop
service postgresql95 start
