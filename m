From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Check for spi_of_notifier when CONFIG_OF_DYNAMIC=y
Date: Thu, 27 Nov 2014 11:07:06 +0000
Message-ID: <20141127110706.GI7712@sirena.org.uk>
References: <1417040037-22522-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="amleibWWk9XZhw3o"
Cc: pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417040037-22522-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--amleibWWk9XZhw3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2014 at 08:13:57PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> Since commit ce79d54ae447d651173 ("spi/of: Add OF notifier handler") the=
=20
> following warning is seen on a imx53 system that has CONFIG_OF_DYNAMIC=3D=
n:

Reviwed-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--amleibWWk9XZhw3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwXZAAoJECTWi3JdVIfQuccH/0j5THhVBJODorQHQJ8FDZYD
YNM7xY1Z8Yfx6OjFYRsWcqxK331yRJXbs2m4f4F1bavFPYS+pZiQIhg4XvscxA2H
ujP7yXw5aM1ZRjzqrA+5FOquF+8xlJlLf09zdxNUnuWeXKWZ5/cp6CcMDJVrEawq
mF1ZxHj1LU1YL54w7Vgup/2yBzhxElK+0glBT+RwspacEsTr1VP0Mz11jjcDd7EB
PbgZdeCsTa7lcDTVuDNS2J5D3PYvrb9bvPo7Xrfpk/qGsmg+r4nSouE5BBmj2c/+
1WM6w+VH3St+IQgfYEVlVhfNopiVE+jgz6cj49TZ3NpEpG7ZT+bj5TZPPkoRZSo=
=/jyl
-----END PGP SIGNATURE-----

--amleibWWk9XZhw3o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
