# OHAB-Panel-RPI4

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

## Enable ssh

Create a `ssh` file in the boot directory

## Enable Wifi on boot

Place the file wpa_supplicant.conf in boot directory

Make sure you use LF newline character.

```terminal
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=IT

network={
  ssid="<Name of your wireless LAN>"
  psk="<Password for your wireless LAN>"
  key_mgmt=WPA-PSK
}
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
sudo curl -fsSL https://get.docker.com -o ~/get-docker.sh && sudo sh ~/get-docker.sh && sudo rm -f ~/get-docker.sh && sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip && sudo apt-get remove python-configparser && sudo pip3 -v install docker-compose
```

## Install Git

```terminal
sudo apt update
sudo apt install git
```

## Download HAPanel docker files

```terminal
cd ~
git clone https://github.com/devmicheleforese/HAPanel.git
```

## Initialize Docker containers

```terminal
cd HAPanel
sudo docker-compose up -d
```

## [Highly raccommended] Mosquitto Authentication

1. exec in docker container

   ```terminal
   sudo docker exec -it mosquitto sh
   ```

2. Create a User for Authentication

   ```terminal
   mosquitto_passwd -c /mosquitto/config/mosquitto.passwd <user_name>
   ```

   example:

   ```terminal
   mosquitto_passwd -c /mosquitto/config/mosquitto.passwd mosquitto_openhab
   ```

3. Enter the password

   ```terminal
   mosquitto_openhab_password
   ```

4. Config file for using the new .passwd file newly created

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

   - `persistence true`: sets the mosquitto server for persistence data
   - `persistence_location /mosquitto/data/`: sets the location for the persistence data
   - `log_dest file /mosquitto/log/mosquitto.log`: sets the location for the mosquitto log output
   - `allow_anonymous false`: sets the server for denying anonymous subscription
   - `listener 1883`: sets the server for expose the 1883 port
   - `password_file /mosquitto/config/mosquitto.passwd`: sets the location for the user:password file (encrypted)

5. Set config file

   ```terminal
   mosquitto --config-file /mosquitto/config/mosquitto.conf
   ```

6. restart docker container

   ```terminal
   sudo docker container stop mosquitto
   sudo docker container restart mosquitto
   ```
