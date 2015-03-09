From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 0/3] spi: dw: refactor to use SPI core message
 handling
Date: Mon, 09 Mar 2015 13:41:36 +0200
Message-ID: <1425901296.14897.221.camel@linux.intel.com>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150306202822.GE21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306202822.GE21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-03-06 at 20:28 +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 02:58:54PM +0200, Andy Shevchenko wrote:
> > This patch series is dedicated to refactoring of spi-dw driver to use SPI core
> > message handling. The driver has been tested in PIO mode on Intel Medfield
> > device in loopback mode.
> > 
> > Note, the patch 3/3 depends on [1].
> > 
> > [1] http://www.spinics.net/lists/linux-spi/msg02982.html
> 
> Please ensure that your e-mails are readable by humans - if you're
> referencing some other patch include a human readable description.

Noted! Thanks for tip.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
