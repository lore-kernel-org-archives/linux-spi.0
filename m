From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Kconfig: Drop default setting for SPI_IMX
Date: Sun, 23 Feb 2014 10:33:19 +0900
Message-ID: <20140223013319.GY25940@sirena.org.uk>
References: <1393101504-23302-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393101504-23302-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2014 at 05:38:24PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> SPI_IMX is selected by imx_v6_v7_defconfig/imx_v4_v5_defconfig and we don=
't need
> to have a default setting which depends on the IMX_HAVE_PLATFORM_SPI_IMX =
symbol.

Applied, thanks.

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCU/XAAoJELSic+t+oim9E70P/1xB6+vO8dqQZ6t7BlQn9Zgp
4xRsaGhtG1wQASNUEi1784icw65iMaAkNOw/5DF5pi15zu4SKh0fzxC+vkKakGiv
Wr/J1bHrECxspitimb7alP8p2x4uVR8LJSNnu7Tn3IQO5fhjeSJQVeVzSZG1Kfmn
egfI3AWWqc36F77/Enbxg2iKm5TkV3ukjoNCeb1ZWsDgJfACL+MPrciAopi225zO
vPh3dzExWgquIpQNcduDnP1eqsm3lQTkDsnSDlzZlDGsohe5IApHc/6U2t1fHXrI
yDqUiTMtCEpFQ2D91Php2UobSvO49bgmSrHmchHU3jQfFQFyJn8V2u5zIRINYML+
HF/hi2UIu9Rv7zeSFbofB9voSBc2jZLyfnXe0Hpi2xxvAsDS+LB8q2r5LQNJO2yP
1/LyGMOBzOphWOXjtwdEXUhjfMQBQkH6Magneoi8Mpn4SHxPs0S8Mr5eVMmK528S
S160RshtDIlAHz1JxnrYgGpKKP6p+Vkhs3eEMZ+C5azxySNKDbeK7Luz+gfLjEsM
m73Ka4E1Rz60j/R3XOd/9taGc/xaHRCy+7/tKp1NMHP4yqmeEkvyltg8iMwdk3iR
4MaoeaLdp1+VQdDYcy4mR7eAz/QxW/N8mhU6cvCDodvZ0dUdt1yf9q5jDWnZnuUn
3uKjxzAAEeJ4zJ1XUSPZ
=iupR
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
