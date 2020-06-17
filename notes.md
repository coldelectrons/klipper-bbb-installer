things to solve yet:
* get the PRU firmware loaded at boot
  there might be a bug there, so the old klipper way of just
  copying firmware to a default name might not work
* add a way to restart the firmware via systemd
* config the pins at boot via systemd
* reset the wifi in a way that actually work
  I've tried editing adafruit's wifi reset script to 
  do it via rmmod/insmod, because connman is in charge
  of wifi, and not iwconfig
* make an install script that does everything I've done
* make a python daemon that attaches to ttyGS1 and klipper
  most likely, create a user with a specific login shell,
  attach that via getty to GS1, follow notes on 'boot to python'
* either remove gadget mass storage, or make it point to /debian/sdcard
  for virtual sdcard in klipper
* make two different configs available; replicape and CRAMPS
