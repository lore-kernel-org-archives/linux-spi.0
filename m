From: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 15 Apr 2008 21:58:52 -0400
Message-ID: <1CF6EDDF0820924DA43C9A52FE7325950A89E4C1@MI8NYCMAIL17.Mi8.com>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151204.19776.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
	<200804151244.34171.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <200804151244.34171.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

>> One of the cards actually produces a "Division by zero in kernel."
error.
>> It appears to happen in the mmc_set_data_timeout() function. I added
a 
>> printk to the function and get the following when the card is
inserted.
>> 
>> mmc_set_data_timeout  timeout_ns:0  timeout_clks:0  ios.clock:400000 
>> mmc_set_data_timeout  timeout_ns:-589934592  timeout_clks:0  
>> ios.clock:400000
>> mmc0: new SD card on SPI
>> mmcblk0: mmc0:0000       29888KiB
>>  mmcblk0:mmc_set_data_timeout  timeout_ns:-589934592  timeout_clks:0

>> ios.clock:0 Division by zero in kernel.
>> [<c003e650>] (dump_stack+0x0/0x14) from [<c003e67c>] 
>> (__div0+0x18/0x20) [<c003e664>] (__div0+0x0/0x20) from [<c01766d8>] 
>> (Ldiv0+0x8/0x10) [<c0210cb4>] (mmc_set_data_timeout+0x0/0x128) from 
>> [<c0216e28>] (mmc_blk_issue_rq+0x124/0x73c)  r7:c50b8000 r6:c4949614 
>> r5:c5560e00 r4:c50b8000 [<c0216d04>] (mmc_blk_issue_rq+0x0/0x73c)
from 
>> [<c0217a80>] (mmc_queue_thread+0xd8/0x180) [<c02179a8>] 
>> (mmc_queue_thread+0x0/0x180) from [<c006d6a8>] (kthread+0x54/0x80)  
>> r8:00000000 r7:00000000 r6:00000000 r5:c02179a8 r4:fffffffc 
>> [<c006d654>] (kthread+0x0/0x80) from [<c005a1dc>] (do_exit+0x0/0x828)

>> r5:00000000 r4:00000000
>>  p1
>
>That's wrong.  :(
>
>
>> For some reason the card->host->ios.clock value is getting changed to

>> 0 on the third call to the function. I haven't been able to trace
down 
>> where/why this would happen. Any idea on that one?

>ISTR the MMC stack sometimes sets clockspeed to zero as a way of
disabling
>a controller ... but if that were happening, I'd expect it not to have
>issued a request like taht.

I didn't think of checking dmesg before, here's the actual dump after I
insert
the SD card:

mmc_spi_detect_irq
mmc0: clock 0Hz busmode 2 powermode 1 cs 1 Vdd 21 width 0 timing 0
mmc_spi spi0.1: mmc_spi: power up (21)
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc_spi spi0.1: mmc_spi: power on (21)
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi0.1:   mmc_spi: CMD0, resp R1
mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmc_spi spi0.1:   mmc_spi: CMD8, resp R3/R4/R7
mmc_spi spi0.1:   ... CMD8 response SPI_R3/R4/R: resp 0005 ffffffff
mmc0: req done (CMD8): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
mmc_spi spi0.1:   mmc_spi: CMD5, resp R3/R4/R7
mmc_spi spi0.1:   ... CMD5 response SPI_R3/R4/R: resp 0005 ffffffff
mmc0: req done (CMD5): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.1:   mmc_spi: CMD55, resp R1
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.1:   mmc_spi: CMD41, resp R1
mmc0: req done (CMD41): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi0.1:   mmc_spi: CMD0, resp R1
mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD58 arg 00000000 flags 00000280
mmc_spi spi0.1:   mmc_spi: CMD58, resp R3/R4/R7
mmc0: req done (CMD58): 0: 00000001 00ff8000 00000000 00000000
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc0: starting CMD0 arg 00000000 flags 000000c0
mmc_spi spi0.1:   mmc_spi: CMD0, resp R1
mmc0: req done (CMD0): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD8 arg 000001aa flags 000002f5
mmc_spi spi0.1:   mmc_spi: CMD8, resp R3/R4/R7
mmc_spi spi0.1:   ... CMD8 response SPI_R3/R4/R: resp 0005 ffffffff
mmc0: req done (CMD8): -22: 00000005 ffffffff 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.1:   mmc_spi: CMD55, resp R1
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.1:   mmc_spi: CMD41, resp R1
mmc0: req done (CMD41): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
mmc_spi spi0.1:   mmc_spi: CMD55, resp R1
mmc0: req done (CMD55): 0: 00000001 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
mmc_spi spi0.1:   mmc_spi: CMD41, resp R1
mmc0: req done (CMD41): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD59 arg 00000001 flags 00000080
mmc_spi spi0.1:   mmc_spi: CMD59, resp R1
mmc0: req done (CMD59): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD10 arg 00000000 flags 000000b5
mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 0
mmc_spi spi0.1:   mmc_spi: CMD10, resp R1
mmc_spi spi0.1:     mmc_spi: read block, 16 bytes
mmc0: req done (CMD10): 0: 00000000 00000000 00000000 00000000
mmc0:     16 bytes transferred: 0
mmc0: starting CMD9 arg 00000000 flags 000000b5
mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 0
mmc_spi spi0.1:   mmc_spi: CMD9, resp R1
mmc_spi spi0.1:     mmc_spi: read block, 16 bytes
mmc0: req done (CMD9): 0: 00000000 00000000 00000000 00000000
mmc0:     16 bytes transferred: 0
mmc0: starting CMD55 arg 00000000 flags 00000095
mmc_spi spi0.1:   mmc_spi: CMD55, resp R1
mmc0: req done (CMD55): 0: 00000000 00000000 00000000 00000000
mmc0: starting CMD51 arg 00000000 flags 000000b5
mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi0.1:   mmc_spi: CMD51, resp R1
mmc_spi spi0.1:     mmc_spi: read block, 8 bytes
mmc0: req done (CMD51): 0: 00000000 00000000 00000000 00000000
mmc0:     8 bytes transferred: 0
mmc0: clock 0Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc_spi spi0.1: card is read-write
mmc0: new SD card on SPI
mmc0: starting CMD16 arg 00000200 flags 00000095
mmc_spi spi0.1:   mmc_spi: CMD16, resp R1
mmc0: req done (CMD16): 0: 00000000 00000000 00000000 00000000
mmcblk0: mmc0:0000 D0507 29888KiB
 mmcblk0:Division by zero in kernel.
[<c003e650>] (dump_stack+0x0/0x14) from [<c003e67c>] (__div0+0x18/0x20)
[<c003e664>] (__div0+0x0/0x20) from [<c0176718>] (Ldiv0+0x8/0x10)
[<c0210bf4>] (mmc_set_data_timeout+0x0/0xf8) from [<c0217418>]
(mmc_blk_issue_rq
+0x124/0x73c)
 r8:c494f304 r7:c50b8000 r6:c493f614 r5:c5e22000 r4:c50b8000
[<c02172f4>] (mmc_blk_issue_rq+0x0/0x73c) from [<c0218070>]
(mmc_queue_thread+0x
d8/0x180)
[<c0217f98>] (mmc_queue_thread+0x0/0x180) from [<c006d6e0>]
(kthread+0x54/0x80)
 r8:00000000 r7:00000000 r6:00000000 r5:c0217f98 r4:fffffffc
[<c006d68c>] (kthread+0x0/0x80) from [<c005a214>] (do_exit+0x0/0x828)
 r5:00000000 r4:00000000
mmc0: starting CMD18 arg 00000000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi0.1:   mmc_spi: CMD18, resp R1
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:     mmc_spi: read block, 512 bytes
mmc_spi spi0.1:   mmc_spi: CMD12, resp R1B
mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): 0: 00000000 00000000 00000000 00000000
 p1

It appears the mmc core is setting the clock to 0Hz for some reason.

If I hack the mmc_set_data_timeout() function to prevent the divide by
zero
the problem goes away and I am able to mount the SD card.

	timeout_us = data->timeout_ns / 1000;
	if (card->nost->ios.clock) {
		timeout_us += data->timeout_clks * 1000 /
			(card->host->ios.clock / 1000);
	}

But this "is" a hack. The question is why does the core set the clock to
0Hz?

Hartley

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
