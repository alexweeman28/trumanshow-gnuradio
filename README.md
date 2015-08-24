# gnuradio
Notes on installing and using GNU Radio on Ubuntu 14.04 Desktop using an rtl_sdr dongle

## Getting the dongle to work
These following two steps are required on Ubuntu 14.04.

1. Add a udev rule for the device

Create the following file: ```/etc/udev/rules.d/20.rtlsdr.rules``` with this rule:
```
SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", GROUP="adm", MODE="0666", SYMLINK+="rtl_sdr"
```
Note that the idVendor and idProduct values come from the lsusb listing for the device. For example:
```
$ lsusb # Excerpted
Bus 002 Device 002: ID 0bda:2838 Realtek Semiconductor Corp.
```
Once this file is created, restart udev:
```
sudo /etc/init.d/udev restart
```
2. Blacklist the kernel module dvb_usb_rtl28xxu 

Add the following line to ```/etc/modprobe.d/blacklist.conf``` and restart the system:
```
blacklist dvb_usb_rtl28xxu
``` 

## Installing GNU Radio
