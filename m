From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Thu, 30 Jun 2016 15:49:31 +0300
Message-ID: <20160630124931.GD23527@lahna.fi.intel.com>
References: <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
 <20160629192059.GV6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629192059.GV6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 29, 2016 at 08:20:59PM +0100, Mark Brown wrote:
> On Wed, Jun 29, 2016 at 09:51:55PM +0300, Mika Westerberg wrote:
> > On Wed, Jun 29, 2016 at 07:31:01PM +0100, Mark Brown wrote:
> 
> > > And we're *sure* that's going to be maintained?  People do use the
> > > fallback matching that DT does, I don't trust the ACPI maintainers not
> > > to do the same thing.
> 
> > That fallback matching does not even work in ACPI like I told you
> > already. We have no plans to do anything like that either. That's the
> > reason why we complain if there is PRP0001 without compatible string.
> 
> No, you're completely missing the point here.  The problem is someone
> using something like linux,spidev as a compatible string and going into
> fallback matching on SPI bus IDs rather than compatible strings.  I just
> don't have confidence that someone isn't going to try to add that
> fallback path given that it's used for DT.

If someone is using "linux,spidev" as compatible string it will not
match anything and we are not going to add any kind of fallback to the
ACPI core for that.

Of course we cannot predict what happens in the future but is it really
preventing merging of this patch?

What I'm simply trying to achieve is to use the existing two DT
compatible strings from ACPI. I've tested that it works fine and
provided you all the evidence that it does not break the check for
misusing DT.

> > > Right, but rather than just define a translation from ACPI to DT and use
> > > the DT code paths in their entirety for the relevant nodes what's
> > > happening is that there's a shim layer between ACPI and DT which sort of
> > > emulates bits of the DT interfaces but not quite and can lead to
> > > surprises.
> 
> > Maybe but currently it works fine. And if problems are found they will
> > be fixed as usual.
> 
> I'm worried that the reason it's working fine may be that there is very
> little usage, and that there may be more gotchas like we're already
> seeing lurking about.

With more usage I'm sure we can improve things. After all the end goal
is to let single driver to work on both DT and ACPI systems with minimal
changes. If you think the current implementation is flawed, nothing
prevents you from proposing better alternative :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
