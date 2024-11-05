# EVSE-HA

Home assistant integration via MQTT for Miroslav's lovely [ESP32-EVSE](https://github.com/dzurikmiroslav/esp32-evse).

As a first, modify **status.lua** file with your MQTT server's IP. Upload both LUA files using EVSE web interface via Settings / Files. Then go to Settings / Script, Enable it and Reload. Then you may check the MQTT browser (MQTT.fx, MQTT explorer...) whether it works or not. At the end, add MQTT entities from **EVSE-HA.yaml** into your Home assistnat configuration file and reload MQTT entries. Refer to the official documentation in case of any doubt.

![HW](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-HA-conn.png?raw=true)

![HW](https://github.com/taHC81/EVSE-HA/blob/main/EVSE-HA-chg.png?raw=true)
