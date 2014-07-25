From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi/rockchip: fix error return code in
 rockchip_spi_probe()
Date: Fri, 25 Jul 2014 18:28:22 +0100
Message-ID: <20140725172822.GX17528@sirena.org.uk>
References: <1405864924-14137-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="djsmrO0QNMuttZWM"
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405864924-14137-1-git-send-email-weiyj_lk-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--djsmrO0QNMuttZWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2014 at 10:02:04PM +0800, weiyj_lk-9Onoh4P/yGk@public.gmane.org wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Fix to return -EINVAL from the error handling case instead of 0 when
> failed to get fifo length.

Applied, thanks.

--djsmrO0QNMuttZWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pOzAAoJELSic+t+oim9F0UP/Rtd0DUGnAsLhxppwB3rfZ1x
o8kZHDitf+fcAbXe2chculL5hZm1qBsMcRJ8Y+Mqw4ft0xR0BUGjHXn9cukiUqeb
lNIqfCpsCGL5C/0XfLkA+jHyf8bFNn1JuZpqlv/7gxwBzjekC3KNlrKKiaLDc3IY
cIGVxp6bE9++xdwT30fvqZzRV2/r6oLYoXvnflBfuwZ5ZXiQtfIWmNwsS+3zYjEA
52n9pPYDY3qCRanPR1mpbhCkMws6zCijuycScN6GZMlO1RuD3xEB2tJ3I1dftZw7
lJBtwZxN/jq94htM3c/XXOiIHhu1gtRe6FkvfCnjnQ7zrejMdgp32WBwnwrOBQT8
+V6EZ78SAcrAWS5nPPoSCjTVqYVTreuh+ZAerDRm2Ot9p7TLYNd/QUl9TnDx8EhR
SN2+PHnGjkh7zMKdrAzVcuenilYWYRE/LPPqQy3bhtdcQt+PhX94rzAoaSwZLND/
TyU1wezFY5VkuXr+5kWTSHfnqNdk6v1/C1FXHaE5bQihWebdJZg5ariFYREnB95n
S+otEJfhkGPzohWIT6qjRa5OUQOnq3liwBdXVYLLxoduvv3RZYvbqeoYd3aUmUbh
ULIv3rL6GVSX9cnWGJW8FqyfW1gcengLBiu1moMO8EOcyTWPbflREQtHca9XsCku
VcGVD7I0SPrM7ss05BY4
=6nyX
-----END PGP SIGNATURE-----

--djsmrO0QNMuttZWM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
