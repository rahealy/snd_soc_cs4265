obj-m += snd_soc_cs4265.o
all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

modules_install: all
	$(MAKE) -C /lib/modules/$(shell uname -r)/build  M=$(shell pwd) modules_install
	$(DEPMOD)
