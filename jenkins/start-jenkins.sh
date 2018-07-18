#!/bin/bash

nohup java -Djenkins.install.runSetupWizard=false -DJENKINS_HOME=/var/jenkins/data -Xmx1024m -XX:MaxPermSize=2048m -jar /opt/jenkins/jenkins.war --httpPort=8080} --prefix=/jenkins >> /var/jenkins/logs/jenkins_std.log 2>&1 &
