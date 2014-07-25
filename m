From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi/rockchip: remove redundant dev_err call in
 rockchip_spi_probe()
Date: Fri, 25 Jul 2014 18:28:11 +0100
Message-ID: <20140725172811.GW17528@sirena.org.uk>
References: <1405864902-14056-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7RSAOS08SfIpCMC"
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: weiyj_lk-9Onoh4P/yGk@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405864902-14056-1-git-send-email-weiyj_lk-9Onoh4P/yGk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--R7RSAOS08SfIpCMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2014 at 10:01:42PM +0800, weiyj_lk-9Onoh4P/yGk@public.gmane.org wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks.

--R7RSAOS08SfIpCMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pOoAAoJELSic+t+oim9yasP/RUPBH6EaPIJAbefiMg7towv
DVZ8hlegTs+7btisRHsSewtLaElINvAXrTD3TfyGBgp2zYvYkazUnxmq0dBBXlKn
EmSDfDiW23F9n0ZVv3d0P8ReBXnRVrrA58Z2TS3sLYqs9kXq2CVgagAEEIbnW6Gd
in9CMIAcaC1t3xRTL4nol+RhiJBAgNeUDvBmu98fWw4I+AkzHoqMHMW0YBOdu1N9
xS+tnO1TJxsJ9DGr26A6hiSIUyhrM6fusLA4LmCkS9/xyFP8ji/3y6ev1I1XtoOx
GQBUQLoadhvhLETZ2OQUkBb6RfP0kGWJjwXUr0zIAhzuKg+7o7OfNbBfCaI9Ov+u
RcT/iB3y+ZqDOd9D0lvpKFOCqTFK08J24KZ4SJj7guZaSKlS4vLq7hIerJTNmv/E
EWxRTopaipo9oP74DcxAExKyoKm378rJ4s5jziugJS1h/OFWzK2E7iodIZ0O8ub0
M9WFzxqI+rYT/RL0XFCIo8ygSKU0haq/mu7giK30ESIuuF58GUigmpVprasy/USb
XUUuBzGsGU6eFfcTagAqp9g3MhKQfZQCsPKCqbVC/p6/VGFidGpetBUshf/S+gxC
28PXzbUggMHrfQH0zFlM0SP3S02oj9CyKWKj2IIy3dN9Q93BFOkDRCVvJ13ii8cj
PRw5CbVbXBmXCfgXaYeU
=97zp
-----END PGP SIGNATURE-----

--R7RSAOS08SfIpCMC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
