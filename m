From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: pl022: Don't touch unspecified bits in
 interrupt mask
Date: Fri, 6 Mar 2015 19:44:54 +0000
Message-ID: <20150306194454.GS21293@sirena.org.uk>
References: <54F08D7F.6050301@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jZB8mH5IreBO8718"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F08D7F.6050301-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jZB8mH5IreBO8718
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 04:30:07PM +0100, Alexander Sverdlin wrote:
> spi: pl022: Don't touch unspecified bits in interrupt mask
>=20
> PL022 Programmers model explicitely states "do not modify undefined regis=
ter
> bits". Correct the "all enable" interrupt mask so that it only enables de=
fined
> ones.

Applied, thanks.

--jZB8mH5IreBO8718
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gO1AAoJECTWi3JdVIfQqgkH/15/f8Cevtj4ON5RItsrUx9k
dzU6ajxvUHo6FvWcMsQ05mlw8SyIpGp48pGpF+mXkS5RT5Q+bTS3O6oGgrv5uJRd
6MWCNh3qsG8ZwNNAehBtHK2Ex+F3F+lS2251sT8BC6yy1cMiQue4oQkBPK+eTwH6
eItYjn7Ly5YMmxxiu8cJl2w9DYwRQTZLeDbjjvwPpzLQ2pXRGW0r9WYtHC/2MQJL
eObMN4IM8uNn3Kufbk+loVUGvjMxqYWRiaQbuplVTzLPibZ8ffDUIRbgjRIlQUyk
g5ram+oDOPQHc5kFiZjymtGEQxYQwAo4goRUMkhQPiCBXc8SBNREqKNR/s9HkTk=
=WO84
-----END PGP SIGNATURE-----

--jZB8mH5IreBO8718--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
