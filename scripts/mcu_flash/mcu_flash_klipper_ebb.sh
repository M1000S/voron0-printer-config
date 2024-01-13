#!/bin/bash
sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/klipper/scripts
python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_rp2040_45503571279022F8-if00")'

cd ~/klipper

cp ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.ebb ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.ebb.old
mv ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.ebb ~/klipper
make clean KCONFIG_CONFIG=config.make.klipper.ebb
make menuconfig KCONFIG_CONFIG=config.make.klipper.ebb
make KCONFIG_CONFIG=config.make.klipper.ebb
python3 ~/katapult/scripts/flashtool.py -i can0 -f ~/klipper/out/klipper.bin -u 98ba9ff4d330
mv ~/klipper/config.make.klipper.ebb ~/printer_data/config/scripts/mcu_flash/config/klipper/

sudo systemctl start klipper
sudo systemctl start klipper-mcu
