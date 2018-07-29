
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

chkconfig postgresql96 on


service postgresql96 initdb

sleep 3

service postgresql96 start

sleep 5





wget -O /tmp/pg.sql https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/pg.sql


echo 'Create kong DB.....'
sudo -u postgres psql -f /tmp/pg.sql > /tmp/pgsql.log



wget -O /tmp/pg_hba.conf https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/pg_hba.conf

mv /tmp/pg_hba.conf /var/lib/pgsql96/data/pg_hba.conf

chown postgres:postgres /var/lib/pgsql96/data/pg_hba.conf

service postgresql96 stop

sleep 5

service postgresql96 start


sleep 3
echo 'Instaling kong .....'
wget -O kong.aws.rpm https://bintray.com/kong/kong-community-edition-aws/download_file?file_path=dists/kong-community-edition-0.13.0.aws.rpm


yum install -y kong.aws.rpm --nogpgcheck

wget -O /tmp/kong.conf.default https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/kong.conf.default
mv /tmp/kong.conf.default /etc/kong/kong.conf.default

# Run migrations and start kong
/usr/local/bin/kong migrations up -c /etc/kong/kong.conf.default
/usr/local/bin/kong start -c /etc/kong/kong.conf.default
/usr/local/bin/kong health


wget -O /tmp/nvm.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/kong/install-nvm.sh
chmod 755 /tmp/nvm.sh

/tmp/nvm.sh

su - ec2-user -c "npm install forever -g"

su - ec2-user -c "git clone https://github.com/pantsel/konga.git"
su - ec2-user -c "cd konga; npm install; forever start app.js"

su - ec2-user -c "npm install -g kong-dashboard"
