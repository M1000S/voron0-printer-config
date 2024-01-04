#!/bin/bash
sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/katapult

cp ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.display ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.display.old
mv ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.display ~/katapult
make clean KCONFIG_CONFIG=config.make.katapult.display
make menuconfig KCONFIG_CONFIG=config.make.katapult.display
make KCONFIG_CONFIG=config.make.katapult.display
mv ~/katapult/config.make.katapult.display ~/printer_data/config/scripts/mcu_flash/config/katapult/
#python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-katapult_stm32f042x6_20001A000843564E32313720-if00
#python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-Klipper_rp2040_45503571279022F8-if00
sudo systemctl start klipper
sudo systemctl start klipper-mcu