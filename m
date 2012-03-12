From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: mfd: mc13xxx: add I2C support, V2
Date: Mon, 12 Mar 2012 14:06:20 +0000
Message-ID: <20120312140620.GB14020@sirena.org.uk>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
 <20120311115018.GA16825@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120311115018.GA16825-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 11, 2012 at 12:50:18PM +0100, Wolfram Sang wrote:

> free, if this is desired. I think the regmap approach should have been tried
> before we go custom. sound/soc/codecs/ad193x.c might give an impression how
> regmap spi/i2c in one driver could look like.

There's a bunch of other examples in sound/soc and also the wm831x PMIC
driver in drivers/mfd.  For an initial conversion I'd not worry about
the cache, especially with some of the older PMICs hardware designers
were known to come up with some "innovative usability solutions" which
can cause hassle.
