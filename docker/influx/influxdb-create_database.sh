#!/bin/bash
set -e

influx user create -n ${INFLUXDB_USER} -p ${INFLUXDB_USER_PASSWORD}

influx query



CREATE DATABASE "openhab3" WITH DURATION 31d REPLICATION 1;

CREATE USER openhab WITH PASSWORD "openhab"
GRANT ALL ON openhab3 TO openhab


exec "$@"