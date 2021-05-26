#!/bin/ash

set -e

# Fix write permissions for mosquitto directories
user="$(id -u)"
if [ "$user" = '0' ]; then
	[ -d "/mosquitto" ] && chown -R mosquitto:mosquitto /mosquitto || true
fi

mkdir -p /var/run/mosquitto && chown --no-dereference --recursive mosquitto /var/run/mosquitto

mosquitto_passwd -b /mosquitto/config/mosquitto.passwd ${MOSQUITTO_USERNAME} ${MOSQUITTO_PASSWORD}

mosquitto --config-file /mosquitto/config/mosquitto.conf

exec "$@"