# gnuradio
Notes on installing, running and streaming the audio output from an SDR and GNU Radio on **Ubuntu 14.04 Server** using an rtl_sdr dongle.

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
Install the ```gnuradio``` and ```gr-osmosdr``` packages using apt: ```$ sudo apt-get install gnuradio gr-osmosdr```.
In Carl Laufer's *The Hobbyist's Guide to the RTL-SDR*, he suggests a modification to a gnuradio config file for instances running in Linux VMs to prevent "choppy audio." Specifically, in the file ```/usr/gnuradio/conf.d/gr-audio-alsa.conf``` he suggests the following settings.

'''period_time = 0.10
nperiods = 32'''

## Testing the SDR 
Once the above steps are complete, the system can be tested with the included Python 2 script: ```$ python fm_radio.py```

## Streaming the Radio Signal
First, the following additional software packages must be installed:
* lame (MP3 encoder)
* vlc (all-around awesome FOSS multi-media giant)

```$ sudo apt-get install lame vlc```

Next, create a named pipe with a ```.wav``` extension in the same directory where ```fm_radio.py``` lives. You need to do this just once. The named pipe can be reused each time the SDR's audio signal is streamed.

```$ mkfifo wmea.wav```

Finally,

1. In the same directory where the SDR's Python script and the named pipe live, start lame, specifying the input and output file names: ```$ lame wmea.wav wmea.mp3```
2. Run the Python script: ```$ python fm_radio.py```
3. Start streaming the SDR's audio output by running the included one-line shell script named ```run_vlc.sh```: ```$ ./run_vlc.sh``` 
4. Point a browser running on a different host to http://my_ip_address:8080/wbpr.mp3, and enjoy!

Note: The audio output produced by the SDR and encoded by ```lame``` is actually stored in ```wmea.mp3``` so that it can be streamed by vlc. Depending on how long streaming continues, this file can grow quite large. Just something to keep in mind.
