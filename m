From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: Add GPIOLIB dependency
Date: Tue, 14 Apr 2015 21:08:28 +0100
Message-ID: <20150414200828.GP6023@sirena.org.uk>
References: <1428985488-3811-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1/FhgkYIk4AzJcsY"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428985488-3811-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1/FhgkYIk4AzJcsY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 09:24:48PM -0700, Guenter Roeck wrote:
> Fix:
>=20
> drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
> drivers/spi/spi-bcm2835.c:356:21: error:
> 			dereferencing pointer to incomplete type

Applied, thanks.

--1/FhgkYIk4AzJcsY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLXO7AAoJECTWi3JdVIfQrX8H+QFUvD4+BEfsQ6n7n+CHXiDh
OAR/DwnU/Ws8e8yTwVWIKrreH1jZh0V83C8XIZSIr9Zmcka6gCrZLIRzmoqJyKJG
2Th8pBaG5lKTUSNCAXyQZJvplgEXYj880Oh1Loj8bncQhGChylbVSq5CvvJXCJqD
PrTPW5HMMUunGLiidA4QiP3I3VS3cwI/HUO0VyZRcxhk46oc1vfPetqMINIj8B1p
zECUvD2BTS5qEpxINqtF1pR4fYuasezVCenHo29BHluJRioTQE7fGtOP0j0xPbFv
Q4GvJsqA0PbyOQ9NDfZ1hDS0Zcy4n9o4LXBhpaeyT59k9ApiYXEiMn155VJM7iM=
=9VkA
-----END PGP SIGNATURE-----

--1/FhgkYIk4AzJcsY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
