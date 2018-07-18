#!/bin/bash -eu

set -o pipefail

yum -y update
yum -y install git openssh-client curl unzip bash ttf-dejavu coreutils tini gcc gcc-c++ make 
yum install -y epel-release wget openssl

yum remove -y java

yum install -y java-1.8.0-openjdk-devel

groupadd -g 1000 jenkins
useradd -u 1000 -g 1000 jenkins

echo "jenkins   ALL=(ALL:ALL) ALL" >> /etc/sudoers

#install software

mkdir -p /opt/jenkins/bin
mkdir -p /var/jenkins /var/jenkins/data /var/jenkins/logs
 
chown -R jenkins:jenkins /opt/jenkins
chown -R jenkins:jenkins /var/jenkins
 

export JENKINS_VERSION=2.121.2
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dhudson.footerURL=http://navitas-tech.com"

export JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

wget -O /opt/jenkins/jenkins.war $JENKINS_URL
wget -O /opt/jenkins/bin/start-jenkins.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/start-jenkins.sh
wget -O /opt/jenkins/bin/stop-jenkins.sh https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/stop-jenkins.sh
wget -O /var/jenkins/data/plugins.txt https://raw.githubusercontent.com/navitastech-rfad/devops-config/master/jenkins/plugins.txt


chown -R jenkins:jenkins /opt/jenkins

chmod  755 /opt/jenkins/bin/*.sh

sudo  -u jenkins /opt/jenkins/bin/stop-jenkins.sh

sudo  -u jenkins /opt/jenkins/bin/start-jenkins.sh

wget -O /opt/jenkins/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar

while read plugin; do
  echo $plugin
  java -jar /opt/jenkins/jenkins-cli.jar -s http://localhost:8080/jenkins/ install-plugin $plugin
done < /var/jenkins/data/plugins.txt


