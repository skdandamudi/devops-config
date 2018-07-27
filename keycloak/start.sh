#!/bin/bash

INSTANCEIP=$(curl -s -m 60 http://169.254.169.254/latest/meta-data/local-ipv4)

nohup /opt/keycloak/bin/standalone.sh -b $INSTANCEIP >> /tmp/keycloak_std.log 2>&1 &
