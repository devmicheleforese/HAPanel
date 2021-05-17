# OpenHab on CPanel

## Install Openhabian distro

1. Go to [openHab Download](https://www.openhab.org/download/)
2. Follow instruction on the site

   - Download and Install [Etcher](https://www.balena.io/etcher/)
   - Download the openHABian image (`.img.xz` file) for your system from [here](https://github.com/openhab/openhabian/releases/latest)

## Modify the OS to create a bootable OS for the Panel

1. Follow [this](https://www.acmesystems.it/CM3-PANEL-7-BASIC_microsd) instruction to create a bootable OS per the Panel
2. Write the image to your SD card using Etcher
3. Insert the SD card in your device, make sure you have connectivity, either by plugging an Ethernet cable or configuring the Wi-Fi, and boot!
4. Wait between 15 and 45 minutes for openHABian to perform its initial setup
5. If you chose to use Wi-Fi, and there's a problem, openHABian will launch a hotspot. Connect to it if necessary
6. Navigate with a web browser to [http://openhabian:8080](http://openhabian:8080)
7. Continue by following the tutorial to get started

## Login

1. Login with this credetial:

```terminal
user: openhabian
password: openhabian
```

## Install Docker

1. Install Docker for RasberryPi from [here](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)
2. Execute this commands

   ```terminal
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   ```

3. [optional] Add permission to openhabian User to run Docker Commands without root permission

   ```terminal
   sudo usermod -aG docker openhabian
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

## Install Influxdb

1. Create a directory from user home with those commands

   ```terminal
   mkdir ~/openHAB/docker-influxdb
   ```

2. Download the docker-compose script from [here](https://github.com/devmicheleforese/docker-influxdb)

   - Use scp to copy file through ssh

     ```terminal
     scp <source> <destination>
     ```

     Example:

     ```terminal
     scp /path/to/docker-compose.yaml openhabian@<PanelIP>:~/openHAB/docker-influxdb
     ```

3. Enter in the directory

   ```terminal
   cd ~/openHAB/docker-influxdb
   ```

4. Exec those commands for create a docker instance of the influx database system

   ```terminal
   sudo docker-compose up -d
   ```

## Create Influx database

1. Retrive docker container ID trough

   ```terminal
   docker container ls
   ```

2. Exec bash commands in docker container

   ```terminal
   docker exec -it <docker container ID> /bin/bash
   ```

3. Enter in influx database

   ```temrminal
   influx
   ```

4. Create the Databse

   ```terminal
   create database openhab3
   ```

   - To verify:

   ```terminal
   show databases;
   ```

5. Open Database

```terminal
use openhab3
```

6. Create Admin User

```terminal
create user admin with password 'openhab' with all privileges
```

7. Create influxdb config file

```terminal
influxd config > /var/lib/influxdb/influxdb.conf
```

[comment]: # "Docker Section"

```

```
