!/bin/ash

/usr/sbin/mosquitto --config-file /mosquitto/config/mosquitto.conf

exec "$@"