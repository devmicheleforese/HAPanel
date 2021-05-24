# Google Home Assistant Setup

1. Go to OpenHAB - Misc and install the `openHAB Cloud Connector`
2. Get the UUID and Secret

   ```terminal
   UUID
     /var/lib/openhab/uuid
   Secret
     /var/lib/openhab/openhabcloud/secret
   ```

3. Go to Settings -> Other Services -> openHAB Cloud
4. Register to [openHAB Cloud](myopenhab.org)
5. Insert the UUID and the Secret
6. Go to Google Home
7. AddOn OpenHAB and login with openHAB account

## OpenHAB setup

For more info: [openHAB Google Assistant](https://www.openhab.org/docs/ecosystem/google-assistant/)

1. Choose a Thing and add a Metadata
   Google Assistant Class = Light, Switch, ...
   Name = Luce Cucina
   Room Hint = Kitchen
