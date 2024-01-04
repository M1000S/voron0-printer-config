#!/bin/bash
sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/klipper/scripts
python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_rp2040_45503571279022F8-if00")'

cd ~/klipper

cp ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.pico ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.pico.old
mv ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.pico ~/klipper
make clean KCONFIG_CONFIG=config.make.klipper.pico
make menuconfig KCONFIG_CONFIG=config.make.klipper.pico
make KCONFIG_CONFIG=config.make.klipper.pico
python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-katapult_rp2040_45503571279022F8-if00
#python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-Klipper_rp2040_45503571279022F8-if00
mv ~/klipper/config.make.klipper.pico ~/printer_data/config/scripts/mcu_flash/config/klipper/

sudo systemctl start klipper
sudo systemctl start klipper-mcu
