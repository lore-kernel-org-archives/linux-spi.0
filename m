From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
Date: Wed, 2 Sep 2015 10:40:19 +0300
Message-ID: <20150902074019.GE1609@lahna.fi.intel.com>
References: <1441073073.12012.3.camel@ingics.com>
 <55E54754.1060002@linux.intel.com>
 <20150901184335.GY5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150901184335.GY5313-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Sep 01, 2015 at 07:43:35PM +0100, Mark Brown wrote:
> > What I'm wondering is this binding below correct in arch/arm/plat-pxa/ssp.c?
> > LPSS_SSP was meant to be for Intel Intel Low Power Subsystem SPI.
> 
> > "{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP }"
> 
> > Mika, Daniel: do you know is there any change there is a Marvell PXA
> > platform compatible with Intel LPSS or is above binding bogus?
> 
> I bet it's just cut'n'paste because everything else about the driver and
> all the DT is for Marvell stuff.

I agree.

That entry definitely should not be there.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
