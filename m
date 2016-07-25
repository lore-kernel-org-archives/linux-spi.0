From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Mon, 25 Jul 2016 17:51:22 +0200
Message-ID: <20160725155122.GA2710@hardcore>
References: <cover.1469174814.git.jglauber@cavium.com>
 <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
 <20160724210452.GB6345@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160724210452.GB6345-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jul 24, 2016 at 10:04:52PM +0100, Mark Brown wrote:
> On Sat, Jul 23, 2016 at 12:42:55PM +0200, Jan Glauber wrote:
> 
> > +config SPI_THUNDERX
> > +	tristate "Cavium ThunderX SPI controller"
> > +	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC
> 
> This is a *weird* and most likely broken set of dependencies - why
> exclude this if we're on Octeon (or Octeon happens to have been enabled
> in a config)?

I agree that it looks weird, the reasoning is that we would like
to avoid making the driver depend on something like ARCH_THUNDER.

So I made the driver depend on the things it actually uses
(PCI for probing and 64BIT because of readq/writeq) and don't care if it
compiles on other platforms too (like x86).

That said, I can remove the !CAVIUM_OCTEON_SOC, it compiles without
errors on MIPS too. Would that be ok?

> > +static void thunderx_spi_clock_enable(struct device *dev, struct octeon_spi *p)
> > +{
> > +	int ret;
> > +
> > +	p->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(p->clk)) {
> > +		p->clk = NULL;
> > +		goto skip;
> > +	}
> 
> This is really not clever - we should be requesting clocks on probe, not
> only when we're trying to enable them, and using devm_ outside of probe
> paths is usually a warning sign too.  Now, this is actually called from
> probe so it works out fine but obviously it'd be better to improve the
> power management to only enable the clock when needed and at that point
> this function will be used and we'll fall into a bad pattern.
> 
> Given how tiny this function is and that we've not bothered splitting
> out any of the other resource acquisition it's probably better to just
> inline it into probe.

OK, I'll merge it into the probe function.

> > +	dev_info(&pdev->dev, "Cavium SPI bus driver probed\n");
> 
> Again, this is just adding noise to the boot log.
> 
> > +#define PCI_DEVICE_ID_THUNDERX_SPI      0xa00b
> > +
> > +static const struct pci_device_id thunderx_spi_pci_id_table[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDERX_SPI) },
> > +	{ 0, }
> > +};
> 
> The define for the device ID doesn't seem to be adding much here.

I find it more readable instead of PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa00b),
or did I miss your point?

thanks,
Jan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
