From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mpc512x: fix reference leak to master in
 mpc512x_psc_spi_do_remove()
Date: Fri, 15 Nov 2013 10:30:23 +0000
Message-ID: <20131115103023.GZ26614@sirena.org.uk>
References: <CAPgLHd-knuCjQvoCVFj0myd64bf3rO7+Qq7d5_n-PLdoND33_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ECAkxgSy0pGoHfdA"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-knuCjQvoCVFj0myd64bf3rO7+Qq7d5_n-PLdoND33_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ECAkxgSy0pGoHfdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:48:56PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.

--ECAkxgSy0pGoHfdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfe8AAoJELSic+t+oim9z18P/1WDxIDqN3sShgkZoJlv41YN
KXsY5SJkNBO+DxSySZibwK7UpcXnR5NjB3ZZAbH+lJZqnZpE109AD8NVap3uoSJr
2pROSls7sSsPs7f6U0U2SHf7UWaf1P3zic7lfFyIzrpGDi1ODpqrAFs5qAjO56e+
X8Q3FewnAd8ue+oE4KFROXf2TRqyQrMfAPPlblglIUSTeRzLe4O8xDf8sVTeSWuM
3EGSyajxgwsrN7jejdbBxFtDbepLEeXcXoaJsT0/091id36Xtv14qb+rENKcvI6r
0gMm8gV5cTxiplPu2+umNTte94R+QL5YdsIwtmfF+gBYggWO6ZHKUgzPsmJyEpwW
ODZICUumEIJXXEPcVWBJCZlPxIRPhbe8bkLCTIoGfYf4Ajxukhva8kL2MCDSXBrb
Rn/ADOwHrNEpCNtfo6u+pSfRB899SMb6bxSsWEUGpbbEvl8iWziAo3mHZcsxNEgK
sRWaQ0CcdMQRKmTSPjHKWj4YyYNrwvtsKb+bWB6xhnkFOVnZe8xt9gVDvzmLX3Ta
kcQzM5MvVbGILgsfpXQA0gmubK4Xc8AkpNtI+rAaX+m9T4LsGjxYriAYhClxtkaF
83I5PCbkBSjLxpsgKtUXAA60bXredvHaM9SAfSzaMmZOJzp/Fc7qpGs8a1gsBGLg
uhgdZqHMqOtydM08zK/u
=blJ1
-----END PGP SIGNATURE-----

--ECAkxgSy0pGoHfdA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
