From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 20:20:59 +0100
Message-ID: <20160629192059.GV6247@sirena.org.uk>
References: <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4HoONH8zr3Mj5MZN"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629185155.GG1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4HoONH8zr3Mj5MZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 09:51:55PM +0300, Mika Westerberg wrote:
> On Wed, Jun 29, 2016 at 07:31:01PM +0100, Mark Brown wrote:

> > And we're *sure* that's going to be maintained?  People do use the
> > fallback matching that DT does, I don't trust the ACPI maintainers not
> > to do the same thing.

> That fallback matching does not even work in ACPI like I told you
> already. We have no plans to do anything like that either. That's the
> reason why we complain if there is PRP0001 without compatible string.

No, you're completely missing the point here.  The problem is someone
using something like linux,spidev as a compatible string and going into
fallback matching on SPI bus IDs rather than compatible strings.  I just
don't have confidence that someone isn't going to try to add that
fallback path given that it's used for DT.

> > Right, but rather than just define a translation from ACPI to DT and use
> > the DT code paths in their entirety for the relevant nodes what's
> > happening is that there's a shim layer between ACPI and DT which sort of
> > emulates bits of the DT interfaces but not quite and can lead to
> > surprises.

> Maybe but currently it works fine. And if problems are found they will
> be fixed as usual.

I'm worried that the reason it's working fine may be that there is very
little usage, and that there may be more gotchas like we're already
seeing lurking about.

--4HoONH8zr3Mj5MZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdB+aAAoJECTWi3JdVIfQULwH/iCyf4gscKdD1QkyGcjGPx23
+JlTJ2R0R3Lx26GjQIUmNrsktuuNq7vewcVJMxOQ1RgUqY7+6ctJ1qu4dJGnKyoB
TcHHzcJBaGc4oYBP5efikNogu+AF+oCO2Xef4wq/BiwRr/PDHykBiGcCxyc6XoFE
HDa0jg1WKWbIss2YvUX5/woEsaTyy8/b6XkpZhL2zMMb9c7MB4TC2Yorb+Sf/416
0hb6hFLSiX8T8pc7vCcyNYJvJOOxE9Cy/38dqWc/EcRvCmHThVPYOjprN/VqGf1H
1ClLxCKfdikMRUXAN1jCRSkI5HYLVOySF0ueaIJR0v44C3biJB5E/9WjIYJMCeA=
=Bd56
-----END PGP SIGNATURE-----

--4HoONH8zr3Mj5MZN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
