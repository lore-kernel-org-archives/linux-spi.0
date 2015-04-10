From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Fri, 10 Apr 2015 19:51:08 +0100
Message-ID: <20150410185108.GT6023@sirena.org.uk>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MRlG3jvlVW8QFMda"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428340592-3196-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MRlG3jvlVW8QFMda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 05:16:31PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Transforms the bcm-2835 native SPI-chip select to their gpio-cs equivalen=
t.

Sorry, acutally it does - applied, thanks.

--MRlG3jvlVW8QFMda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKBubAAoJECTWi3JdVIfQ3dUH/0xPBo+ZpVhgaGbO3/hnMgd4
i8Xxg+fbcjLVvhHBcooP9YvB+mbC6AfCJg+zUHn5sP295AXpFeV3KAr5Mk6iNJ0R
mKSwZtpo2rbrNEJspWIgGkDTv+2XpQ1EAmZy2lViFEtH+mf5mVlJidHFK5lB+hSW
z6jDn8yIT4Z0/S4FaVjmgdDpfpV/LUlX+zkcbzg6xpGb9Iq7uHEjqhH1HCt/SOPf
4hBFHJyWaDq+B2OUODArRnWR1N9BzfHEORArLDLsl22lwK0h/KQiugmbki/p3MyJ
KM5tIJscs+BfkTDoA/b3f3CS+1a+TYcyAQfbhu6pRxuuRbQkxP6E9pNA+S7K7QI=
=26PK
-----END PGP SIGNATURE-----

--MRlG3jvlVW8QFMda--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
