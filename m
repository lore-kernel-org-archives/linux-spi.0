From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: I can't see the SPI device file in /dev.
Date: Wed, 8 Aug 2007 10:15:49 -0700
Message-ID: <200708081015.49600.david-b@pacbell.net>
References: <30508394.743901186538489274.JavaMail.weblogic@ep_ml20>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?=EA=B0=95=EC=83=81=EC=9A=B0?= <ksw412-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, wizard.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <30508394.743901186538489274.JavaMail.weblogic@ep_ml20>
Content-Disposition: inline
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

On Tuesday 07 August 2007, SangWoo Kang wrote:
> Hi~  
> My developing Environment is below. 
> Kernel-2.6.22.1
>      tar jxvf linux-2.6.22.1.tar.bz2
>      cd linux-2.6.22.1
>      zcat ../2.6.22-rc1-at91.patch.gz | patch -p1 > patchresult.txt

2.6.22-rc1 is pretty old compared to 2.6.22.1 ... are you sure
all those patches are still relevant, and they applied OK?


> CPU-AT91SAM9260 
> Through the web searching and kernel documentation, I know that use
> the spidev kernel module.  
> And I modify arch/at-91/board_sam9260.c file as like below 
>  
> static struct spi_board_info ek_spi_devices[] = { 
> { //spi1.0-slot1 
>    .modalias = "spidev", 
>    .chip_select = 0, 
>    .max_speed_hz = 15*1000*1000, 
>    .bus_num=1, 
> }, 
> { //spi1.1-slot2 
>    .modalias = "spidev", 
>    .chip_select = 1, 
>    .max_speed_hz = 15*1000*1000, 
>    .bus_num=1, 
> }, 

Those look right.  I'd then expect /dev entries for spidev1.0
and spidev1.1 after "mdev" does its stuff.


>     ~
> } 
>  
> After compiling the kernel, download kernel img to the target. 
> Kernel menu_config.
>  
> Device Drivers
>  SPI support
>     [*]SPI support
>         [*]Debug support for SPI drivers
>      SPI Master Controller Drivers
>      [*]Atmel SPI controller
>      [ ]Bitbanging SPI master
>      SPI Protocol Masters
>      [ ]SPI EEPROMs from most vendors
>      [*]User mode SPI device driver support

Looks right.

  
> I execute the "/sbin/mdev -s" command into the target shell as expecting
> the /dev/spidev.  
> But I can't see the device file for SPI in target /dev folder. And I
> examin my /sys folder at target.  
> Of course, I can find the spi device nodes created from modified board_sam9260.c. 
> Hum...I don't know why did not populate the SPI device file in /dev file? 

I just set up spi0.2 and spi0.3 on one system and it worked fine
(2.6.23-rc2, but that shouldn't matter).

Files in /sys/bus/spi/devices/spi0.2:
lrwxrwxrwx    1 root     root            0 Dec 31  2006 bus -> ../../../../bus/spi
lrwxrwxrwx    1 root     root            0 Dec 31  2006 driver -> ../../../../bus/spi/drivers/spidev
-r--r--r--    1 root     root         4096 Dec 31  2006 modalias
lrwxrwxrwx    1 root     root            0 Dec 31  2006 spidev:spidev0.2 -> ../../../../class/spidev/spidev0.2
lrwxrwxrwx    1 root     root            0 Dec 31  2006 subsystem -> ../../../../bus/spi
-rw-r--r--    1 root     root         4096 Dec 31  2006 uevent

Files in /sys/class/spidev/spidev0.2:
-r--r--r--    1 root     root         4096 Dec 31  2006 dev
lrwxrwxrwx    1 root     root            0 Dec 31  2006 device -> ../../../devices/platform/atmel_spi.0/spi0.2
lrwxrwxrwx    1 root     root            0 Dec 31  2006 subsystem -> ../../../class/spidev
-rw-r--r--    1 root     root         4096 Dec 31  2006 uevent

and "dev" there contains 153:0, which "mdev" used to create
the /dev/spidev0.2 character device node.


> #dmesg | grep spi
> atmel_spi atmel_spi.1: Atmel SPI Controller at 0xfffcc000 (irq 13) 
> atmel_spi atmel_spi.1: registered master spi1 
> spi spi1.0: setup: 14189714 Hz bpw 8 mode 0x0 -> csr0 0a0a0702 
> atmel_spi atmel_spi.1: registered child spi1.0 
> spi spi1.1: setup: 14189714 Hz bpw 8 mode 0x0 -> csr1 0a0a0702 
> atmel_spi atmel_spi.1: registered child spi1.1 
> spi spi1.2: setup: 14189714 Hz bpw 8 mode 0x0 -> csr2 0a0a0702 
> atmel_spi atmel_spi.1: registered child spi1.2 
> spi spi1.3: setup: 14189714 Hz bpw 8 mode 0x0 -> csr3 0a0a0702 
> atmel_spi atmel_spi.1: registered child spi1.3 
>  
> Does root file system (NFS) has the problem ? or Kernel menu configuration ?
> Could you teach check point for this problem?

If your sysfs looks right based on what I showed above, I'd
guess maybe you have an old "mdev" ... or maybe it depends
on the CONFIG_SYSFS_DEPRECATED variable, which I can't yet
disable.


> This project name - Access control Unit
> The system is configured two kind of board.
> Main b'd has the AT91SAM9260 which has the Linux OS.
> Sub b'd has the Atmega2560 which is developing the AVR32 studio.

I don't think AVR8 chips can be SPI slaves at 15 MHz; you
should probably change the max_speed_hz you use to set up
those devices.  As I recall, 4 MHz is as fast as those chips
can talk SPI, iff everything goes well (and IRQs are blocked
during the PIO loops).


> One Main b'd is connected 5 Sub b'd by SPI
> ...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
