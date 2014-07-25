From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: orion: Fix error return code in
 orion_spi_probe()
Date: Fri, 25 Jul 2014 18:29:01 +0100
Message-ID: <20140725172901.GY17528@sirena.org.uk>
References: <1405864994-14292-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QLVPfMX7UDLv9S3y"
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405864994-14292-1-git-send-email-weiyj_lk-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QLVPfMX7UDLv9S3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2014 at 10:03:14PM +0800, weiyj_lk-9Onoh4P/yGk@public.gmane.org wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Fix to return a negative error code from the error handling case of
> orion_spi_reset() instead of 0, as done elsewhere in this function.

Applied, thanks.

--QLVPfMX7UDLv9S3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pPaAAoJELSic+t+oim9SwwP/AxwTTF2QJipYUL4zFWkGDKF
l1PEGbTPEauxC3n3zWgqlsuBHWKNclqpMwdAwJnYsLC9z2GhZHqqdnoFbzagNjxp
Cs7iIdbPM/wSeBT4W3lEI84GlbXoVwqIWW+Idf9dqpHH3a+3+zrBwJfAtQxHy8+z
WH/UqL9+zJvmTL3SsDK8CQu0D37l8gaoIGL3xvDFddSCiES5Atw92NzPDMsGMoq9
jGf8Y4OsUL4DtZAXLXziXFUU+fcA8whGQ4v8AYMO9vldh45iV0vm5jk1iP9TBYHK
tpGRFKJMOoMcfIkPo2+9BpT2mMPu5+UbMAPBEWSjjX7cvuqO69ZmOs22FCLA2+Ex
m1/2jCNrX/m50pGrE62UytOxNvOC+MEZk6xcsyIgzNwVAn72Z2kd4FX/EJ3pik2X
XXIhjH9XyEEX+T2toEAhJAxCYT5bkla1NQZd2nggeAF7QLa1mFe+3eDpILxoBW55
71TJt5cjLYXIMIuOzv3hSLbdGdknk44hhSc2yQFKyYuNovO8ZzlAVJHGJf8FiA/5
PK6T6Q1dORErlxdCJb5ePF/R0VatoexdwhPA40Kp9/8UvgZAY1N5v7fx4O3RW3P/
FbZDgKg6MfKA2evpjdDdEw4/fw81UXosp8nh/5bU9t//U4rPXcAJQdffGiw9BWaJ
MMLQMbiUHwep6FUs/onM
=hAWh
-----END PGP SIGNATURE-----

--QLVPfMX7UDLv9S3y--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
