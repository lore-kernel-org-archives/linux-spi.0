From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: txx9: fix reference leak to master in
 txx9spi_remove()
Date: Fri, 15 Nov 2013 10:31:23 +0000
Message-ID: <20131115103123.GA26614@sirena.org.uk>
References: <CAPgLHd8PwrTi+Mq-mjKxY8CkpYCxzRBfnLoeum9YygoEyx=fyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HENu/cXyPKFN4XCQ"
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8PwrTi+Mq-mjKxY8CkpYCxzRBfnLoeum9YygoEyx=fyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HENu/cXyPKFN4XCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:49:29PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.

--HENu/cXyPKFN4XCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShff3AAoJELSic+t+oim9GDwP/REeFy2JydjyWD1zR8wnNcAX
o7lFLAVsdgh30OocGPJo7ykMVSDG/foNdiamMwkJmH7rjvmj3gzH5veLvTQG4cIC
jDOyfxhkb5ZQIto0GSFkjS/4WAAkdvDlEa6rI3dBO5fwgyBaQhqu+2VVTEjr/xO3
i/yxjN1srbGjVbh5NoqrLNtTGrZhLcSMh6eZhV/XSdP575y4ZGJA8RN5ylxBnvaj
kjDMKdBEhcnmdwbB/CXTSeLPyBMkCo6dNa2DnlK056rVVBNbHZfpOU0/Na1OvtzC
w2HZjuW8Q/JXH41Nm5QzwLzziZcXDdAKlSGJpxT07WijWUy5tht+XIZ+di6GWycs
G9Gk74GT7/VtB8RRaYjTBbK+X79iLxo4S6O6DJ6L0geTJX0fwhrZ/1X7FfTrqUv1
ovndPIz3zPAVUkuxPfekFuz1o5GL/y7Z40IZG/DExWSrkicUOll2Iqo0oLfk3qIX
FCxlDoF1rbDl8lR+73M8EHnji4KOePuAa2S4snyQwlPcLpNR0dUVx3Uhpr31v+su
MssA/oFQbLEn8k7cAymsQMY1b0WlvF5qRmkDWcyLUqjBfuYjHhYZ8LXPLU1F71kA
NnRuBdPJHRJMzBODzumCEOfCyXBWWnxLxi7pljlRAZJQSRX36fTPkYiPWi0khxel
13dqEfjKKwEwN4ihHHT7
=nCeC
-----END PGP SIGNATURE-----

--HENu/cXyPKFN4XCQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
