# OpenHab on CPanel HAPanel

## Install Raspbian OS

1. Go download the Raspbian OS

## Modify the OS to create a bootable OS for the Panel

1. Follow [this](https://www.acmesystems.it/CM3-PANEL-7-BASIC_microsd) instruction to create a bootable OS per the Panel
2. Write the image to your SD card using Etcher
3. Insert the SD card in your device, make sure you have connectivity, either by plugging an Ethernet cable or configuring the Wi-Fi, and boot!
4. Wait between 15 and 45 minutes for openHABian to perform its initial setup
5. If you chose to use Wi-Fi, and there's a problem, openHABian will launch a hotspot. Connect to it if necessary
6. Navigate with a web browser to [http://openhabian:8080](http://openhabian:8080)
7. Continue by following the tutorial to get started

## openHAB Docker

1. Create the `openhab` user and group

   ```terminal
   sudo groupadd -g 9001 openhab
   sudo useradd -g 9001 -r -s /sbin/nologin openhab
   ```

2. Add your regular user to the `openhab` group

   ```terminal
   sudo usermod -a -G openhab <user>
   sudo usermod -a -G openhab pi
   ```

3. Create the openHAB, inflixdb, grafana, mosquito, nginx directories

   ```terminal
   sudo mkdir -p ~/HAPanel/openHAB/{conf,userdata,addons,services}
   sudo mkdir -p ~/HAPanel/influxdb/{db_data}
   sudo mkdir -p ~/HAPanel/grafana/{data,logs,plugins,provisioning}
   sudo mkdir -p ~/HAPanel/mosquitto/{data,logs}

   sudo chown -R openhab:openhab ~/HAPanel/openHAB
   ```

## Mosquitto credentials

```terminal
sudo docker container ls
sudo docker exec -ti mosquitto /bin/sh

mosquitto_passwd -c /mosquitto/config/mosquitto.passwd mosquitto_openhab
```

1. Config file for mosquitto

```terminal
cat << EOF > /mosquitto/config/mosquitto.conf
persistence true
persistence_location /mosquitto/data/

log_dest file /mosquitto/log/mosquitto.log

allow_anonymous false
listener 1883
password_file /mosquitto/config/mosquitto.passwd
EOF

```

2. Set config file

```terminal
mosquitto --config-file /mosquitto/config/mosquitto.conf
```

3. restart docker container

   ```terminal
   sudo docker container stop mosquitto
   sudo docker container restart mosquitto
   ```

4. To subscribe to the topic `test`

   ```terminal
   mosquitto_sub -t test
   ```

5. [optional] Install tree utility

   ```terminal
   sudo apt-get install tree
   ```

## Install Docker

1. Install Docker for RasberryPi from [here](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)

2. Download Docker script

   ```terminal
   sudo curl -fsSL https://get.docker.com -o ~/get-docker.sh
   ```

3. Exec docker script

   ```terminal
   sudo sh ~/get-docker.sh
   ```

4. Convenient Command

   ```terminal
   sudo curl -fsSL https://get.docker.com -o ~/get-docker.sh && sudo sh ~/get-docker.sh
   ```

5. [optional] Add permission to `pi` User to run Docker Commands without root permission

   ```terminal
   sudo usermod -aG docker pi
   ```

   - Now reboot the device to admit changes

## Install docker-compose

1. Run those commands for dependences

   ```terminal
   sudo apt-get install -y libffi-dev libssl-dev
   sudo apt-get install -y python3 python3-pip
   sudo apt-get remove python-configparser
   ```

2. Install Docker Compose

   ```terminal
   sudo pip3 -v install docker-compose
   ```

3. Convenient Command

   ```terminal
   sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip && sudo apt-get remove python-configparser && sudo pip3 -v install docker-compose
   ```

## Install Docker and docker-compose

Convenient script:

```terminal
sudo curl -fsSL https://get.docker.com -o ~/get-docker.sh && sudo sh ~/get-docker.sh && sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip && sudo apt-get remove python-configparser && sudo pip3 -v install docker-compose
```

## OpenHAB Docker Suite

### Install

Create al least one htpasswd user

```terminal
mkdir -p ~/HAPanel/nginx
echo -n 'user01:' >> ~/HAPanel/nginx/htpasswd
openssl passwd -apr1 >> ~/HAPanel/nginx/htpasswd
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ~/HAPanel/nginx/nginx-ssl.key -out ~/HAPanel/nginx/nginx-ssl.crt
```

Then start all containers by executing:

```terminal
docker-compose up -d
```

### Initialize InfluxDB

The current Docker Image for InfluxDB doesn't support automatic creation of users and databases, so create one for OpenHAB manually:

```terminal
docker exec -it hma_influxdb influx
```

Inside the container execute the following queries:

```terminal
CREATE DATABASE openhab
exit
```

## Update

```terminal
docker-compose pull
docker-compose down
docker-compose up -d
```

## Backup

```terminal
docker exec -i -t hma_influxdb /bin/bash /backups/backup-influxdb.bash
docker exec -i -t hma_openhab /bin/bash /backups/backup-openhab.bash
docker exec -i -t hma_grafana /bin/bash /backups/backup-grafana.bash
```

## Maintenance

### Clean Up when things go wrong

Delete the contents of `/opt/openhab/userdata/cache` and `/opt/openhab/userdata/tmp`

```terminal
rm -rf /opt/openhab/userdata/cache
rm -rf /opt/openhab/userdata/tmp
```

### OpenHAB CLI

Access the OpenHAB command line tool inside the Docker container from your host system:

```terminal
docker exec -it openhab /openhab/runtime/bin/client

Logging in as openhab
Password:  PASSWORD IS habopen

                           _   _     _     ____
   ___   ___   ___   ___  | | | |   / \   | __ )
  / _ \ / _ \ / _ \ / _ \ | |_| |  / _ \  |  _ \
 | (_) | (_) |  __/| | | ||  _  | / ___ \ | |_) )
  \___/|  __/ \___/|_| |_||_| |_|/_/   \_\|____/
       |_|       3.1.0-SNAPSHOT - Build #2099

Use '<tab>' for a list of available commands
and '[cmd] --help' for help on a specific command.
To exit, use '<ctrl-d>' or 'logout'.

openhab>
```

Accessing the OpenHab logs from the CLI:

```terminal
openhab> log:tail
```

### Restore settings from previous Backup

#### InfluxDB

```terminal
docker-compose stop
docker run -it --rm --volumes-from hma_influxdb influxdb /bin/bash
tar xf /backups/2017-03-05T18-23-52-influxdb.tar.gz -C ~
influxd restore -metadir /var/lib/influxdb/meta ~/2017-03-05T18-23-52-influxdb
influxd restore -database openhab -datadir /var/lib/influxdb/data ~/2017-03-05T18-23-52-influxdb
chown -R influxdb:influxdb /var/lib/influxdb
exit
docker-compose start
```

### Upgrading

1. Stop the container
2. Delete the container
3. Pull down the latest image
4. Create a `userdata/backup` folder f one does not exist
5. Create a full backup of userdata as a dated tar file saved to `userdata/backup`. The `userdata/backup` folder is excluded from this backup.
6. Show update notes and warnings.
7. Execute update pre/post commands.
8. Copy userdata system files from `dist/userdata/etc` to `userdata/etc`.
9. Update KAR files in `addons`.
10. Delete the contents of `userdata/cache` and `userdata/tmp`.

### Upgrade InfluxDB

1. Stop the openHAB container

   ```terminal
   docker container stop openHAB
   ```

2. Connect with Influxdb container

   ```terminal
   docker exec -it influxdb /bin/bash
   ```
