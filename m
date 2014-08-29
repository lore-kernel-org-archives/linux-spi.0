From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 0/5] spi: dw-pci: cleanup the driver
Date: Fri, 29 Aug 2014 14:14:38 +0300
Message-ID: <1409310878.30155.37.camel@linux.intel.com>
References: <1409305303-32631-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140829105635.GM29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140829105635.GM29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2014-08-29 at 11:56 +0100, Mark Brown wrote:
> On Fri, Aug 29, 2014 at 12:41:38PM +0300, Andy Shevchenko wrote:
> > This set of small clean ups of the driver.
> > 
> > Changelog v3:
> > - rebase on top of recent linux-next keeping in mind NAck of "spi: dw-mid:
> >   don't leak memory on exit"
> 
> Who nacked it?

Me for now. I would like to send it as a part of improving spi-dw-mid.c.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
