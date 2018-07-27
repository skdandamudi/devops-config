
#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl epel-release

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

echo '* soft nofile 65000' >> /etc/security/limits.conf
echo '* hard nofile 65000' >> /etc/security/limits.conf


echo 'Installing postgresql.....'

rpm -Uvh  https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-6-x86_64/pgdg-ami201503-96-9.6-2.noarch.rpm

sleep 5

 
yum -y install postgresql96-server postgresql96-contrib postgresql96

echo 'Initialize  postgresql.....'

systemctl enable postgresql-9.6.service


service postgresql-9.6 initdb

sleep 3

service postgresql-9.6 start

sleep 5





wget -O /tmp/pg.sql https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/sonar/pg.sql


echo 'Create Sonar DB.....'
sudo -u postgres psql -f /tmp/pg.sql


s
wget -O /tmp/pg_hba.conf https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/sonar/pg_hba.conf

mv /tmp/pg_hba.conf /var/lib/pgsql/9.6/data/pg_hba.conf

chown postgres:postgres /var/lib/pgsql/9.6/data/pg_hba.conf

service postgresql-9.6 stop

sleep 5

service postgresql-9.6 start


sleep 3

echo 'Instaling Sonar .....'

groupadd -g 1009 sonar
useradd -u 1009 -g 1009 sonar

echo "sonar   ALL=(ALL:ALL) ALL" >> /etc/sudoers

wget -O /tmp/sonarqube-7.2.1.zip https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.2.1.zip

unzip /tmp/sonarqube-7.2.1.zip -d /opt

mv /opt/sonarqube-7.2.1 /opt/sonarqube

wget -O /opt/sonarqube/conf/sonar.properties  https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/sonar/sonar.properties


chown -R sonar:sonar /opt/sonarqube


su - sonar -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"




