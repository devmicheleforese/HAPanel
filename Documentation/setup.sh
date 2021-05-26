!/bin/ash

sudo systemctl enable ssh
sudo systemctl start ssh


sudo apt update
sudo apt install -y default-jdk
sudo apt install openjdk-8-jdk

# openHAB
wget -qO - 'https://openhab.jfrog.io/artifactory/api/gpg/key/public' | sudo apt-key add -

sudo apt-get install apt-transport-https
echo 'deb https://openhab.jfrog.io/artifactory/openhab-linuxpkg stable main' | sudo tee /etc/apt/sources.list.d/openhab.list
sudo apt-get update && sudo apt-get install openhab


sudo /bin/systemctl enable openhab.service
sudo /bin/systemctl start openhab.service

sudo apt update
sudo apt install -y mosquitto mosquitto-clients

sudo systemctl enable mosquitto.service
sudo systemctl start mosquitto.service

cat << EOF > /etc/mosquitto/conf.d/mosquitto.conf
persistence true
persistence_location /mosquitto/data/
log_dest file /mosquitto/log/mosquitto.log
EOF

/etc/mosquitto/conf.d/
# Place your local configuration in /etc/mosquitto/conf.d/
#
# A full description of the configuration file is at
# /usr/share/doc/mosquitto/examples/mosquitto.conf.example

pid_file /var/run/mosquitto.pid

persistence true
persistence_location /var/lib/mosquitto/

log_dest file /var/log/mosquitto/mosquitto.log

include_dir /etc/mosquitto/conf.d

listener 1883
password_file /etc/mosquitto/mosquitto.passwd

exec "$@"