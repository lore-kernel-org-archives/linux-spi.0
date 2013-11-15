From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
Date: Fri, 15 Nov 2013 10:34:43 +0000
Message-ID: <20131115103443.GC26614@sirena.org.uk>
References: <CAPgLHd_-cpipSk5+SVPwZ0_Jzx2P5tJVFaj8Rxkbb_+yFVqvEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MvEh5MSbieV/1Yst"
Cc: ben-linux@fluff.org, kgene.kim@samsung.com,
	grant.likely@linaro.org, rob.herring@calxeda.com,
	jg1.han@samsung.com, yongjun_wei@trendmicro.com.cn,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd_-cpipSk5+SVPwZ0_Jzx2P5tJVFaj8Rxkbb_+yFVqvEg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--MvEh5MSbieV/1Yst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:54:16PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.

Applied, thanks.

--MvEh5MSbieV/1Yst
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfjAAAoJELSic+t+oim9BFMP/jJXDUABGrvU/t4QEcdL7PQs
CkuxjCD6dD1MlHFeuBk2bnycqCMS7u9Z7tJPH9JgXVX6QAdYcKHaPtlXpd4Zdx3o
vxx3mN1/loz2x957sz9hYXJfR7XQqoMtDSK9TH5eb5Lb3Uy2gUFp5xbZKF8JY7Qh
hSSVtrXV64LRtDyPznzOGUsH++SKo6Iqz8P7L+0Xpc4OMznd7N+NE3vfElbGw6Xs
A+Rz7uV2k0hrTc5bt9XdR26ejuEfW0z8bDYP51PZPcy2WAVuBT4nNk1UYJmG1q6V
Le3PQK3SiZiSDCdv7rSevSTS6JKtwyYFatOJzQKT7EsYjOXgw6uDlQPLwED2XaRS
KeQHt5hrBKcslsByH1HKbr5WbepNcw0ZOFYtLW2HjxGDTTBeYy8lopMJWG5Y8veD
Sz7/J5jRuM1tRC2zShtJIj+df6qmPlv1BmJleL34SikGtg33ZUhzTU0yDmcBAvoj
g3m6Ooj0tKP7MtwuwwPcqzEGqKu3Xvlh7HYXq+viiceYqlxGPG9ZEIbKxnVoXtAG
0iUg3+d1OBXN8Opiah5j2lAKN9FtiH8dkGsdK47zHOObk4bvMrbaotcawf5Y04wk
40unU4rStUC9IMfM2we4VusE1GOQEnIpwiku/2lJ2ZdSiuREVdu5Lsf5DZM6oxgB
i/OW6q5IeHwoGMsG8nR/
=IWPN
-----END PGP SIGNATURE-----

--MvEh5MSbieV/1Yst--
