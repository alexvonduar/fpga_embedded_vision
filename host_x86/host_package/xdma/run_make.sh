#!/bin/bash

sudo make clean
sudo rmmod xdma.ko
sudo make install
sudo ./load_driver.sh
sudo cp ../etc/udev/rules.d/60-xdma.rules /etc/udev/rules.d/
sudo cp ../etc/udev/rules.d/xdma-udev-command.sh /etc/udev/rules.d/

