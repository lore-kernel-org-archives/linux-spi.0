From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Mon, 27 Apr 2015 20:21:50 -0500
Message-ID: <20150428012150.GA12713@deathray>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150427195550.GE22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 27, 2015 at 08:55:50PM +0100, Mark Brown wrote:
> On Sun, Apr 26, 2015 at 10:44:30PM -0500, Michael Welling wrote:
> 
> > +	if (gpio_is_valid(spi->cs_gpio)) {
> > +		gpio_set_value(spi->cs_gpio, (cs_active) ?
> > +			!!(spi->mode & SPI_CS_HIGH) :
> > +			!(spi->mode & SPI_CS_HIGH));
> > +	}
> 
> Two problems here.  One is that the above logic statement is just not
> readable (the repitition of hecks, the ternery operator, the
> indentation...) and the other is that the core chipselect support
> already handles GPIO chipselects so you should really be converting the
> driver to use that.  At the very least the code needs to be legible
> though.

Before I send another patch how does this look?

	if (gpio_is_valid(spi->cs_gpio)) {
		if (cs_active)
			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
		else
			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
	}

If I were to attempt to convert the driver to use the core chipselect support,
how would I go about doing it?

Is there another driver that I can use for reference?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
