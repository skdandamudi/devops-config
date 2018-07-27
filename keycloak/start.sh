#!/bin/bash

nohup /opt/keycloak/bin/standalone.sh -b $HOSTIP >> /tmp/keycloak_std.log 2>&1 &
