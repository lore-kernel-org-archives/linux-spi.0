From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
Date: Thu, 27 Feb 2014 15:42:50 +0800
Message-ID: <20140227074247.GA13537@S2101-09.ap.freescale.net>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
 <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
 <20140226141947.GE23892@S2101-09.ap.freescale.net>
 <20140226153822.GC2394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140226153822.GC2394-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 27, 2014 at 12:38:22AM +0900, Mark Brown wrote:
> On Wed, Feb 26, 2014 at 10:19:49PM +0800, Shawn Guo wrote:
> > On Tue, Feb 25, 2014 at 09:08:30AM +0000, Mark Rutland wrote:
> 
> > > > +- use-dma: the bool decide if use dma method in DSPI transfering.
> 
> > > Why can the OS not decide this based on the presence of dmas which it
> > > can use?
> 
> > Yes, OS/driver should decide to use DMA or not, but it shouldn't be
> > based on the presence of 'dmas' property.  The DMA is a hardware
> > resource just like IRQ.  It should be just there in client device's node
> > as long as the SoC design assigns the channel to the device.  The device
> > driver should make the decision when DMA should be used, e.g. big amount
> > data transfer, and when PIO should be used, e.g. small data.
> 
> Right, that's very common - but that decision is usually taken on a per
> transfer basis so a DT property would seem odd, especially just a simple
> boolean.

Yea, I guess we're on the same page - the decision should be made by
the device driver on its own not the device tree.

Shawn

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
