From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: omap2-mcspi: Add gpio_request and init CS
Date: Fri, 8 May 2015 12:37:37 -0500
Message-ID: <20150508173737.GA5991@deathray>
References: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
 <1431041814-24757-3-git-send-email-mwelling@ieee.org>
 <20150508170916.GD2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150508170916.GD2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 08, 2015 at 06:09:16PM +0100, Mark Brown wrote:
> On Thu, May 07, 2015 at 06:36:54PM -0500, Michael Welling wrote:
> 
> > +	if (gpio_is_valid(spi->cs_gpio)) {
> > +		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
> > +			gpio_direction_output(spi->cs_gpio,
> > +			!(spi->mode & SPI_CS_HIGH));
> > +	}
> 
> I'm not seeing anything that frees this GPIO?

Ooops I forgot to add this to the cleanup function.

It appears that the transfer_one patch got applied so how should I
provide the new version of this patch?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
