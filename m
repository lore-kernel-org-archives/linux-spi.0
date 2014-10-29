From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Wed, 29 Oct 2014 15:20:48 +0200
Message-ID: <1414588848.2396.64.camel@linux.intel.com>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20141028224156.GN18557@sirena.org.uk>
	 <1414579076.2396.62.camel@linux.intel.com>
	 <20141029111712.GE18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141029111712.GE18557-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-10-29 at 11:17 +0000, Mark Brown wrote:
> On Wed, Oct 29, 2014 at 12:37:56PM +0200, Andy Shevchenko wrote:
> > On Tue, 2014-10-28 at 22:41 +0000, Mark Brown wrote:
> 
> > >   Can you please also send a patch for Linus
> > > setting SPI_MASTER_MUST_RX and SPI_MASTER_MUST_TX - this is a bug which
> > > should be fixed in mainline but these seem a bit big for merge right
> > > now, those flags will cause the core to always ensure that both
> > > directions have data avoiding the issue?
> 
> > I'm sorry I didn't quite understand that bug.
> 
> > When those bits are set the core will always provide valid tx_buf and
> > rx_buf pointers. How would it help us? Currently driver relies on tx_dma
> > and rx_dma which are provided by clients if I understood correctly.
> 
> Uh, are you sure

There is a function in spi-dw.c called map_dma_buffers() which uses
tx_dma and rx_dma pointers. I don't see where they are initialized.

>  - how exactly has this been tested?  

I don't know how it was tested before, but, besides intel-mid-dma is
somehow broken (I won't spend time to patch it), I'm using patch I
already published which converts driver to use dw_dmac driver. With it I
run tests on a loop back.

> tx_dma and rx_dma
> *can* be provided by users but vanishingly few actually do so.  Drivers
> must not rely on the caller doing this, the feature will be going away
> apart from anything else.  If the driver is relying on this it probably
> needs to have the DMA support that's there removed as a fix and should
> be converted to use the core DMA mapping functionality in -next.

So, regarding to above what would you like me to do as next step?

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
