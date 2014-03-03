From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Convert to let spi core validate transfer speed
Date: Mon, 3 Mar 2014 12:35:39 +0800
Message-ID: <20140303043539.GJ2411@sirena.org.uk>
References: <1392903476.16767.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o9mtL5OVI48+DSkO"
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392903476.16767.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--o9mtL5OVI48+DSkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:37:56PM +0800, Axel Lin wrote:
> Set master->max_speed_hz then spi core will handle checking transfer speed.
> So we can remove the same checking in this driver.

Applied, thanks.

--o9mtL5OVI48+DSkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFAaYAAoJELSic+t+oim9j84QAJriH/veS3PW72+zWGLSHHN/
ZvqCVqsdi3hrOeYkdS0cI42g3lWjxQmxfss4WhJ4YXvqzhUtAhwaecSISGAoWB5D
KOKkezIoQkbPBt0Y1xVpYQWJprhMyIny2Cm5TYBfz1JGXL/FO9jmy6axHlocI/UN
6e4rIsIvBfZMuBHSTDyZg7qhkiwIKfEo/CqkGmKpL1Q5kWraLHUFDMM3N9AK2+Rq
OL+Q9O0hkY11JGA3KnPh0sCXJizk614C5/Tcsf2Sv3Z+ar2H58gxEixf0VtF+TRT
y+uLsJgwB+WqZn83ktxeBJUDOpqkxN5DhHPkBnDZ09UEVWZV+rskUReq6tO+2Cd4
H8wUa8xSSQX95827po8qnL6C+u0DA0T8lJqoMqSu5RAKPU07NGI2e65laFtq94rU
LqwM1/mSioZZPyq6Qb+zv7fN6LhTpQlUN6KkJKREu2chAhesuRwPH2d1O4HhQANj
bbiOrZTkrsH8gr4c1A/3k4Pb5L0lWcGORQa5vIYdgZ4w2dNoUz6Q3mw4+v/nBHm4
XZ65AjtSE76psWNzRCYWcwciVVIUOCofB92kI3lKSzTSis7IWWrh5YeTBxhBbIUu
GCrg3evAIuzdakZoSV3KzuENKTPmJV6WKjEun6otlJbjSN58o/gdYoLlokmz2dVG
5nVrvZud5HJmW3gG1InP
=aUGy
-----END PGP SIGNATURE-----

--o9mtL5OVI48+DSkO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
