From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Add ACPI probing support
Date: Mon, 4 Jul 2016 16:08:06 +0300
Message-ID: <20160704130806.GB23527@lahna.fi.intel.com>
References: <1467628683-5783-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160704125600.GB6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160704125600.GB6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jul 04, 2016 at 02:56:00PM +0200, Mark Brown wrote:
> On Mon, Jul 04, 2016 at 01:38:03PM +0300, Mika Westerberg wrote:
> 
> > +	/*
> > +	 * The ACPI SPT000* devices are only meant for development and
> > +	 * testing. Systems used in production should have a proper ACPI
> > +	 * description of the connected peripheral and they should also use
> > +	 * a proper driver instead of poking directly to the SPI bus.
> > +	 */
> > +	if (has_acpi_companion(&spi->dev))
> > +		dev_warn(&spi->dev, "do not use this driver in production systems!\n");
> > +
> 
> This is fine for now since all the ACPI devices are dummy ones but as
> soon as someone comes up with an actual ACPI ID for something that
> should be managed via spidev it'll need changing...

Sure. That's why the comment above also mentions SPT000* there.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
