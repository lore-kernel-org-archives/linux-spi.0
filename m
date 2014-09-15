From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/6] spi: dw: don't use mrst prefix anymore
Date: Mon, 15 Sep 2014 11:21:40 +0300
Message-ID: <1410769300.7023.43.camel@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1410523921-16732-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140913155834.GD7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140913155834.GD7960-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 2014-09-13 at 16:58 +0100, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 03:11:56PM +0300, Andy Shevchenko wrote:
> > Since driver is used on other platforms and debugfs stuff would be useful there
> > as well let's substitute mrst_ by dw_ where it suits. Additionally let's use
> > SPI master device name when print registers dump.
> 
> Could the driver use regmap and get the register dump functionality for
> free?

I didn't check that, probably yes, but this is not my intention right
now.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
