From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Fri, 25 Jul 2014 13:45:47 +0300
Message-ID: <1406285147.8530.13.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
	 <20140725090714.GY1857@lahna.fi.intel.com>
	 <20140725095559.GA1857@lahna.fi.intel.com> <5426556.OzZIXLrofJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5426556.OzZIXLrofJ@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2014-07-25 at 12:19 +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 12:55:59 Mika Westerberg wrote:
> > On Fri, Jul 25, 2014 at 12:07:14PM +0300, Mika Westerberg wrote:
> > > On Fri, Jul 25, 2014 at 10:38:36AM +0200, Arnd Bergmann wrote:
> > > > On Friday 25 July 2014 11:22:49 Mika Westerberg wrote:

[]

> > Something like this?

Arnd, this dependency to certain DMA driver looks really bad.

If we go that way, can we split that part to [another] module and make
it dependent to DW_DMAC?

Or shall we introduce a dmaengine type field in the platform data and
dynamically choose proper filter-whatever-function to get the channel?

> > Hock Leong / Chiaue Ee, are you able to check if this works on your BYT
> > machines?

> What I think you got wrong here (by following my bad advice) is the master
> number. Looking at the code for dw_dma, I think src_master needs to be '1'
> for your driver.

On some SoCs we have up to 4 masters. It's blurry for me how the SPI
should choose those masters. Currently it works fine, but I suspect
there are [might be] performance issues.

What about AVR32 case? We have to fix drivers as well there.

> the dw_dma driver can be simplified a little by removing the special
> case for the request line setting.

Yes, this part I like.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
