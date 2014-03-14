From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 17:01:28 +0100
Message-ID: <1394812888-22697-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

While reviewing an i2c driver for efm32 that needs a similar property
Wolfram Sang pointed out that "location" is a too generic name for some=
thing
that is efm32 specific. So add an appropriate namespace and fall back t=
o the
generic name in case of failure.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-efm32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index d4d3cc534792..daa73358f92d 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -297,7 +297,10 @@ static int efm32_spi_probe_dt(struct platform_devi=
ce *pdev,
 	if (!np)
 		return 1;
=20
-	ret =3D of_property_read_u32(np, "location", &location);
+	ret =3D of_property_read_u32(np, "efm32,location", &location);
+	if (ret)
+		/* fall back to old and (wrongly) generic property "location" */
+		ret =3D of_property_read_u32(np, "location", &location);
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
 	} else {
--=20
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
