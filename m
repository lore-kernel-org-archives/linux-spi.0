From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: dw-pci: fix bug when regs left uninitialized
Date: Wed, 27 Aug 2014 17:53:19 +0300
Message-ID: <1409151199.30155.20.camel@linux.intel.com>
References: <1409145672-10258-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20140827144608.GE17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140827144608.GE17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-08-27 at 15:46 +0100, Mark Brown wrote:
> On Wed, Aug 27, 2014 at 04:21:12PM +0300, Andy Shevchenko wrote:
> > The commit 04f421e7 "spi: dw: use managed resources" changes drivers to use
> > managed functions, but seems wasn't properly tested in PCI case. The regs field
> > of struct dw_spi left uninitialized. Thus, kernel crashes when tries to access
> > to the SPI controller registers. This patch fixes the issue.
> 
> Applied.  Please use the Fixes: tag and use a minimum of 12 characters
> for the commit ID (to avoid collisions).

Noted, thank you!

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
