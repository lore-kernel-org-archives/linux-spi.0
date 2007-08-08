From: SangWoo Kang <wizard.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: I can't see the SPI device file in /dev.
Date: Wed, 08 Aug 2007 02:01:29 +0000 (GMT)
Message-ID: <30508394.743901186538489274.JavaMail.weblogic@ep_ml20>
Reply-To: wizard.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: prohibited
MIME-version: 1.0
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

Hi~  
My developing Environment is below. 
Kernel-2.6.22.1
     tar jxvf linux-2.6.22.1.tar.bz2
     cd linux-2.6.22.1
     zcat ../2.6.22-rc1-at91.patch.gz | patch -p1 > patchresult.txt
CPU-AT91SAM9260 
Through the web searching and kernel documentation, I know that use the spidev kernel module. 
And I modify arch/at-91/board_sam9260.c file as like below 
 
static struct spi_board_info ek_spi_devices[] = { 
{ //spi1.0-slot1 
   .modalias = "spidev", 
   .chip_select = 0, 
   .max_speed_hz = 15*1000*1000, 
   .bus_num=1, 
}, 
{ //spi1.1-slot2 
   .modalias = "spidev", 
   .chip_select = 1, 
   .max_speed_hz = 15*1000*1000, 
   .bus_num=1, 
}, 
    ~
} 
 
After compiling the kernel, download kernel img to the target. 
Kernel menu_config.
 
Device Drivers
 SPI support
    [*]SPI support
        [*]Debug support for SPI drivers
     SPI Master Controller Drivers
     [*]Atmel SPI controller
     [ ]Bitbanging SPI master
     SPI Protocol Masters
     [ ]SPI EEPROMs from most vendors
     [*]User mode SPI device driver support
 
I execute the "/sbin/mdev -s" command into the target shell as expecting the /dev/spidev. 
But I can't see the device file for SPI in target /dev folder. And I examin my /sys folder at target. 
Of course, I can find the spi device nodes created from modified board_sam9260.c. 
Hum...I don't know why did not populate the SPI device file in /dev file? 
 
#dmesg | grep spi
atmel_spi atmel_spi.1: Atmel SPI Controller at 0xfffcc000 (irq 13) 
atmel_spi atmel_spi.1: registered master spi1 
spi spi1.0: setup: 14189714 Hz bpw 8 mode 0x0 -> csr0 0a0a0702 
atmel_spi atmel_spi.1: registered child spi1.0 
spi spi1.1: setup: 14189714 Hz bpw 8 mode 0x0 -> csr1 0a0a0702 
atmel_spi atmel_spi.1: registered child spi1.1 
spi spi1.2: setup: 14189714 Hz bpw 8 mode 0x0 -> csr2 0a0a0702 
atmel_spi atmel_spi.1: registered child spi1.2 
spi spi1.3: setup: 14189714 Hz bpw 8 mode 0x0 -> csr3 0a0a0702 
atmel_spi atmel_spi.1: registered child spi1.3 
 
Does root file system (NFS) has the problem ? or Kernel menu configuration ?
Could you teach check point for this problem?
 
This project name - Access control Unit
The system is configured two kind of board.
Main b'd has the AT91SAM9260 which has the Linux OS.
Sub b'd has the Atmega2560 which is developing the AVR32 studio.
One Main b'd is connected 5 Sub b'd by SPI
Sub b'd is connected door lock by wiegend.
Main b'd is connected ACU server by TCP/IP.
 
And SPI Interface is very important!. Other communication interface is done.
Please Help me~. I had reported this problems to atmel and at91 but I did not receive any reply~ 
-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
