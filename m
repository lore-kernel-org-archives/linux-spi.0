From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Tue, 28 Apr 2015 18:06:43 -0500
Message-ID: <20150428230643.GC19294@deathray>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
 <20150428012150.GA12713@deathray>
 <20150428143425.GS22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150428143425.GS22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 28, 2015 at 03:34:25PM +0100, Mark Brown wrote:
> On Mon, Apr 27, 2015 at 08:21:50PM -0500, Michael Welling wrote:
> 
> > Before I send another patch how does this look?
> 
> > 	if (gpio_is_valid(spi->cs_gpio)) {
> > 		if (cs_active)
> > 			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
> > 		else
> > 			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> > 	}
> 
> That's good but please have braces around the inner if for clarity.

I try to follow the CodingStyle documentation and it says differently:
http://lxr.free-electrons.com/source/Documentation/CodingStyle#L156

> 
> > If I were to attempt to convert the driver to use the core chipselect support,
> > how would I go about doing it?
> 
> > Is there another driver that I can use for reference?
> 
> Martin and Ezequiel already gave you some good examples - in general
> anything providing the set_cs() operation should be reasonable to look
> at.

I was trying to minimise the impact of the change but will look into using
this method.

I have also been looking at ways of allowing more GPIO chipselects than
DMA channels. Currently this driver is limited to one chipselect per
DMA channel.

Do you have any ideas on how to accomplish this?

The number of chipselects on each channel is very restrictive on the mcspi.
By using multiple GPIO chipselects per DMA channel it opens many more
applications. 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
