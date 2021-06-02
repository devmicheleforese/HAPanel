# OHAB-Panel-RPI4

## Enable Wifi on boot

place the file wpa_supplicant.conf in boot directory

Make sure you use LF newline character.

```terminal
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=IT

network={
 ssid="<Name of your wireless LAN>"
 psk="<Password for your wireless LAN>"
}
```
