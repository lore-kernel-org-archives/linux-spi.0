From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] spi: pxa2xx: Don't touch CS pin until we have a
 transfer pending
Date: Fri, 28 Jul 2017 13:51:42 +0300
Message-ID: <20170728105142.GN2369@lahna.fi.intel.com>
References: <20170727154933.14143-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170727154933.14143-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jul 27, 2017 at 06:49:33PM +0300, Andy Shevchenko wrote:
> GPIO descriptors, when being requested, may configure pin at the same
> time. In case of SPI chip select we shouldn't do any assumptions of the
> state of pin since we don't know yet what chip is connected there and if
> it uses high or low active state. So, leave the state of pin as is until
> transfer will start.
> 
> Fixes: 99f499cd6504 ("spi: pxa2xx: Add support for GPIO descriptor chip selects")
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Yes, I think this is the right thing to do,

Acked-by: Mika Westeberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
