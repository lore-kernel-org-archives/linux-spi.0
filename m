From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 18:23:38 +0300
Message-ID: <20160628152338.GN1711@lahna.fi.intel.com>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160628150752.GO17217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 28, 2016 at 04:07:52PM +0100, Mark Brown wrote:
> On Tue, Jun 28, 2016 at 05:35:28PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 28, 2016 at 12:47:42PM +0100, Mark Brown wrote:
> 
> > > The big thing I need to check out here is if this breaks the check for
> > > directly listing spidev in DT so we end up with the same abstraction
> > > failures that plague DT since people refuse to describe their hardware.
> 
> > You are talking about this check, right?
> 
> >         if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
> >                 dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
> >                 WARN_ON(spi->dev.of_node &&
> >                         !of_match_device(spidev_dt_ids, &spi->dev));
> >         } 
> 
> > As far as I can tell it should work, with the patch applied, just as it worked
> > before. For ACPI there is no possibility to list the node directly in ASL code
> > as we always require DT compatible string in _DSD.
> 
> Yes, but does of_node get set and does of_match_device() DTRT if it's a
> DT into ACPI device?

of_node will be NULL and of_match_device() will not match (returns NULL
as well).

> > In other words we never match using name of the node.
> 
> If that's the case then it's definitely broken - we either always warn
> or never warn, neither is good.

For DT we warn if the device is used directly (by the node name) as
previously. For ACPI we never warn because it is not possible to use the
node name directly. We always require use of a proper compatible string.

I don't see how that is broken.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
