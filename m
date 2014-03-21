From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: altera: Remove the code to get unused platform_data
Date: Fri, 21 Mar 2014 18:13:21 +0000
Message-ID: <20140321181321.GO552@sirena.org.uk>
References: <1395372118.18131.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395372118.18131.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2014 at 11:21:58AM +0800, Axel Lin wrote:
> The definition of struct altera_spi_platform_data does not exist in current
> tree. So remove the code to get platform_data which is never used.

Applied, thanks.  I'm rather surprised this built cleanly...

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLIE9AAoJELSic+t+oim90fcP/0ecwCRK3CVnKTuY0s4c1TXh
lVudgwNaj/jcVeLlu5sC4+2fnTXx6Ul9ggeLjEwV9GJdN3lJ9iXG4Upzt0+VnRBZ
ZUkQeJNonya5ueia5lnMhzI2PGGvnGDIVd8vO4rBw3s4CdFGM0zwYBnkY0GrmJDj
iki2hP0z0odM+X4lxF5CFQvCHcmH9kkul5zkTMyiYCW1SmjT5L8izgUiL5rSAoUz
K7FRHs5qGNeOlGb2B9oS72KIngBYHTiZe2BcKqkdMdK4h8EKPSPioYJdBYCk2sYo
NUqNH2g/rMRbzqI83zdsK1/6iRyWrIbmZVvC7hiE4n0+EwLHkXLyItYImT8BXylt
8GCrhTdnzWu3QX4bkz06AnKYJ5ppbvR5XxIT4MQECak9d6z+HH4iFoyLc5hUU7HE
JGDnqBKxkElhF2ZLas6AIBMLgxD5qqo0QaAyIHYDEtv0HRsgaXhsF/6iU7sfK8Ak
GIsjsDWXo+G+0jpW1IFQcT8FuyzZdRu5+I8DWRTcx1b6EvWqz+PJP4X73atdLzjC
SGFmoHBTGRjdM4lIjrhasqTZGncNvFohG59ScaIYgq7U58LbZNVWI1zenBcZbxzR
hzqgKGjAJMrKScuCzcb46ZTrHpd2KyvDAqJud5XoSKLPQ1/WinoRVjf/R7iqW57r
SSNNPV7vU9ln3uUopgr4
=NgR/
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
