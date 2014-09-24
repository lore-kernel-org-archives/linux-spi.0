From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 05/10] spi: dw: disable all interrupts first when pump
 message
Date: Wed, 24 Sep 2014 13:38:17 +0300
Message-ID: <1411555097.30231.14.camel@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1411060140-2801-6-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140924084724.GH4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140924084724.GH4015-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-09-24 at 09:47 +0100, Mark Brown wrote:
> On Thu, Sep 18, 2014 at 08:08:55PM +0300, Andy Shevchenko wrote:
> 
> > Always disable all interrupts before pump message. Enable them only for PIO
> > mode.
> 
> Why?  
> 
> It's also not very obvious looking at the diff how this actually works,
> the connection between DMA based transfer and interrupt disabling is
> not clear.

It's a really good question and needs to be investigated more.

If I don't disable interrupts I'm getting sometimes overrun/underrun
interrupt. But we have no proper transfer handler in case of DMA.

Perhaps we should carefully handle that case.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
