From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 19:31:01 +0100
Message-ID: <20160629183101.GN6247@sirena.org.uk>
References: <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629163420.GC1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 07:34:20PM +0300, Mika Westerberg wrote:
> On Wed, Jun 29, 2016 at 05:21:27PM +0100, Mark Brown wrote:

> > But can that compatible string be spidev and be matched via the paths DT
> > uses while still ensuring that enough of the OF matching code is enabled
> > to cause the check to warn?  That's the problem.

> No it can't. The match is done in ACPI code not in DT code. See
> drivers/acpi/bus.c::acpi_of_match_device().

And we're *sure* that's going to be maintained?  People do use the
fallback matching that DT does, I don't trust the ACPI maintainers not
to do the same thing.

> > Life would be a lot eaiser if Intel would use DT where it's appropriate,
> > or if the OF in ACPI stuff were more transparent and needed fewer
> > special cases.

> I don't get this. We added PRP0001 and properties because then we can
> reuse DT bindings in ACPI and thus there is no need to reinvent all
> these things for ACPI.

Right, but rather than just define a translation from ACPI to DT and use
the DT code paths in their entirety for the relevant nodes what's
happening is that there's a shim layer between ACPI and DT which sort of
emulates bits of the DT interfaces but not quite and can lead to
surprises.

> This is not a special case at all. I'm merely enabling the same thing to
> work in ACPI systems (sans the node name match).

The force DT into ACPI layer that exists in the ACPI code is the special
case here.

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdBPkAAoJECTWi3JdVIfQ0JoH/1ptWUQflN/f4PWBdG2QfD9b
noPngQZGnNhFogkvewCFXSnCkxZ4s8krry7vKr2g8eO3zv2zwYJ/d+y8hlZ4Xpov
QYV7LOcQd1diEunxCQ9q+FSMRgJKo6Tnip5PRQ7Yg74E8u/fAKFIdDPIUoFuvM9I
E03ILtSSlKsPTJSt12vdDz/xbzX7znSVEP53L6ypfSyT59gXK56jSvTjRhW4VkTF
/Ieln0gkYVyezQs41xaCvd3RRuleAI6YwwXpMj9rnURc9wZpJUMnPvsanXWvE9ml
Yg8aiwQYw8l/hTeBdFzC7Cl8dgI7KAe6svAoN1/s3O8oFMNv5OE8Dx6P6TjOWlw=
=G1gy
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
