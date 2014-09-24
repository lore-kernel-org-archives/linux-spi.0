From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 04/10] spi: dw-mid: follow new DMAengine workflow
Date: Wed, 24 Sep 2014 13:35:38 +0300
Message-ID: <1411554938.30231.12.camel@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1411060140-2801-5-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140924084453.GG4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924084453.GG4015-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-09-24 at 09:44 +0100, Mark Brown wrote:
> On Thu, Sep 18, 2014 at 08:08:54PM +0300, Andy Shevchenko wrote:
> > Though intel-mid-dma does not follow a new DMA workflow let's prepare SPI DW
> > driver for that.
> 
> I don't understand what this change is supposed to do - what is "a new
> DMA workflow"?


The client is obliged to call dma_async_issue_pending() which starts the
actual transfers. Old DMA drivers do not follow this, since requirement
was introduced in 2011 IIRC.

Current DMA driver for spi-dw doesn't follow this, but dw_dmac does.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
