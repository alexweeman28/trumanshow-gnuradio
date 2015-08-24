# gnuradio
Notes on installing and using GNU Radio on Ubuntu 14.04 Desktop using an rtl_sdr dongle

## Getting the dongle to work
The following two steps are required on Ubuntu 14.04.

1) Add a udev rule for the device

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
2) Blacklist the kernel module ```dvb_usb_rtl28xxu``` 

Add the following line to ```/etc/modprobe.d/blacklist.conf``` and restart the system:
```
blacklist dvb_usb_rtl28xxu
``` 

## Installing GNU Radio
Several options exist, but the **best** option is to use the provided script for downloading and installing the host of software packages required for gnuradio. See the details on this page:

http://gnuradio.org/redmine/projects/gnuradio/wiki/InstallingGRFromSource#Using-the-build-gnuradio-script

It should be noted that this install will take a **very** long time, as in hours. The build script isn't very talkative, so lots patience and a bit of faith are required. Or, you can do what I did and follow what's happening by running top in another terminal window. I've run it twice now on two different systems with a 100% success rate.

## Testing the system 
Once the steps above are complete, the system can be tested with the included flow graph: ```fm_radio.grc```

This flow graph can be viewed (and run) in GNU Radio Companion ```gnuradio-companion```, which is the GUI application used to build gnuradio flow graphs. 