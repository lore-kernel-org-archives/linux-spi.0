From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SD/MMC over SPI on 2.6.24-rc1
Date: Tue, 6 Nov 2007 22:12:32 -0800
Message-ID: <200711062212.32877.david-b@pacbell.net>
References: <200711062132.lA6LWOLr005428@smtp43.singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200711062132.lA6LWOLr005428-kStlDfoawLFc9vzhF02D5Ynh5Q2U4q7d@public.gmane.org>
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

On Tuesday 06 November 2007, cksim wrote:
>
> 2) The kernel 2.6.24-rc1 boots up and detected the SD card with the console
> output "new SD card on SPI". However, no device name, such as mmcblk0p1,
> were allocated.

Did you load the mmc_block driver, and include partitioning support?


> In addition, I noted the following messages before the 
> sentence "mmc0: new SD card on SPI".
> 
> ****** extract from console output ***********

> mmc_spi spi0.3: ASSUMING 3.2-3.4 V slot power
> mmc_spi spi0.3: SD/MMC host mmc0, no WP, no poweroff

You should at least tell it the right values for what
voltage is provided that slot ... that's part of what
the platform data will let you do.  :)


> mmc_spi spi0.3: setup: 399730 Hz bpw 8 mode 0x0 -> csr3 0a0af902

Which looks like a good match for 400 KHz.


> WARNING: at drivers/mmc/core/core.c:397 mmc_set_clock()

Which is presumably "WARN_ON(hz < host->f_min);" ...

When you add some debug messages, what does it tell you
about the actual speed being requested there?


> [<c002901c>] (dump_stack+0x0/0x14) from [<c018dfd8>]
> (mmc_set_clock+0x40/0xb4)
> [<c018df98>] (mmc_set_clock+0x0/0xb4) from [<c01907b4>]
> (mmc_attach_sd+0x610/0x844)
> [<c01901a4>] (mmc_attach_sd+0x0/0x844) from [<c018e3e4>]
> (mmc_rescan+0x204/0x2e0)
> [<c018e1e0>] (mmc_rescan+0x0/0x2e0) from [<c004b154>]
> (run_workqueue+0xb8/0x148)
>  r7:00000000 r6:c018e1e0 r5:c044e000 r4:c048d4a0
> [<c004b09c>] (run_workqueue+0x0/0x148) from [<c004bbe4>]
> (worker_thread+0xa8/0xbc)
>  r6:c004bb3c r5:c048d4a0 r4:c048d4a8
> [<c004bb3c>] (worker_thread+0x0/0xbc) from [<c004f5f4>] (kthread+0x58/0x90)
>  r5:c048d4a0 r4:c044e000
> [<c004f59c>] (kthread+0x0/0x90) from [<c003e698>] (do_exit+0x0/0x6fc)
>  r6:00000000 r5:00000000 r4:00000000

> mmc0: clock 0Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0

I'm guessing that for some reason part of the MMC stack tried
to set hz == 0, triggering that warning ... I recall seeing it
do that a long time ago, but that was without any WARN_ON() in
the code.  The entire reason that atmel_spi will accept a
command to set the clock rate to zero is because the MMC stack
was using that convention.  ;)

- Dave


> ****** end of extract ***********
> 
> (I have attached a console debug output, including dmesg output, as well)
> 
> FYI, I am using a blank 16MB SD card with FAT filesystem.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
