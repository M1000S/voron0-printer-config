#!/bin/bash
sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/katapult

cp ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.pico ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.pico.old
mv ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.pico ~/katapult
make clean KCONFIG_CONFIG=config.make.katapult.pico
make menuconfig KCONFIG_CONFIG=config.make.katapult.pico
make KCONFIG_CONFIG=config.make.katapult.pico
mv ~/katapult/config.make.katapult.pico ~/printer_data/config/scripts/mcu_flash/config/katapult/

sudo systemctl start klipper
sudo systemctl start klipper-mcu