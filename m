From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 19:34:20 +0300
Message-ID: <20160629163420.GC1711@lahna.fi.intel.com>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629162127.GA6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 29, 2016 at 05:21:27PM +0100, Mark Brown wrote:
> On Wed, Jun 29, 2016 at 12:13:04PM +0300, Mika Westerberg wrote:
> > On Tue, Jun 28, 2016 at 05:18:22PM +0100, Mark Brown wrote:
> 
> > > So you're saying that it's not possible for ACPI to use anything
> > > *except* an explicitly listed compatible string to bind?  What we want
> > > to avoid is any ACPI tables that explicitly list spidev since that's a
> > > total abstraction failure.
> 
> > That's exactly what I'm saying. We never match using the node name
> > (which is always 32-bit "string" like "SPI0"). For PRP0001 match to
> > succeeed you need to have "compatible" property.
> 
> > Without the "compatible" property you get a warning from ACPI core:
> 
> >   \_SB.SPI1.SPID requires 'compatible' property
> 
> > and it will not match anything.
> 
> But can that compatible string be spidev and be matched via the paths DT
> uses while still ensuring that enough of the OF matching code is enabled
> to cause the check to warn?  That's the problem.

No it can't. The match is done in ACPI code not in DT code. See
drivers/acpi/bus.c::acpi_of_match_device().

> Life would be a lot eaiser if Intel would use DT where it's appropriate,
> or if the OF in ACPI stuff were more transparent and needed fewer
> special cases.

I don't get this. We added PRP0001 and properties because then we can
reuse DT bindings in ACPI and thus there is no need to reinvent all
these things for ACPI.

This is not a special case at all. I'm merely enabling the same thing to
work in ACPI systems (sans the node name match).
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
