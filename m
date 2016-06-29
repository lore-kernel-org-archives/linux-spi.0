From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 21:51:55 +0300
Message-ID: <20160629185155.GG1711@lahna.fi.intel.com>
References: <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629183101.GN6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 29, 2016 at 07:31:01PM +0100, Mark Brown wrote:
> On Wed, Jun 29, 2016 at 07:34:20PM +0300, Mika Westerberg wrote:
> > On Wed, Jun 29, 2016 at 05:21:27PM +0100, Mark Brown wrote:
> 
> > > But can that compatible string be spidev and be matched via the paths DT
> > > uses while still ensuring that enough of the OF matching code is enabled
> > > to cause the check to warn?  That's the problem.
> 
> > No it can't. The match is done in ACPI code not in DT code. See
> > drivers/acpi/bus.c::acpi_of_match_device().
> 
> And we're *sure* that's going to be maintained?  People do use the
> fallback matching that DT does, I don't trust the ACPI maintainers not
> to do the same thing.

That fallback matching does not even work in ACPI like I told you
already. We have no plans to do anything like that either. That's the
reason why we complain if there is PRP0001 without compatible string.

> > > Life would be a lot eaiser if Intel would use DT where it's appropriate,
> > > or if the OF in ACPI stuff were more transparent and needed fewer
> > > special cases.
> 
> > I don't get this. We added PRP0001 and properties because then we can
> > reuse DT bindings in ACPI and thus there is no need to reinvent all
> > these things for ACPI.
> 
> Right, but rather than just define a translation from ACPI to DT and use
> the DT code paths in their entirety for the relevant nodes what's
> happening is that there's a shim layer between ACPI and DT which sort of
> emulates bits of the DT interfaces but not quite and can lead to
> surprises.

Maybe but currently it works fine. And if problems are found they will
be fixed as usual.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
