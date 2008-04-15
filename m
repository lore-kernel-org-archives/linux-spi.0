From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 15 Apr 2008 12:44:33 -0700
Message-ID: <200804151244.34171.david-b@pacbell.net>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151204.19776.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1CF6EDDF0820924DA43C9A52FE7325950A89DA47-3jZfQB9DylyX6QUl2nWcdlaTQe2KTcn/@public.gmane.org>
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

On Tuesday 15 April 2008, hartleys wrote:

> One of the cards actually produces a "Division by zero in kernel." error.
> It appears to happen in the mmc_set_data_timeout() function. I added a
> printk to the function and get the following when the card is inserted.
> 
> mmc_set_data_timeout  timeout_ns:0  timeout_clks:0  ios.clock:400000
> mmc_set_data_timeout  timeout_ns:-589934592  timeout_clks:0  ios.clock:400000
> mmc0: new SD card on SPI
> mmcblk0: mmc0:0000       29888KiB
>  mmcblk0:mmc_set_data_timeout  timeout_ns:-589934592  timeout_clks:0  ios.clock:0
> Division by zero in kernel.
> [<c003e650>] (dump_stack+0x0/0x14) from [<c003e67c>] (__div0+0x18/0x20)
> [<c003e664>] (__div0+0x0/0x20) from [<c01766d8>] (Ldiv0+0x8/0x10)
> [<c0210cb4>] (mmc_set_data_timeout+0x0/0x128) from [<c0216e28>] (mmc_blk_issue_rq+0x124/0x73c)
>  r7:c50b8000 r6:c4949614 r5:c5560e00 r4:c50b8000
> [<c0216d04>] (mmc_blk_issue_rq+0x0/0x73c) from [<c0217a80>] (mmc_queue_thread+0xd8/0x180)
> [<c02179a8>] (mmc_queue_thread+0x0/0x180) from [<c006d6a8>] (kthread+0x54/0x80)
>  r8:00000000 r7:00000000 r6:00000000 r5:c02179a8 r4:fffffffc
> [<c006d654>] (kthread+0x0/0x80) from [<c005a1dc>] (do_exit+0x0/0x828)
>  r5:00000000 r4:00000000
>  p1

That's wrong.  :(


> For some reason the card->host->ios.clock value is getting changed to 0 on
> the third call to the function. I haven't been able to trace down where/why
> this would happen. Any idea on that one?

ISTR the MMC stack sometimes sets clockspeed to zero as a way
of disabling a controller ... but if that were happening, I'd
expect it not to have issued a request like taht.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
