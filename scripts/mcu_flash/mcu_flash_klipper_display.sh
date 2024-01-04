#!/bin/bash
lsusb
read -p "Is diisplay in DFU mode? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/klipper

cp ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.display ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.display.old
mv ~/printer_data/config/scripts/mcu_flash/config/klipper/config.make.klipper.display ~/klipper
make clean KCONFIG_CONFIG=config.make.klipper.display
make menuconfig KCONFIG_CONFIG=config.make.klipper.display
make flash KCONFIG_CONFIG=config.make.klipper.display FLASH_DEVICE=0483:df11
#python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-katapult_stm32f042x6_20001A000843564E32313720-if00
#python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-Klipper_rp2040_45503571279022F8-if00
mv ~/klipper/config.make.klipper.display ~/printer_data/config/scripts/mcu_flash/config/klipper/

sudo systemctl start klipper
sudo systemctl start klipper-mcu
