#!/bin/bash

nohup /opt/keycloak/bin/standalone.sh >> /tmp/keycloak_std.log 2>&1 &
