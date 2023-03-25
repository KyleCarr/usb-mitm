#!/bin/bash
echo device | sudo tee /sys/bus/platform/drivers/dwc3-meson-g12a/d0078080.usb/usb_role/d0078080.usb-role-switch/role
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/unbind
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/bind
modprobe g_mass_storage

cd /sys/kernel/config/usb_gadget/
mkdir -p usbMitm
cd usbMitm
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2

mkdir -p strings/0x409
echo "Test" > strings/0x409/serialnumber
echo "Test" > strings/0x409/manufacturer
echo "Test" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

FILE=/dev/sda1 #mount name for flash drive
mkdir -p /mnt/mydrive
mount $FILE /mnt/mydrive 
mkdir -p functions/mass_storage.usb0
echo 1 > functions/mass_storage.usb0/stall
echo 0 > functions/mass_storage.usb0/lun.0/cdrom
echo 0 > functions/mass_storage.usb0/lun.0/ro
echo 0 > functions/mass_storage.usb0/lun.0/nofua
echo $FILE > functions/mass_storage.usb0/lun.0/file
ln -s functions/mass_storage.usb0 configs/c.1/
# End functions
ls /sys/class/udc > UDC