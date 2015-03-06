From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/9] spi: dw-mid: avoid potential NULL dereference
Date: Fri, 06 Mar 2015 14:53:54 +0200
Message-ID: <1425646434.14897.198.camel@linux.intel.com>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1425320166-13788-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150306112858.GI21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306112858.GI21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-03-06 at 11:28 +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 08:15:58PM +0200, Andy Shevchenko wrote:
> > When DMA descriptor allocation fails we should not try to assign any fields in
> > the bad descriptor. The patch adds the necessary checks for that.
> 
> Applied, thanks.  The rest of the series all looks OK but it looks like
> we should get patch 2 into stable like I said in reply to it - apply
> that on fix/dw 

Okay, I have resent it just in case.

> and then everything else on a merge of that and topic/dw.

Just to kindly remind that it has a dependency on two previous series,
one of them touches SPI core.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
