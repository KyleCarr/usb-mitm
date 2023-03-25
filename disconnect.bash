#!/bin/bash

cd /sys/kernel/config/usb_gadget/usbMitm
umount /mnt/mydrive
rm configs/c.1/mass_storage.usb0
