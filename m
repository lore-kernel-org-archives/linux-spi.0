From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 17:35:28 +0300
Message-ID: <20160628143528.GK1711@lahna.fi.intel.com>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628114742.GM17217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 28, 2016 at 12:47:42PM +0100, Mark Brown wrote:
> On Tue, Jun 28, 2016 at 12:22:34PM +0300, Mika Westerberg wrote:
> > On Mon, Jun 27, 2016 at 01:24:48PM +0100, Mark Brown wrote:
> 
> > > Please allow a reasonable time for review, especially for an invasive
> > > change like this which needs a bunch of research to figure out how
> > > sensible the infrastructure to shove DT into ACPI is.
> 
> > Sure.
> 
> The big thing I need to check out here is if this breaks the check for
> directly listing spidev in DT so we end up with the same abstraction
> failures that plague DT since people refuse to describe their hardware.

You are talking about this check, right?

        if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
                dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
                WARN_ON(spi->dev.of_node &&
                        !of_match_device(spidev_dt_ids, &spi->dev));
        } 

As far as I can tell it should work, with the patch applied, just as it worked
before. For ACPI there is no possibility to list the node directly in ASL code
as we always require DT compatible string in _DSD.

In other words we never match using name of the node.

> > The /dev/spi-0 then can be used analogous to /dev/i2c-0. You first need
> > to program wanted chip select using those new ioctls. Then you can use
> > the device as normal spidev (all existing file operations and ioctls
> > still work). You can pick another chip select as needed. If there is an
> > actual SPI device bound to a chip select, that cannot be used through
> > /dev/spi-0.
> 
> The trouble with this is that unlike I2C using SPI devices involves
> toggling signals that we don't definitively know are connected to the
> bus.  It's therefore much less safe than the equivalent thing for DT.
> If we went the extra step and required that a slave be listed in DT then
> that is much less of a concern.

OK, I see.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
