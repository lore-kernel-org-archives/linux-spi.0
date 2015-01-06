From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/dln2: simplify return flow for
 dln2_spi_transfer_setup and dln2_spi_enable
Date: Tue, 6 Jan 2015 17:02:59 +0000
Message-ID: <20150106170259.GC2634@sirena.org.uk>
References: <1420550620-12693-1-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2zue9K3IhLF/3KAd"
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420550620-12693-1-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2zue9K3IhLF/3KAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 03:23:40PM +0200, Laurentiu Palcu wrote:
> This fixes the following kbuild test robot warnings:
>=20
> >> drivers/spi/spi-dln2.c:124:1-4: WARNING: end returns can be simplified=
 if negative or 0 value
> >> drivers/spi/spi-dln2.c:656:1-4: WARNING: end returns can be simplified=
 if negative or 0 value
>=20
> Additionally, fix a comment after switching from CONFIG_PM_RUNTIME to
> CONFIG_PM.

Applied, thanks.

--2zue9K3IhLF/3KAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrBVCAAoJECTWi3JdVIfQnBwH/3eAcp76uYc8icPPYu/BH755
QFt4enUbugacPdcvpie6grlPp+w8UbEurmQPkvLiGLXIGVHeKgLfA8yKEDU6V06O
/w3WW/VrGXoP5zMhCO8hc4ByomrvfLFyDCej/ETl4hhKELhAzpYj0BBwSNkgnvJ5
zBfBv8rfcK5Mzdjq+uOMyUzX5bSfjQJitumQHQYdL/n+NnE7Ep7op2IEW0xbjWe9
8b/23MfKNx96UcCfziUVS1SV+ozjzNlAHQwdKHcNCmPEyGi25DvSekdFK1wA0Upy
JSsTzGlpeCKEluIB6eSOP1agGvQpAuNpzFk24ogqWysvxZ2a3llEvPvJGZv7b7w=
=GB+E
-----END PGP SIGNATURE-----

--2zue9K3IhLF/3KAd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
