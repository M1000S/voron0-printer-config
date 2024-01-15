#!/bin/bash

# script builds katapult and updtes via feployer.bin
sudo systemctl stop klipper
sudo systemctl stop klipper-mcu

cd ~/katapult

cp ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.ebb ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.ebb.old
mv ~/printer_data/config/scripts/mcu_flash/config/katapult/config.make.katapult.ebb ~/katapult
make clean KCONFIG_CONFIG=config.make.katapult.ebb
make menuconfig KCONFIG_CONFIG=config.make.katapult.ebb
make KCONFIG_CONFIG=config.make.katapult.ebb
mv ~/katapult/config.make.katapult.ebb ~/printer_data/config/scripts/mcu_flash/config/katapult/
python3 ~/katapult/scripts/flashtool.py -i can0 -f ~/katapult/out/deployer.bin -u 98ba9ff4d330
sudo systemctl start klipper
sudo systemctl start klipper-mcu