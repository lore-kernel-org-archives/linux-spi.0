From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/5] spi/mxs: Fix chip select control bits in DMA mode
Date: Tue, 2 Apr 2013 01:30:51 +0200
Message-ID: <201304020130.51951.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
	<201304020113.42124.marex@denx.de>
	<CA+7tXih2wAVeLpVoYkt4Tmo3h0YtLoZY3vCcv5s8sUD1u8_BVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXih2wAVeLpVoYkt4Tmo3h0YtLoZY3vCcv5s8sUD1u8_BVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Trent Piepho,

> On Mon, Apr 1, 2013 at 4:13 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> >> Change the code to set the CS bits in the message transfer function
> >> once.  Now the DMA and PIO txrx functions don't need to care about CS
> >> at all.
> > 
> > Ok, lemme ask this one more time -- will the DMA work with long transfers
> > where the CTRL0 will be overwritten on each turn? Did you actually test
> > this?
> 
> I don't have SPI flash, so I can't test SPI flash.  I can test other
> spi devices and by capturing the pins with  a logic analyzer.  It does
> work after the patch, and does not work before the patch.  The error
> should be obvious from looking at the code.
> 
> ctrl0 is not overwritten, from scratch, each on transfer.  The ctrl0
> value in the PIO part of the DMA is based on the current value of
> ctrl0 with additional bits ORed in.   The flaw here is that bits that
> should not be set are not masked out.
> 
> >> -static uint32_t mxs_spi_cs_to_reg(unsigned cs)
> >> +static u32 mxs_spi_cs_to_reg(unsigned cs)
> >> 
> >>  {
> >> 
> >> -     uint32_t select = 0;
> >> +     u32 select = 0;
> 
> I'll make it a separate patch.

This is completely irrelevant change, please just submit the relevant patches.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
