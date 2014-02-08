From: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
Subject: [PATCH] spi: omap-100k: Remove unused pointer in
 omap1_spi100k_txrx_pio()
Date: Sat, 8 Feb 2014 19:02:23 +0100
Message-ID: <20140208190223.45d1dcf8@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/RrieZCd.q4P6CQ7XiTkpdFQ"; protocol="application/pgp-signature"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--Sig_/RrieZCd.q4P6CQ7XiTkpdFQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Remove unused devdata pointer 'spi100k' in function omap1_spi100k_txrx_pio(=
).

Detected by Coverity: CID 1077869.

Signed-off-by: Christian Engelmayer <cengelma-RbZlAiThDcE@public.gmane.org>
---
Applies against v3.14-rc1 as well as branch for-next in tree
git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
---
 drivers/spi/spi-omap-100k.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 0d32054..8eaf0cd 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -204,12 +204,10 @@ static void omap1_spi100k_force_cs(struct omap1_spi10=
0k *spi100k, int enable)
 static unsigned
 omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct omap1_spi100k    *spi100k;
 	struct omap1_spi100k_cs *cs =3D spi->controller_state;
 	unsigned int            count, c;
 	int                     word_len;
=20
-	spi100k =3D spi_master_get_devdata(spi->master);
 	count =3D xfer->len;
 	c =3D count;
 	word_len =3D cs->word_len;
--=20
1.8.3.2

--Sig_/RrieZCd.q4P6CQ7XiTkpdFQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS9nEvAAoJEKssnEpaPQKEvl0P/3f7Hukqjg/50cyWbta0q/Nc
AI+QIlQzz8dhv3EHPbcH9UTKwXOVvDMeD+HebczOw7Tf1aS8IoUR7o2n6gn611LI
Z/fy5IQTaEaQ/bYzuluKPXeKOfaBi3Qrtv8IbzLBeEgLSdsjcz0DVGA9aqPILM1f
xIHSv9CS6kdmJXnbtVpDhviFb0tL4I/ffz+AoOudM0AwXENO5nOQpdfhtOdCyorN
uQzRB7qlvHnhnGp4wPeovknte0M+1FsMTh4AEQNnCfeeHrRtGSqS/xNvWKNQ8Alt
yXT39qHoZhJTk/1ayE3ZyXhsklaGgoQyBCA6C5pb5b7kxZgAIOAGNALIwfHAWhGj
Om09VM3l7iFjNDl4Yvv9MAvj9knKdpwlsknsi+CdxZK8ii6/WzUXD9T1wvBVzZok
ojh96fD/3M0mkmd1KvAXp+MDLe8xWTtM4nwUXugP6P5rr1Gzz5fvFWPYE+/C+d1V
cTELuu8JdCcjW7nRA9m/D4MrsvlzoObdNXZNDcWvPgy9hzWec4GDSx1IGqFXNKkk
UUIOY7/W4uVeK6Pl+SIX9G3RjGlAf1WrTCitZxZWzkdwVrdDlVJJUblyK8Iw9hm+
QasE1DJXbSHKvRn4WtRZPx+4F9lPEJeyaXm8NJ5wQsKRghscGmkHOY0tv+ow+7Ib
Fkk8qUz600fEEAP6F4Jj
=V1kT
-----END PGP SIGNATURE-----

--Sig_/RrieZCd.q4P6CQ7XiTkpdFQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
