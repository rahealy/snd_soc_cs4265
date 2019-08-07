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

* `sudo apt-get install raspberrypi-kernel-headers`
* `git clone https://github.com/rahealy/snd_soc_cs4265.git` to local directory on the RaspberryPi. 
* Run `make`
* Run shell script `$ sudo ./modinstall`
* Reboot Raspberry Pi `sudo reboot`


### Observations

**Loopback Switch Off to On**

Given:

```
$ amixer cget name='Loopback Switch'
numid=20,iface=MIXER,name='Loopback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
$ amixer cset name='Loopback Switch' 1
$ dmesg -e
<...>
[Aug 7 08:33] cs4265_set_bias_level(): In SND_SOC_BIAS_PREPARE.
[  +0.001605] cs4265_set_bias_level(): In SND_SOC_BIAS_ON.
```

**Loopback Switch On to Off**

Given:
```
$ amixer cget name='Loopback Switch'
numid=20,iface=MIXER,name='Loopback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
$ amixer cset name='Loopback Switch' 0
$ dmesg -e
<...>
[Aug 7 08:36] cs4265_set_bias_level(): In SND_SOC_BIAS_PREPARE.
[  +0.001733] cs4265_set_bias_level(): In SND_SOC_BIAS_STANDBY.
```

**Record With Loopback Switch Off**

Given:
```
$ amixer cget name='Loopback Switch'
numid=20,iface=MIXER,name='Loopback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off
$ arecord -r 32000 -f S16_LE -c 2 -d 5 ./tmp/test.wav
$dmesg -e
<...>
[Aug 7 08:42] cs4265_pcm_hw_params(): Here!
[  +0.000012] cs4265_get_clk_index(): Here!
[  +0.000363] cs4265_set_bias_level(): In SND_SOC_BIAS_PREPARE.
[  +0.000613] cs4265_set_bias_level(): In SND_SOC_BIAS_ON.
[  +5.002717] cs4265_set_bias_level(): In SND_SOC_BIAS_PREPARE.
[  +0.000597] cs4265_set_bias_level(): In SND_SOC_BIAS_STANDBY.
```

**Record With Loopback Switch On**

Given:
```
$ amixer cget name='Loopback Switch'
numid=20,iface=MIXER,name='Loopback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
$ arecord -r 32000 -f S16_LE -c 2 -d 5 ./tmp/test.wav
$ dmesg -e
<...>
[Aug 7 08:45] cs4265_pcm_hw_params(): Here!
[  +0.000012] cs4265_get_clk_index(): Here!
```


### Misc References

Linux Dynamic Audio Power Management (DAPM):

https://www.alsa-project.org/main/index.php/DAPM

https://github.com/torvalds/linux/blob/master/include/sound/soc-dapm.h

Writing Kernel Modules:

https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234?gi=de7973f78a01

Forking Git Repos:

https://guides.github.com/activities/forking/

https://dret.typepad.com/dretblog/2013/02/github-fork-etiquette.html

