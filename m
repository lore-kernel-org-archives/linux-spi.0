From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
	possible
Date: Thu, 7 Feb 2013 19:42:54 +0000
Message-ID: <201302071942.54642.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
	<201301291313.03511.arnd@arndb.de>
	<CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw@mail.gmail.com>
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
In-Reply-To: <CACRpkdZNpCJwp-uaH6feTcaPesNouwpHt-hO-M9v52G=Ux+Hqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 07 February 2013, Linus Walleij wrote:
> On Tue, Jan 29, 2013 at 2:13 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > On Tuesday 29 January 2013, Andy Shevchenko wrote:
> 
> >> > +   pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
> >>
> >> Where this memory will be freed?
> >> In dependence of the answer could you consider to use
> >> devm_kmalloc or __get_free_page?
> >
> > There is another function like this called pl022_dma_probe()
> > that has the same allocation, and it gets freed in the same place.
> >
> > It's probably worth changing this into something different, but
> > I felt that it didn't belong into this patch. I was also not
> > sure if the best option would be dmam_alloc_coherent, dev_kzalloc,
> > or __get_free_page.
> 
> Actually I once read about a feature where the kernel provides
> a static page full of zeroes or something like this, that would be
> ideal to use in cases like this, then all of this dummy page
> allocation and freeing can be deleted.

You mean empty_zero_page? That only works if this page is
read-only from the perspective of the DMA controller, but
then it would be a good fit, yes.

	Arnd

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
