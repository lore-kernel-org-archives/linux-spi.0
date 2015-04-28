From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Tue, 28 Apr 2015 17:50:57 -0500
Message-ID: <20150428225057.GB19294@deathray>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
 <20150428012150.GA12713@deathray>
 <553F9359.2010901@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <553F9359.2010901@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 28, 2015 at 11:04:09AM -0300, Ezequiel Garcia wrote:
> On 04/27/2015 10:21 PM, Michael Welling wrote:
> > On Mon, Apr 27, 2015 at 08:55:50PM +0100, Mark Brown wrote:
> >> On Sun, Apr 26, 2015 at 10:44:30PM -0500, Michael Welling wrote:
> >>
> >>> +	if (gpio_is_valid(spi->cs_gpio)) {
> >>> +		gpio_set_value(spi->cs_gpio, (cs_active) ?
> >>> +			!!(spi->mode & SPI_CS_HIGH) :
> >>> +			!(spi->mode & SPI_CS_HIGH));
> >>> +	}
> >>
> >> Two problems here.  One is that the above logic statement is just not
> >> readable (the repitition of hecks, the ternery operator, the
> >> indentation...) and the other is that the core chipselect support
> >> already handles GPIO chipselects so you should really be converting the
> >> driver to use that.  At the very least the code needs to be legible
> >> though.
> > 
> > Before I send another patch how does this look?
> > 
> > 	if (gpio_is_valid(spi->cs_gpio)) {
> > 		if (cs_active)
> > 			gpio_set_value(spi->cs_gpio, spi->mode & SPI_CS_HIGH);
> > 		else
> > 			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> > 	}
> > 
> > If I were to attempt to convert the driver to use the core chipselect support,
> > how would I go about doing it?
> > 
> > Is there another driver that I can use for reference?
> 
> We've recently done that for spi-img-spfi.c.
>

Okay, thanks for pointing that out.
 
> -- 
> Ezequiel
