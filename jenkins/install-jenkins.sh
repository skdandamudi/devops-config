#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make jq
yum install -y epel-release wget openssl

yum install -y docker

service docker start


yum remove -y java

yum install -y java-1.8.0-openjdk-devel

groupadd -g 1100 jenkins
useradd -u 1100 -g 1100 jenkins

echo "jenkins   ALL=(ALL:ALL) ALL" >> /etc/sudoers


usermod -a -G docker jenkins
#install software

mkdir -p /opt/jenkins/bin
mkdir -p /var/jenkins /var/jenkins/data /var/jenkins/logs /var/jenkins/data/plugins

 

export JENKINS_VERSION=2.121.2
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.footerURL=http://navitas-tech.com"

export JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

wget -O /opt/jenkins/jenkins.war $JENKINS_URL
wget -O /opt/jenkins/bin/start-jenkins.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/start-jenkins.sh
wget -O /opt/jenkins/bin/stop-jenkins.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/stop-jenkins.sh
wget -O /var/jenkins/data/plugins.txt https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/plugins.txt


 
chown -R jenkins:jenkins /opt/jenkins
chown -R jenkins:jenkins /var/jenkins

chmod  755 /opt/jenkins/bin/*.sh

sudo  -u jenkins /opt/jenkins/bin/stop-jenkins.sh

sleep 10


plugin_dir=/var/jenkins/data/plugins
 

while read plugin; do


if [ -f ${plugin_dir}/$plugin.hpi -o -f ${plugin_dir}/$plugin.jpi ]; then
    echo "Skipped: $plugin (already installed)"
  else
    echo "Installing: $plugin"
    curl -L --silent --output ${plugin_dir}/$plugin.hpi  https://updates.jenkins-ci.org/latest/$plugin.hpi
  fi

done < /var/jenkins/data/plugins.txt

chown -R jenkins:jenkins /var/jenkins

#==========
# Gradle
#==========
curl -skL -o /tmp/gradle-bin.zip https://services.gradle.org/distributions/gradle-4.7-bin.zip && \
    unzip -q /tmp/gradle-bin.zip -d /usr/share && \
    mv /usr/share/gradle-4.7 /usr/share/gradle && \
    ln -sf /usr/share/gradle/bin/gradle /usr/bin/gradle
    
#==========
# Maven
#==========


curl -fsSL http://archive.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-3.5.3 /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
  
  
 #==========
# Jmeter
#==========

mkdir -p /opt/jmeter \
      && wget -O - "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-4.0.tgz" \
      | tar -xz --strip=1 -C /opt/jmeter

sudo  -u jenkins /opt/jenkins/bin/stop-jenkins.sh

sudo  -u jenkins /opt/jenkins/bin/start-jenkins.sh

sleep 5


wget -O /var/jenkins/data/config.groovy https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/config.groovy

yum install -y docker
service docker start
usermod -a -G docker jenkins

wget -O /tmp/nvm.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/install_nvm.sh
chmod 755 /tmp/nvm.sh

/tmp/nvm.sh

sudo  -u jenkins echo "aws ecr get-login --region us-east-1 | sed -e 's/-e none//g'" > /home/jenkins/ecr-login.sh
chmod 755 /home/jenkins/ecr-login.sh



curl https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy | sudo tee /usr/bin/ecs-deploy

chmod +x /usr/bin/ecs-deploy



wget -O /tmp/clean-docker.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/scripts/clean-docker.sh
chmod 755 /tmp/clean-docker.sh


