echo device | sudo tee /sys/bus/platform/drivers/dwc3-meson-g12a/d0078080.usb/usb_role/d0078080.usb-role-switch/role
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/unbind
echo c9100000.usb | sudo tee /sys/bus/platform/drivers/dwc2/bind
sudo modprobe g_ether host_addr=00:dc:c8:f7:75:05 dev_addr=00:dd:dc:eb:6d:f1