From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: st-ssc4: Remove duplicate code to test unsupported
 mode bits
Date: Wed, 14 Jan 2015 19:17:38 +0000
Message-ID: <20150114191738.GF3043@sirena.org.uk>
References: <1420469376.6880.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420469376.6880.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2015 at 10:49:36PM +0800, Axel Lin wrote:
> spi_setup() will test unsupported mode bits before calling spi->master->setup.
> Thus remove duplicate code to test unsupported mode bits in spi_st_setup().

Applied, thanks.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtsDQAAoJECTWi3JdVIfQO3kH/39xI+wtcqUHbPr+HJ4gmeM3
XAC/YwLJRIw74jYtFQ/u4CCxTyeNCR2GZGeI6YONRpnVVbBOE1JEzwXaOcJH5kw3
jJYtOUX3nofoGqhPhXPI6dwt1LDwzJeY9UVhDjotVfR+5vi17Z7OrME32SC03E3/
mmWM4xwNFsWCL7PoCxrx8SxXILIqRDJutrAH3Zao1RPjwWTgAa3+PNvC3yabjDiW
zYaE7Hin9i2e+pm1u0xDMhF5tK2duAWDTaAUNeo7F4ojiCzRt+oE7Gu7vjrSVcvj
5IQe2Axckt6Rf5oRj2RWFT7mGuDbtj+FFOIVg6rTh/9g1mATJmi5j/Fz01MxKRU=
=H9g+
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
