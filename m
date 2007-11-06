From: "cksim" <cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org>
Subject: SD/MMC over SPI on 2.6.24-rc1
Date: Wed, 7 Nov 2007 05:32:11 +0800
Message-ID: <200711062132.lA6LWOLr005428@smtp43.singnet.com.sg>
Reply-To: cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0055_01C820FF.8C269FF0"
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0055_01C820FF.8C269FF0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

I have just tested kernel 2.6.24-rc1 with SD/MMC through SPI bus on the
AT91SAM9261EK board (SPI NPCS3) and noted that the SD card was detected and
info were noted under "/sys/bus/mmc" directory.

However, no device, such as mmcblk0p1, was assigned at all.

I have 2 questions with regards to SD/MMC over SPI.

1) In the code, I have commented out all other SPI devices on SPI0 bus
except for the SD card at spi0.3. However, I got an error "can't share SPI
bus". Anyone can advise what is the reason behind this error ?
(In order to proceed with my test below, I temporary got over this issue by
commenting out the check that gives this error.)

2) The kernel 2.6.24-rc1 boots up and detected the SD card with the console
output "new SD card on SPI". However, no device name, such as mmcblk0p1,
were allocated. In addition, I noted the following messages before the
sentence "mmc0: new SD card on SPI".

****** extract from console output ***********
WARNING: at drivers/mmc/core/core.c:397 mmc_set_clock()
[<c002901c>] (dump_stack+0x0/0x14) from [<c018dfd8>]
(mmc_set_clock+0x40/0xb4)
[<c018df98>] (mmc_set_clock+0x0/0xb4) from [<c01907b4>]
(mmc_attach_sd+0x610/0x844)
[<c01901a4>] (mmc_attach_sd+0x0/0x844) from [<c018e3e4>]
(mmc_rescan+0x204/0x2e0)
[<c018e1e0>] (mmc_rescan+0x0/0x2e0) from [<c004b154>]
(run_workqueue+0xb8/0x148)
 r7:00000000 r6:c018e1e0 r5:c044e000 r4:c048d4a0
[<c004b09c>] (run_workqueue+0x0/0x148) from [<c004bbe4>]
(worker_thread+0xa8/0xbc)
 r6:c004bb3c r5:c048d4a0 r4:c048d4a8
[<c004bb3c>] (worker_thread+0x0/0xbc) from [<c004f5f4>] (kthread+0x58/0x90)
 r5:c048d4a0 r4:c044e000
[<c004f59c>] (kthread+0x0/0x90) from [<c003e698>] (do_exit+0x0/0x6fc)
 r6:00000000 r5:00000000 r4:00000000
****** end of extract ***********

(I have attached a console debug output, including dmesg output, as well)

FYI, I am using a blank 16MB SD card with FAT filesystem.

Appreciate any advices/help given.

Lastly, I would like to know if the SD/MMC over SPI can be shared with other
SPI devices, such as touchscreen controller ADS7843 (purposely left out in
the current code) ?

Thanks in advance.

------=_NextPart_000_0055_01C820FF.8C269FF0
Content-Type: text/plain;
	name="mini_011107_1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mini_011107_1.txt"



dm9000 i/o: 0x30000000, id: 0x90000a46=20
MAC: de:ad:be:ef:01:01
operating at 100M full duplex mode
TFTP from server 192.168.3.1; our IP address is 192.168.3.77
Filename 'vmImage'.
Load address: 0x22000000
Loading: =
*=08#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #########
done
Bytes transferred =3D 1375579 (14fd5b hex)
## Booting image at 22000000 ...
   Image Name:   ET Linux Kernel Only Image
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1375515 Bytes =3D  1.3 MB
   Load Address: 20008000
   Entry Point:  20008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.24-rc1 (root@Debian-Laptop) (gcc version 4.1.2) #20 =
Thu Nov 1 15:23:46 SGT 2007
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
Machine: Atmel AT91SAM9261-EK
Memory policy: ECC disabled, Data cache writeback
Clocks: CPU 199 MHz, master 99 MHz, main 18.432 MHz
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
16256
Kernel command line: root=3D/dev/nfs rw =
nfsroot=3D192.168.3.1:/ronetix/rootfs =
mtdparts=3Dphysmap-flash.0:256k(u-boot)ro,64k(u-boot-env)ro,1344k(kernel)=
,-(rootfs);nand:-(nand) =
ip=3D192.168.3.77:192.168.3.1:192.168.3.1:255.255.255.0:nini:eth0:off
AT91: 96 gpio irqs in 3 banks
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
console [tty0] enabled
console [ttyS0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 61952KB available (2568K code, 239K data, 112K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 64 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
atmel_usart.0: ttyS0 at MMIO 0xfefff200 (irq =3D 1) is a ATMEL_SERIAL
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
dm9000 Ethernet Driver
eth0: dm9000 at c485c000,c485e004 IRQ 56 MAC: de:ad:be:ef:01:01
physmap platform flash device: 00400000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
4 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x00000000-0x00040000 : "u-boot"
0x00040000-0x00050000 : "u-boot-env"
0x00050000-0x001a0000 : "kernel"
0x001a0000-0x00400000 : "rootfs"
NAND device: Manufacturer ID: 0x20, Chip ID: 0xda (ST Micro NAND 256MiB =
3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 473 at 0x03b20000
Bad eraseblock 728 at 0x05b00000
Bad eraseblock 743 at 0x05ce0000
Bad eraseblock 813 at 0x065a0000
Bad eraseblock 1001 at 0x07d20000
Bad eraseblock 1730 at 0x0d840000
Creating 1 MTD partitions on "NAND 256MiB 3,3V 8-bit":
0x00000000-0x10000000 : "nand"
atmel_spi atmel_spi.0: Atmel SPI Controller at 0xfffc8000 (irq 12)
usbmon: debugfs is not available
at91_ohci at91_ohci: AT91 OHCI
at91_ohci at91_ohci: new USB bus registered, assigned bus number 1
at91_ohci at91_ohci: irq 20, io mem 0x00500000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
udc: at91_udc version 3 May 2006
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
mmc_spi spi0.3: ASSUMING 3.2-3.4 V slot power
mmc_spi spi0.3: SD/MMC host mmc0, no WP, no poweroff
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
WARNING: at drivers/mmc/core/core.c:397 mmc_set_clock()
[<c002901c>] (dump_stack+0x0/0x14) from [<c018dfd8>] =
(mmc_set_clock+0x40/0xb4)
[<c018df98>] (mmc_set_clock+0x0/0xb4) from [<c01907b4>] =
(mmc_attach_sd+0x610/0x844)
[<c01901a4>] (mmc_attach_sd+0x0/0x844) from [<c018e3e4>] =
(mmc_rescan+0x204/0x2e0)
[<c018e1e0>] (mmc_rescan+0x0/0x2e0) from [<c004b154>] =
(run_workqueue+0xb8/0x148)
 r7:00000000 r6:c018e1e0 r5:c044e000 r4:c048d4a0
[<c004b09c>] (run_workqueue+0x0/0x148) from [<c004bbe4>] =
(worker_thread+0xa8/0xbc)
 r6:c004bb3c r5:c048d4a0 r4:c048d4a8
[<c004bb3c>] (worker_thread+0x0/0xbc) from [<c004f5f4>] =
(kthread+0x58/0x90)
 r5:c048d4a0 r4:c044e000
[<c004f59c>] (kthread+0x0/0x90) from [<c003e698>] (do_exit+0x0/0x6fc)
 r6:00000000 r5:00000000 r4:00000000
eth0: link down
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.3.77, mask=3D255.255.255.0, =
gw=3D192.168.3.1,
     host=3Dnini, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.3.1, rootserver=3D192.168.3.1, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.3.1
eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Looking up port of RPC 100005/1 on 192.168.3.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 112K
mount: can't find udev in /etc/fstab
Starting portmap: done
Starting network...
ip: RTNETLINK answers: File exists
Starting NFS statd: done
Starting NFS services: done
Starting NFS daemon: done
Starting NFS mountd: done
Starting HPA's tftpd: done
 thttpd


nini login: root
[root@nini ~]# dmesg
D8 response SPI_R3/R4/R: resp 0005 ffffffff
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD8): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
mmc_spi spi0.3:   mmc_spi: CMD5, resp R3/R4/R7
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 21 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 21 bytes transferred
mmc_spi spi0.3:   ... CMD5 response SPI_R3/R4/R: resp 0005 ffffffff
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD5): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.3:   mmc_spi: CMD55, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.3:   mmc_spi: CMD41, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD41): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi0.3:   mmc_spi: CMD0, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD58 arg 00000000 flags 00000280
mmc_spi spi0.3:   mmc_spi: CMD58, resp R3/R4/R7
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 21 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 21 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD58): 0: 00000001 00ff8000 00000000 00000000
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi0.3:   mmc_spi: CMD0, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmc_spi spi0.3:   mmc_spi: CMD8, resp R3/R4/R7
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 21 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 21 bytes transferred
mmc_spi spi0.3:   ... CMD8 response SPI_R3/R4/R: resp 0005 ffffffff
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD8): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.3:   mmc_spi: CMD55, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.3:   mmc_spi: CMD41, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD41): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.3:   mmc_spi: CMD55, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.3:   mmc_spi: CMD41, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD41): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD59 arg 00000001 flags 00000080
mmc_spi spi0.3:   mmc_spi: CMD59, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD59): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD10 arg 00000000 flags 000000b5
mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 0
mmc_spi spi0.3:   mmc_spi: CMD10, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 9 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 9 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
mmc_spi spi0.3:     mmc_spi: read block, 16 bytes
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3:   start xfer c057a9d4: len 16 tx c0595600/20595600 rx =
c05a0a40/205a0a40 imr 018
mmc_spi spi0.3:   start xfer c057a9f8: len 2 tx c0595600/20595600 rx =
c05a0c5e/205a0c5e imr 018
mmc_spi spi0.3: DEactivate 38, mr 000f0011
atmel_spi atmel_spi.0: xfer complete: 18 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD10): 0: 00000000 00000000 00000000 00000000
mmc0:     16 bytes transferred: 0
mmc0: starting CMD9 arg 00000000 flags 000000b5
mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 0
mmc_spi spi0.3:   mmc_spi: CMD9, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 9 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 9 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
mmc_spi spi0.3:     mmc_spi: read block, 16 bytes
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3:   start xfer c057a9d4: len 16 tx c0595600/20595600 rx =
c05a0a40/205a0a40 imr 018
mmc_spi spi0.3:   start xfer c057a9f8: len 2 tx c0595600/20595600 rx =
c05a0c5e/205a0c5e imr 018
mmc_spi spi0.3: DEactivate 38, mr 000f0011
atmel_spi atmel_spi.0: xfer complete: 18 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD9): 0: 00000000 00000000 00000000 00000000
mmc0:     16 bytes transferred: 0
mmc0: starting CMD55 arg 00000000 flags 00000095
mmc_spi spi0.3:   mmc_spi: CMD55, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 17 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 17 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD55): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD51 arg 00000000 flags 000000b5
mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi0.3:   mmc_spi: CMD51, resp R1
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3: activate 38, mr 00070011
mmc_spi spi0.3:   start xfer c057a9d4: len 9 tx c05a0c40/205a0c40 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 9 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
mmc_spi spi0.3:     mmc_spi: read block, 8 bytes
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa90 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa90 for spi0.3
mmc_spi spi0.3:   start xfer c057aa6c: len 1 tx c0595600/20595600 rx =
c05a0c40/205a0c40 imr 018
atmel_spi atmel_spi.0: xfer complete: 1 bytes transferred
atmel_spi atmel_spi.0: new message c057aa40 submitted for spi0.3
atmel_spi atmel_spi.0: start message c057aa40 for spi0.3
mmc_spi spi0.3:   start xfer c057a9d4: len 8 tx c0595600/20595600 rx =
c057df34/2057df34 imr 018
mmc_spi spi0.3:   start xfer c057a9f8: len 2 tx c0595600/20595600 rx =
c05a0c5e/205a0c5e imr 018
mmc_spi spi0.3: DEactivate 38, mr 000f0011
atmel_spi atmel_spi.0: xfer complete: 10 bytes transferred
mmc_spi spi0.3: DEactivate 38, mr 000f0011
mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902
mmc0: req done (CMD51): 0: 00000000 00000000 00000000 00000000
mmc0:     8 bytes transferred: 0
WARNING: at drivers/mmc/core/core.c:397 mmc_set_clock()
[<c002901c>] (dump_stack+0x0/0x14) from [<c018dfd8>] =
(mmc_set_clock+0x40/0xb4)
[<c018df98>] (mmc_set_clock+0x0/0xb4) from [<c01907b4>] =
(mmc_attach_sd+0x610/0x844)
[<c01901a4>] (mmc_attach_sd+0x0/0x844) from [<c018e3e4>] =
(mmc_rescan+0x204/0x2e0)
[<c018e1e0>] (mmc_rescan+0x0/0x2e0) from [<c004b154>] =
(run_workqueue+0xb8/0x148)
 r7:00000000 r6:c018e1e0 r5:c044e000 r4:c048d4a0
[<c004b09c>] (run_workqueue+0x0/0x148) from [<c004bbe4>] =
(worker_thread+0xa8/0xbc)
 r6:c004bb3c r5:c048d4a0 r4:c048d4a8
[<c004bb3c>] (worker_thread+0x0/0xbc) from [<c004f5f4>] =
(kthread+0x58/0x90)
 r5:c048d4a0 r4:c044e000
[<c004f59c>] (kthread+0x0/0x90) from [<c003e698>] (do_exit+0x0/0x6fc)
 r6:00000000 r5:00000000 r4:00000000
mmc0: clock 0Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0
eth0: link down
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.3.77, mask=3D255.255.255.0, =
gw=3D192.168.3.1,
     host=3Dnini, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.3.1, rootserver=3D192.168.3.1, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.3.1
eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Looking up port of RPC 100005/1 on 192.168.3.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 112K
[root@nini ~]# 
------=_NextPart_000_0055_01C820FF.8C269FF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
------=_NextPart_000_0055_01C820FF.8C269FF0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------=_NextPart_000_0055_01C820FF.8C269FF0--
