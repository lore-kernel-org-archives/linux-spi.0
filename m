From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] spi: dw: amend warning message
Date: Wed, 07 Jan 2015 16:58:33 +0200
Message-ID: <1420642713.12456.22.camel@linux.intel.com>
References: <1420207565-14712-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1420207868.12456.16.camel@linux.intel.com>
	 <20150105202106.GO2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150105202106.GO2634-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2015-01-05 at 20:21 +0000, Mark Brown wrote:
> On Fri, Jan 02, 2015 at 04:11:08PM +0200, Andy Shevchenko wrote:
> > On Fri, 2015-01-02 at 16:06 +0200, Andy Shevchenko wrote:
> 
> > > +			dev_warn(dev, "DMA init failed\n");
> 
> > Oops, based on some WIP patches, though still applies smoothly on top of
> > recent linux-next.
> 
> Not with git am it doesn't (I suspect mostly because it's easily
> confused by not having the required SHA1s but still).

git am -C1 -s helps, but anyway I submitted v2 with one additional patch
(the add-on I suggested to Alex Lin to print FIFO size when
autodetection happened).

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
