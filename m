From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: propper support of 5 wire SPI (SPI_READY signal)
Date: Fri, 19 Feb 2016 10:08:46 +0100
Message-ID: <56C6DB9E.5080905@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kmqLTjMTl2ENW2GBliiSwG9JpQsq6T4OL"
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kmqLTjMTl2ENW2GBliiSwG9JpQsq6T4OL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo all,

i'm working on a project which depends on 5 Wire SPI communication. It
is probably identical to spi-davinci.c with SPI_READY signal. Only
difference is that SPI_READY is not supported by hardware, in this case
GPIO input is used.

Currently this project implements SPI_READY and CS on top of spidev
driver. What makes it really ugly, slow and complicated.

My question is, are there any better, upstreamable way to implement it?
For example directly insight of spi framework? Any suggestions and
comments are welcome.
--=20
Regards,
Oleksij


--kmqLTjMTl2ENW2GBliiSwG9JpQsq6T4OL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlbG26MACgkQHwImuRkmbWniTwEAkc9AjlciOdYmqOfvlyy2q3su
p/S4Swe+pKvDlAFKLVkA/3bt/EoCCDrP/3vXaIh5L0RvwGt4+eH0zmnmrx83rsJV
=xclP
-----END PGP SIGNATURE-----

--kmqLTjMTl2ENW2GBliiSwG9JpQsq6T4OL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
