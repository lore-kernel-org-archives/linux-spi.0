From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: ti-qspi: Fixup driver name
Date: Mon, 13 Jan 2014 10:16:32 +0000
Message-ID: <20140113101632.GZ29039@sirena.org.uk>
References: <1389510152.13361.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mQruWSI2c46YBtV"
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389510152.13361.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+mQruWSI2c46YBtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 03:02:32PM +0800, Axel Lin wrote:
> The driver name in current code looks like a compatible string which is not
> the naming convention for platform drivers.
> Fix it and also add modalias since this driver can be built as a module.

Applied, thanks.

--+mQruWSI2c46YBtV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS07z9AAoJELSic+t+oim9fcwP/jPuAcrAilJRsn2BM8ujHEDI
kEeTLsepriz9MhrsAi6AAPYqRG0hiI4sVi0nwP1JTdwlVcJXdPqOGwMhYz26LO1n
yyzEJIWkHGV9Zi8FiIzuBSYSytj7f/oIzIcXhxuoE/GGy05mPKHIeBpvX+dq2YkM
iFpr8tZF1yXG+dtQOZzUe2QdiXSBXovux5fed49RzJWenDXJLCkzDjOnQg7lqndB
vk+nbiogVgq1YEX5vx8x3L3/97fdq8hAjxVbSw7R1lr3Zv50D7BwQI4eaG8eo2wr
jBfd6WeTxNLyOS3MTwwqJmDK3k088e0YOfZBG0pSekerpqpJdeXwnSt0DSZsVxtC
3PrRYWN4asLjvKgqYg66+J7TEZ5pJ+Y3xHbz8MMIsu3BhqrcYd3bD06pXRSQ0ojs
dCHw5qGcB68r8CtGzo4awTooUlRhDN72Ea5Y5ZCYXvT3cLfZOZwhtATdGXOP/ujV
GYXUg/azh0JOoJfFZAgoSq1rHPwK2O06NYGqgriRQuuLKEJPE8qQHxPWZAY5bERZ
loY/7zpfWik/BOl0okCRG0b4mpbwd4n0WsoFreNw0nyzTKKk5gnqCavX/nzBeleP
Or9LBhnkYVv9mNJRwPLqN4E3cjwlWcepLbxaID32HBn0LJkWMgyvWQI1r+BXPkwt
S4CHbxlJYSrQhW4uWyiS
=dwxM
-----END PGP SIGNATURE-----

--+mQruWSI2c46YBtV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
