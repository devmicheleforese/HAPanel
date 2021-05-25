# Tasmota Install

1. Install esptool.py

   ```terminal
   sudo pip install esptool
   ```

2. Backup Firmware

   ```terminal
   esptool.py --port /dev/cu.usbserial-2110 read_flash 0x00000 0x100000 fwbackup.bin
   ```

3. Erase memory

   ```terminal
   esptool.py --port /dev/cu.usbserial-2110 erase_flash
   ```

4. Download Software from [here](http://ota.tasmota.com/tasmota/release/).

5. Upload Firmware

   ```terminal
   esptool.py --port /dev/cu.usbserial-2110 write_flash -fs 1MB -fm dout 0x0 ~/Downloads/tasmota.bin
   ```
