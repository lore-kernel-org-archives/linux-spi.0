From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Remove unneeded NULL checking for dspi and
 dspi->bitbang.master
Date: Thu, 6 Feb 2014 12:53:37 +0000
Message-ID: <20140206125337.GN32298@sirena.org.uk>
References: <1391655141.12574.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mkHYMT4O8DyWoHkb"
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391655141.12574.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mkHYMT4O8DyWoHkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 10:52:21AM +0800, Axel Lin wrote:
> spi_master_get_devdata() never returns NULL when spi_alloc_master() success,
> so remove NULL test for dspi.
> We have ensured master is not NULL before assigning it to dspi->bitbang.master.
> So also remove NULL test for dspi->bitbang.master.

Applied, thanks.

--mkHYMT4O8DyWoHkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS84XOAAoJELSic+t+oim93CUP/ju+26p8By6aj0wZH46vGyyG
cfxVjHfjnIqDHII8X2GRluf1oQmUVuPEXUnkFd8ByjDHm3gMJiVEGeIb63ER/Cq8
rojA7t1lOH/99cR4o6V5D1wRvABQSnEBSaWRUtCrQEVl4iKqQuzsk4cXiQdNJzb9
Z6Moytde9CIicd8ipCJc6YoX0yajWASLng16mv6T7VMkmwxg7oZ0IZE0iQ5UnR0u
39dUUJnL4UdRbqU/pjRJFV86Uz+R7UazljSAELbUXn/mDLUdEkMHaJaNCXO/+dnK
/nYjUcw1LeWUY+y5KXqcdKd3A+rffEqtduiibgEslIGXXfG/a9fX48bRjM8dq+ba
dUKWpRFn4ZhiLdvr23Mnley6BdajDjDbA96eJI8wfdzn9zj5207v1J4EnOdEJ+Bq
fRINqg9uHkrUd++FOZBo37vTVowanw5E23JQiegGpyjh4kUhkyiUSDIf1FjILrUb
QFaGbrP9QHZjpGiZawT5jfCsm6oI8uxd7XScAlpYb8vpO7saSAPSvcs085c5jOgc
ie1jdUqo1cjYjjomQoovOEbvCteFYJ2Q2BU6V5gxt0um72hFd/MI5mfdg+XH3Lzw
tTatMduOCv0ozPawPh0OQ/7qtqE/mMd5/rvQXs2shQIjKfFDFxBMM6MNCNp3s7sA
bPW1GIt5qz6Gn3iD2diS
=BHst
-----END PGP SIGNATURE-----

--mkHYMT4O8DyWoHkb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
