# snd_soc_cs4265
Experimental Cirrus Logic cs4265 Linux Driver For Raspberry Pi Audio Injector Ultra Sound Card

### About

Reference the following Audio Injector Ultra Sound Card issue:

https://github.com/Audio-Injector/Ultra/issues/9

There is a ~2 second settling time when the card starts recording. This repository is created to facilitate experimentation with the linux kernel driver to see if settling time can be made to occur outside of the time of the actual desired recording.

### Datasheet

https://statics.cirrus.com/pubs/proDatasheet/CS4265_F4.pdf

### Original Driver Code

https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.h
https://github.com/torvalds/linux/blob/master/sound/soc/codecs/cs4265.c

cs4265.[h,c] have been renamed to snd_soc_cs4265.[h,c] respectively. The build process in the Linux tree changes the filename of the kernel module to snd_soc_cs4265 (guessing there's a naming convention). For now it's easier to rename the files than figure out how it all works.

### Building / Installation

git clone repository to local directory on the RaspberryPi. 
Run `make`
Run shell script `$ sudo ./modinstall`
Reboot Raspberry Pi `sudo reboot`
