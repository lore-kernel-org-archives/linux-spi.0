From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend 1/5] spi: bcm2835: Add GPIOLIB dependency
Date: Tue, 5 May 2015 00:34:21 +0100
Message-ID: <20150504233421.GW22845@sirena.org.uk>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
 <1430778649-28126-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AxneKT3mNNwGaQeK"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430778649-28126-2-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AxneKT3mNNwGaQeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 03:30:45PM -0700, Guenter Roeck wrote:
> Fix:
>=20
> drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
> drivers/spi/spi-bcm2835.c:356:21: error:

This duplicates a patch someone else sent.

--AxneKT3mNNwGaQeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSAH9AAoJECTWi3JdVIfQlm8H/j86HMUxi/eCT541pYEgn9xk
C1J0FEw/5zSjy8E92RS9IjhpmisJ0v0+NY5yyUzR6ZNRHGkMVUajBI0ihGXz9TeJ
o9rsyqup12BY7iETmT4oObz9tU3FXxeRrA25t03j9tETGYMgFqDb9Z6bZsq57Zgc
YgdNBgYE/mPqlYQw/SCvja57RN9kgNvCNROeKkZrt/FNq2HZHqvefWyRcC6U+E1C
AGCqym98Bbk5iuKgE5/ns4r9TVK+IlF8FxhFMWR85B81taRQmJGXLMTS8uHqYCPP
fyh32F6zpY4s0xCY9jgdIMIzWNBG+ZVYOl0LbrfD8yUJrtJJ0xvmTIN3GZ4eFME=
=U2Ln
-----END PGP SIGNATURE-----

--AxneKT3mNNwGaQeK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
