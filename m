From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: txx9: drop clk_put for devm_clk_get in
 txx9spi_probe()
Date: Fri, 20 Dec 2013 11:56:56 +0000
Message-ID: <20131220115656.GS31886@sirena.org.uk>
References: <CAPgLHd_94fMwOm1Z-=4ojrhH35WHve4piJkEC5Fh8k8OZcTfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wKbYzd8t8rt1PVqr"
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd_94fMwOm1Z-=4ojrhH35WHve4piJkEC5Fh8k8OZcTfsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wKbYzd8t8rt1PVqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 10:15:45AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> devm_clk_get() is used so there is no reason to explicitly
> call clk_put() in txx9spi_probe() functions.

Applied, thanks.

--wKbYzd8t8rt1PVqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStDCFAAoJELSic+t+oim9k0oP/jFmOHrqAaP5Aq9QrGpBh4zp
oDKH0/rVW/RA1hidPHlHV1uM3Ys7PPjnGa1mKrtHILxwECvclQ5xSvp3PpRI51AV
CD0aAjnXHLI7JIqdscjQ2IILKRIyxdVjm5qPG+Xh48vEJg25tyJI+6ylnvxtK5I/
VJ/qA4rh+F9iv4w8F5ORp/GkfbwCNEG8M74vURqbQPuwTnGcBXM/K3ycvsN1EBaM
CdUFvXGKrEIz+uBUNbSEdBHZdkWnBcXBQ7qbHrI1ELC/9Abmk3+LpEEdr7Ne4onM
/eZcQUes4AzFlyY23VuSWhj9XX8/fSAzoEXlVX52+Rl1jMsuZaRj0U7uHotV4Tqf
ZkR+LQiIQh+dkbsHX8ihI+V1tKQNipnxwf3vj0iN9DAfayRY/xoQNL6etv8paIyQ
aycMmPLTmsEsyUVKphcHM5m/1c6YavnAwsXbtL6MDdGT2LHHIQsOApk+5+TivNDw
gigtEwnBBmRFqC5wMcmT3YOu9l54ByNlxXW/FTh4pJTvTmZ4Q9p/7470JgBPYkiB
1+qKxxWdpq9HM8oPoNKALmaa/FMtrH5Ci/uusC7xQdd3qbJbsxD3uWTfyRZoUuMX
bAYDm76+fxVPXXKX5q/mpX8ZoS7M+EFO73Unwd28cxZ4AbVnLVB0RIW4dmfOYhjB
s20lYHx7Dh2xF9zh6q3b
=Tmzn
-----END PGP SIGNATURE-----

--wKbYzd8t8rt1PVqr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
