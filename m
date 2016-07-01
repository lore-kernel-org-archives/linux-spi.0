From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Fri, 1 Jul 2016 12:12:35 +0200
Message-ID: <20160701101235.GN6247@sirena.org.uk>
References: <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
 <20160629192059.GV6247@sirena.org.uk>
 <20160630124931.GD23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dngyMJhgXGAL5Gb8"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160630124931.GD23527-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dngyMJhgXGAL5Gb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 03:49:31PM +0300, Mika Westerberg wrote:

> If someone is using "linux,spidev" as compatible string it will not
> match anything and we are not going to add any kind of fallback to the
> ACPI core for that.

> Of course we cannot predict what happens in the future but is it really
> preventing merging of this patch?

Yes.  People are *way* too happy to abuse spidev in board descriptions,
especially people working in the areas these boards seem to target.
There seems to be little engagement with the abstractions involved or
interest in keeping things working well long term in more general
applications, it's all about quick hacks now.

Given the push for compatibility with DT and reuse of the existing
software stack I just don't have any confidence that the fallback path
isn't going to be implemented, and relying on anyone noticing that these
warnings are broken when it does get added (or that spidev is affected
at all) just doesn't seem wise to me.

> > I'm worried that the reason it's working fine may be that there is very
> > little usage, and that there may be more gotchas like we're already
> > seeing lurking about.

> With more usage I'm sure we can improve things. After all the end goal
> is to let single driver to work on both DT and ACPI systems with minimal
> changes. If you think the current implementation is flawed, nothing
> prevents you from proposing better alternative :-)

I've been suggesting that you should just use DT!

--dngyMJhgXGAL5Gb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdkIRAAoJECTWi3JdVIfQzckH/jVi8e6CuA5UadDqkQisEFaX
sJ1aNQBtFcnJyukock5Fco2HfrrWbFTugioBJ/QCJioYrOfry6C+0/E0NrtWZOEw
i1XVb5qvk7VjKUprOc9v+Sd1Ka193dC9iVdMWp1D3yUwIrflzmBfQ0mrnhPgFMvY
rhS05UC0nDnnbXn43DVigPiMI1lXdHi5GNhjVlIRtQxmiH+GkRfPSlHGLCD/3bl8
5ETtbO/1o0fdMc2hNEQleN4Q8/83q3r+gBlJEzCm2Lmg+dTPZX2iHhvydMWdS90v
v+mtbS0mto2D4hy9CmtLmx9EQEkGuoy66MXRhMYs0rFv2G99Bg+B+lO4C7vbnDA=
=k+ML
-----END PGP SIGNATURE-----

--dngyMJhgXGAL5Gb8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
