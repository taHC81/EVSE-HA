# EVSE-HA

Home assistant integration via MQTT for Miroslav's lovely [ESP32-EVSE](https://github.com/dzurikmiroslav/esp32-evse).

## Setup ##

Connect to the power supply using micro USB cable, after few seconds press the BOOT button (GPIO 0) what enables WiFi access point. Then you can connect to that temporary network and open http://192.168.4.1 address to select your home WiFi. After that, you'll get the EVSE board connected to you network. I'd suggest to either set fixed IP or create DHCP reservation to prevent IP changes.

## Configuration ##

As a first, modify **status.lua** file with your MQTT server's IP. Upload both LUA files using EVSE web interface via Settings / Files. Then go to Settings / Script, Enable it and Reload. Then you may check the MQTT browser (MQTT.fx, MQTT explorer...) whether it works or not. At the end, add MQTT entities from **EVSE-HA.yaml** into your Home assistnat configuration file and reload MQTT entries. Refer to the official documentation in case of any doubt.

![Script files](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-files.png?raw=true)

## Calibration ##

For the accurate power readings, please modify calibration constants using the multimeter.

## Screenshots from Home assistant ##

![HA1](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-HA-conn.png?raw=true)

![HA2](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-HA-chg.png?raw=true)

## Connection ##

Connection diagram with Type 2 socket. Please note that you shall use RCB Type B (AC+DC) for safety reasons!

![Wiring](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-wiring-socket.png?raw=true)

## EVSE box ##

Example of the box ([300 x 200 x 130 mm](https://www.firn.sk/nl-200x300-p1888)), [socket from Ali](https://www.aliexpress.com/item/1005007546662957.html).

![Wiring](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-box.jpg?raw=true)
