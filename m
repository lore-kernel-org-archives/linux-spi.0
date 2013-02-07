From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
	possible
Date: Thu, 07 Feb 2013 22:15:48 +0100
Message-ID: <3752726.iyKukyN6sF@wuerfel>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
	<201302071942.54642.arnd@arndb.de>
	<CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdbunPGtR4p_kY4q8WEb8iwkEbdo_icDyrLZwKrCe0wXqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 07 February 2013 21:19:04 Linus Walleij wrote:
> On Thu, Feb 7, 2013 at 8:42 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Thursday 07 February 2013, Linus Walleij wrote:
> 
> >> Actually I once read about a feature where the kernel provides
> >> a static page full of zeroes or something like this, that would be
> >> ideal to use in cases like this, then all of this dummy page
> >> allocation and freeing can be deleted.
> >
> > You mean empty_zero_page? That only works if this page is
> > read-only from the perspective of the DMA controller, but
> > then it would be a good fit, yes.
> 
> That's actually how it's used.
> 
> SPI is symmetric, and in the DMA case we're not poking
> data into the buffers from the CPU so the controller need
> something - anything - to stream to the block.
> 
> If we can use that page we'll even save a few remaps.

I'm slightly worried about the caching effects though. The
idea of the empty-zero page is that all user processes get
it when they read a page before they write to it, so the
data in it can essentially always be cache-hot.

If we do DMA from that page to a device what would be the
overhead of flushing the (clean) cache lines?

	Arnd

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
