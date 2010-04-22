From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Thu, 22 Apr 2010 21:19:32 +0100
Message-ID: <x2w56d259a01004221319y27d25d30sbe8b548c4d7932fd@mail.gmail.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
	<x2g56d259a01004220728i7f07d492t4c4f63e0ef2e38d9@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D940C95@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636D940C95-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 4/22/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
>  > Further, on a suspicion about the silliness of the per-transfer
>  > bits_per_word being checked right down the bottom of the lowest lever
>  > byte-read/writing routine instead of once per transfer, I split
>  > ep93xx_spi_read and _write into 8 and 16-bit variants, and checked
>  > t->bits_per_word once outside the read and write loops.
>  >
>  > This gives:
>  >      60.0% 59.3%  285906 irq/MB
>
>
> It looks like splitting the 8/16-bit read/write routines does help
>  with cpu usage compared to the tests above.  Was the data transfer
>  (kB/sec) any better?

No, exactly the same.

>From a code poin tof view, one of the routines is just
if (bits > 8) {
   this16
} else {
   that8
}
so no loss in splitting it. You need two copies of the read and write
loops in the read_write routine, though it's only 8 extra lines of
code for a 1% CPU increase.
I don't have strong feelings about this it way.

> Yes.  Too bad we can't also combine multiple messages that might be in
>  the queue...

I wonder if it might be easier, if there are several parts to a
message, to just cook up  one big new transfer, copy the data into it
and just do that. It would mean copying every data block of course
since in the MMC/SD case they are 512+2+1.

>  But, if this gets to complicated it might not be worth holding off
>  getting it merged
Possibly. It depends on the timing of the merge windows. The current
code works with some devices.

>  > It now occurs to me that another step in CPU efficiency could be had
>  > by abusing the receive-fifo-is-half-full interrupt to signal the
>  > completion of a transfer. This would only work for transfers of four
>  > or more words and would need some careful jiggery-pokery at end of
>  > transfer to turn the tx-fifo-is-half-empty interrupt enable off and
>  > ensure that exactly four words would end up in the RX FIFO.
>
> That might work but I think it could break horribly.  The "jiggery-pokery"
>  could end up being pretty messy.

Yes. It is looking nasty and it would make a mess of the place where
the continuity stuff needs to happen to achieve actual functionality
improvements.

To get some idea of the potential wins I've been instrumenting the
code today to see how many interrupts it takes to receive the last 4
words
At 3.7MHz I'm seeing up to 3 interrupts waiting for the final draining
to happen, with an average of 1.36 (1 would be the perfect figure)
At 400kHz it takes up to 26 with an average of 9.92

Me, I only really care about the SD card case, where a half dozen
useless interrupts per 512-byte block is not going to impact on the
CPU usage much. In fact, by making the interrupt routine more complex
it may even end up being more cpu hungry in the end.

On the other hand, slow clock-speed devices are using needless high
CPU, especially if the transfer sizes are small as is typical with
command-response devices.

>  But, the tx-fifo-is-half-empty might be what is needed to handle the
>  multiple transfer merging.  We know the driver is finished transfering
>  the data to the fifo when (espi->tx == t->len).  At this point we are
>  just wating for the last (fifo_level) bytes to come in on the rx fifo,
>  this could be anything from 1 to 8 bytes.

Another instrumentation show that yes, at 3.7MHz, the data read on
each interrupt is between 1 and 8 words. I'm surprised it gets to 8
full - maybe when the interrupt is requested while some other IRQ
(ether? clock tick?) is already in progress? I'm instrumenting in a
way that shouldn't change the timing characteristics of the transfer
(ie a tiny printk's only after end of transfer)

>  > It's a horrible thought, and I suspect that the DMA engine is the real answer.
>
> The DMA engine might help but it's not here yet....

Yes. What I mean is that the prospect of that happening somewhere in
the future reduces the importance of doing hairy jiggery pokery with
the interrupt version.

     M

------------------------------------------------------------------------------
