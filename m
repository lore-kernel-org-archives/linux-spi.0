From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Fri, 25 Jul 2014 17:55 +0200
Message-ID: <5237362.DJsH7MtqlU@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com> <5426556.OzZIXLrofJ@wuerfel> <1406285147.8530.13.camel@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406285147.8530.13.camel-XvqNBM/wLWRrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday 25 July 2014 13:45:47 Andy Shevchenko wrote:
> On Fri, 2014-07-25 at 12:19 +0200, Arnd Bergmann wrote:
> > On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:
> > > On Fri, Jul 25, 2014 at 12:07:14PM +0300, Mika Westerberg wrote:
> > > > On Fri, Jul 25, 2014 at 10:38:36AM +0200, Arnd Bergmann wrote:
> > > > > On Friday 25 July 2014 11:22:49 Mika Westerberg wrote:
> 
> []
> 
> > > Something like this?
> 
> Arnd, this dependency to certain DMA driver looks really bad.
> 
> If we go that way, can we split that part to [another] module and make
> it dependent to DW_DMAC?

I don't see what you gain from that. The PCI ID will tell you which DMA
engine is being used. The driver already hardcodes a slave_id based on
the PCI ID today, and the 

> Or shall we introduce a dmaengine type field in the platform data and
> dynamically choose proper filter-whatever-function to get the channel?

We already have an interface for this, in the form of
dma_request_slave_channel(), which takes a string identifier that
is used to look up all that information in either device tree or
ACPI. It wouldn't be unreasonable to add a third path in there
to handle hardcoded platform devices, but that's a lot of work.
Note that you still need to encode a reference to the dma engine
in some way to do this right. The current code (with or without Mika's
patch) will break as soon as you have multiple DMA engine devices.

The current plan I think is to convert all platforms to use DT
or ACPI so they get the right data from tables passed by the
platform. I'm a bit puzzled about why Intel wants to support the
non-ACPI non-DT case again. If we have to support this case anyway,
what good will ACPI do us on those platforms?

> > > Hock Leong / Chiaue Ee, are you able to check if this works on your BYT
> > > machines?
> 
> > What I think you got wrong here (by following my bad advice) is the master
> > number. Looking at the code for dw_dma, I think src_master needs to be '1'
> > for your driver.
> 
> On some SoCs we have up to 4 masters. It's blurry for me how the SPI
> should choose those masters. Currently it works fine, but I suspect
> there are [might be] performance issues.

I think it works because the dw-dma defaults to the values used by
the specific implementation in your hardware.

> What about AVR32 case? We have to fix drivers as well there.

which ones?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
