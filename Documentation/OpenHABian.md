# openHABian install

## Flash openHABian

1. Download stable openHABian from this [link](https://www.openhab.org/download/)
2. Flash to a MicroSD card with [Etcher](https://www.balena.io/etcher/)

## Modify the OS to create a bootable OS for the Panel

1. Follow [this](https://www.acmesystems.it/CM3-PANEL-7-BASIC_microsd) instruction to create a bootable OS per the Panel
2. Write the image to your SD card using Etcher
3. Insert the SD card in your device, make sure you have connectivity, either by plugging an Ethernet cable or configuring the Wi-Fi, and boot!
4. Wait between 15 and 45 minutes for openHABian to perform its initial setup
5. If you chose to use Wi-Fi, and there's a problem, openHABian will launch a hotspot. Connect to it if necessary
6. Navigate with a web browser to [http://openhabian:8080](http://openhabian:8080)
7. Continue by following the tutorial to get started

## Activate SSH

1. Enter sudo `raspi-config` in a terminal window
2. Select `Interfacing Options`
3. Navigate to and select `SSH`
4. Choose `Yes`
5. Select `Ok`
6. Choose `Finish`

or use `systemctl`.

```terminal
sudo systemctl enable ssh
sudo systemctl start ssh
```

## Install openHAB

1. Install OpenJDK

   ```terminal
   sudo apt update
   sudo apt install -y default-jdk
   sudo apt install openjdk-8-jdk
   ```

2. Follow [this](https://www.openhab.org/download/) instruction.
3. Activate openHAB on startup

   ```terminal
   sudo /bin/systemctl enable openhab.service
   sudo /bin/systemctl start openhab.service
   ```

## Install Mosquitto

1. Install Mosquitto

   ```terminal
   sudo apt update
   sudo apt install -y mosquitto mosquitto-clients
   ```

2. Make Mosquitto auto start on boot up:

   ```terminal
   sudo systemctl enable mosquitto.service
   sudo systemctl start mosquitto.service
   ```

3. Copy config file

   ```file
   # Place your local configuration in /etc/mosquitto/conf.d/
   #
   # A full description of the configuration file is at
   # /usr/share/doc/mosquitto/examples/mosquitto.conf.example

   pid_file /var/run/mosquitto.pid

   persistence true
   persistence_location /var/lib/mosquitto/

   log_dest file /var/log/mosquitto/mosquitto.log

   listener 1883
   password_file /etc/mosquitto/mosquitto.passwd
   ```

4. Make a password file

   ```terminal
   sudo mosquitto_passwd -c /etc/mosquitto/mosquitto.passwd mosquitto_openhab
   ```

5. Config file setup

   ```terminal
   sudo mosquitto_passwd -c /etc/mosquitto/mosquitto.passwd mosquitto_openhab
   ```
