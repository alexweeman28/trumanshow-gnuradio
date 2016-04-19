# gnuradio
Notes on installing and using GNU Radio on **Ubuntu 14.04 Server** using an rtl_sdr dongle

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
Install the ```gnuradio``` and ```gr-osmosdr``` packages using apt: ```$ sudo apt-get install gnuradio gr-osmosdr```

## Testing the SDR 
Once the above steps are complete, the system can be tested with the included Python 2 script: ```$ python fm_radio.py```

## Streaming the Radio Signal
Additional software required:
* lame (MP3 encoder)
* vlc (all-around awesome FOSS multi-media giant)

Steps:

1. Create a named pipe with a ```.wav``` extension in the same directory where ```fm_radio.py``` lives: ```$ mkfifo wmea.wav```
2. In this same directory, start lame, specifying the input and output file names: ```$ lame wmea.wav wmea.mp3```
3. Run the Python script: ```$ python fm_radio.py```
4. Start streaming the SDR's audio output by running the included one-line shell script named ```run_vlc.sh```. 
5. Point a browser running on a different host to http://my_ip_address:8080/wbpr.mp3, and enjoy!

