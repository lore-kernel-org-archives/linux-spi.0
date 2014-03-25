From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: efm32: use $vendor,$device scheme for compatible string
Date: Tue, 25 Mar 2014 15:00:19 +0100
Message-ID: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use =
the
common scheme and prefix device with "efm32-". The old compatible strin=
g
is left in place until arch/arm/boot/dts/efm32* is fixed.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-efm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index e60934ad4c5f..be44a3eeb5e8 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -472,6 +472,9 @@ static int efm32_spi_remove(struct platform_device =
*pdev)
=20
 static const struct of_device_id efm32_spi_dt_ids[] =3D {
 	{
+		.compatible =3D "energymicro,efm32-spi",
+	}, {
+		/* doesn't follow the "vendor,device" scheme, don't use */
 		.compatible =3D "efm32,spi",
 	}, {
 		/* sentinel */
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
