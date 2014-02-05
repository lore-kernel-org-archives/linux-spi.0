From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Remove unused pointer in
 orion_spi_write_read()
Date: Wed, 5 Feb 2014 21:31:16 +0000
Message-ID: <20140205213116.GA12659@sirena.org.uk>
References: <20140205222301.14fbb441@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140205222301.14fbb441@spike>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2014 at 10:23:01PM +0100, Christian Engelmayer wrote:
> Remove unused devdata pointer 'orion_spi' in function orion_spi_write_rea=
d().
>=20
> Detected by Coverity: CID 1077860.
>=20
> Signed-off-by: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>

I'll apply this but please follow the patch submission process in
SubmittingPatches, in particular please always CC maintainers on
patches.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8q2hAAoJELSic+t+oim98+QP/1Oa/Ms+hFoxOEFvbpqJo1JT
ZraiurYXB24A+1m0lG4pIXuFPUhzw+ew5YTOlfV9/MtYk1xjpKbjUVYbGH1CqxXq
TW0pyGqaJtQeS/bO7oziF44cVvgpUKjh+JrJ49HRU/zPlfCjkhkhIhVBSfEvpuoU
Hgcbj4AIctZ0MPPtvPDJ9u9+gWN2dLBaYAwjQln+6atH7vRtjq0zmmkgXhmaZGUz
/utB0SpWLmLUUXOyOJ/E6JZeUy8WlXKdJskoFv4i2SAEx8G10j32Kzynj4YiaX0E
jYOmfJkhoLD11ZJBYKDB5XfzncLL6A4ipkFu7eaTaePqwm4VTLl419shon73DDGD
mSqDyUuNSvFb7LsHlJmFYBD+lHI4C/koxP+Wh/51Ut7uV1Dshv6qWhTeHMntX0XD
zsrLcfOLIDzfvFQIThZfY/8Z+FU6DBRUS+RRHkl/cF9iA7hO60G+jcNeIzaGgg0k
sOlJe9C/8Xh+klB4hUpIwhQL/X3hXkssj55iGMYoBrSrhUYzZIzSdOH6rM6gQJMp
lSCGoQTUqwEZX96LjSTrF6YCjHi8o9iL4YsYghmEDg3q8iYpyN/Ds1Ut4mWSpCYI
GQTrpme1QN3TmmoDy7yQXOoqTXSaR438WfJKVRJWQyVvWEbEzZqXp13ErUEjN4mZ
EyVKmdtA6c8a6tQhT23a
=Strq
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
