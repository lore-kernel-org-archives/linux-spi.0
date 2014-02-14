From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bfin5xx: Remove duplicate code to check spi->mode
Date: Fri, 14 Feb 2014 20:18:16 +0000
Message-ID: <20140214201816.GH4451@sirena.org.uk>
References: <1391395890.4629.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Cc: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391395890.4629.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 10:51:30AM +0800, Axel Lin wrote:
> This checking is already done in the implementation of spi_setup().

Applied, thanks.

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/noFAAoJELSic+t+oim9UJUP/iTkQWBSRH0ys8zESzTf0jKr
OIrfV1WtWrrm56pkU8qPBzg63o3s3wRpKvXrPo6zM6hVeJZ/m9jBFsxZCNBBqQ6o
IPzqooJucE3LiQLhjc0HmcnQEHX/BSAxBDPLPpBS/avecqjddSY/w7Yri+Fa0bip
CeypLyfV2C61BKt29w4E5pp5dnid4FKzUMD4yHotfHvSy9Q/gtKccBAvoL7J7EgT
wymJQWTkBZvDSxHzw8JfIzD7TKJvZi4Szn09Qe9Dn8TUWG0Fu6PHRa3psccIXE1d
Hls/P14+wQKaGGYDtagPCJiZ0EQSdA6dDF3VzwPIwq+EqMHmFfoCurvHkdwqqVKE
XOud1RiACNfgz8/2IQgqjTEyX/d85u+prxrcnJ5vBbQTQwkGKECh/mSVMt6C6TpP
9yXIJV3qwTkahyVeQvDIq20MJTgI1yVij1UovRR5pui24cdRyoto3KVMo8MfLH8Z
IoXlTgKU/O69LBRpGmYuh5KPwk3ySZB0HS3h+QfaDWdvw3sWHpZp2MlqGQ1m0Irk
0x25V/4NGO4mR5h1doYUVOx3qN3fPQigLlESBl9NHxfE/UX3CBIZ97B0jrIznbS7
GKxazD1+lAlvFkvt0qp4aTZdXI4zcd4aKl3o2scKucU0Je0JfewMzROkHABiQ8BO
jFccaO/fBIii6n7khiBl
=tL51
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
