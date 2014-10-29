From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: dw-mid: fix simplex DMA transfers
Date: Wed, 29 Oct 2014 12:37:56 +0200
Message-ID: <1414579076.2396.62.camel@linux.intel.com>
References: <1414513502-595-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20141028224156.GN18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141028224156.GN18557-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2014-10-28 at 22:41 +0000, Mark Brown wrote:
> On Tue, Oct 28, 2014 at 06:25:00PM +0200, Andy Shevchenko wrote:
> > In current shape the driver relies on both TX and RX transfers when DMA is
> > enabled. In case of simplex transfer the driver will stuck, since call back
> > function will never achieve the proper condition to finish the transfer.
> 
> Applied both, thanks.

Thanks!

>   Can you please also send a patch for Linus
> setting SPI_MASTER_MUST_RX and SPI_MASTER_MUST_TX - this is a bug which
> should be fixed in mainline but these seem a bit big for merge right
> now, those flags will cause the core to always ensure that both
> directions have data avoiding the issue?

I'm sorry I didn't quite understand that bug.

When those bits are set the core will always provide valid tx_buf and
rx_buf pointers. How would it help us? Currently driver relies on tx_dma
and rx_dma which are provided by clients if I understood correctly.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
