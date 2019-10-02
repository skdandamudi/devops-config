#!/bin/bash

nohup /usr/lib/jvm/jre-11/bin/java -Djenkins.install.runSetupWizard=false -DJENKINS_HOME=/var/jenkins/data -Xmx1024m -XX:MaxPermSize=2048m -jar /opt/jenkins/jenkins.war --httpPort=8080 >> /var/jenkins/logs/jenkins_std.log 2>&1 &
