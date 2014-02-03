From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix build error when CONFIG_OF is not set
Date: Mon, 3 Feb 2014 13:14:36 +0000
Message-ID: <20140203131436.GZ22609@sirena.org.uk>
References: <52EEF452.4060205@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rYAl11fiF69JSutc"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52EEF452.4060205-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rYAl11fiF69JSutc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 10:43:46AM +0900, Shimoda, Yoshihiro wrote:
> This patch fixes an issue that the following build error happens when
> the CONFIG_OF is not set:
>=20
> drivers/spi/spi-rspi.c: In function 'rspi_probe':
> drivers/spi/spi-rspi.c:1203:26: error: 'rspi_of_match' undeclared (first =
use in this function)

Applied, thanks.

--rYAl11fiF69JSutc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS75Y5AAoJELSic+t+oim9Y8QQAIGucJU4B4r+nhecNg21/JmZ
I6sVgYiBWusVgu3lhsSpN+rtBMnj3JEjnHuFhMD1RrbbQoagt0tamb1L1JfL2+S4
GOmwmQ6gGZGcA9Z9ZJiqEHpP9jUp/t2xp2fpiURstDr9gXhvazzmpGuLLAHEZpf9
9dXx1SoGpi/2UoQGP54wlSmSgE1YYKBCoBGK3yuEjSmk0DbTkeJ5QiUdPtZSWZu3
Rv6LPL15CDxOA37B1mjh5pBojZmOjFpWLXGveIKkw4Wed1JGnfstlM4RT0Xbin+W
wh/V1F5F6AJEhf9yqRBqmOJAL1wCDUjKosrtmkbUwMae6Apnw/lple1Dl4I+Yl0H
U284xcvA+BBI8aox3urV8kBW+4OYyu3kQwQPwh1zzJYHrMaIw1+BxpDXhUFS3lvI
/9JKWyDnI1Hkt/hjoqjiRW3SMpGMZs7BJ5vHWZv3XbfEyaONpvumiNCVP8VAit89
FtHqx2L7lqDf/u7iA4XQ6gM4MigMdXXq7OLFNZ0E+KkIWavWhUBJtM5xyRD0S/lh
v6UpS4EprZAZNPbpLygdyVYebYSh1g3dCHhmgQbEPo5IaqFKd7ZFJOyNI/A4Z7jU
/UfwIIqo9bsrx34poNXhjDT7twbxuSaCVgaPHImGG/A3B2QCrvYXgZA1F+RPM+kE
cBuodf0/dT0iGcRztKgE
=/yp6
-----END PGP SIGNATURE-----

--rYAl11fiF69JSutc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
