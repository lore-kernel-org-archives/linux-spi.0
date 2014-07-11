From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 10:17:57 +0200
Message-ID: <1405066677-12858-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,locatio=
n"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/efm32-spi.txt | 13 +++++++------
 drivers/spi/spi-efm32.c                             |  8 +++++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Docu=
mentation/devicetree/bindings/spi/efm32-spi.txt
index 130cd17e3680..750e29aff9bc 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -10,11 +10,12 @@ Required properties:
 - cs-gpios: see spi-bus.txt
=20
 Recommended properties :
-- efm32,location: Value to write to the ROUTE register's LOCATION bitf=
ield to
-                  configure the pinmux for the device, see datasheet f=
or values.
-                  If "efm32,location" property is not provided, keepin=
g what is
-                  already configured in the hardware, so its either th=
e reset
-                  default 0 or whatever the bootloader did.
+- energymicro,location: Value to write to the ROUTE register's LOCATIO=
N
+                        bitfield to configure the pinmux for the devic=
e, see
+                        datasheet for values.
+                        If this property is not provided, keeping what=
 is
+                        already configured in the hardware, so its eit=
her the
+                        reset default 0 or whatever the bootloader did=
=2E
=20
 Example:
=20
@@ -26,7 +27,7 @@ spi1: spi@0x4000c400 { /* USART1 */
 	interrupts =3D <15 16>;
 	clocks =3D <&cmu 20>;
 	cs-gpios =3D <&gpio 51 1>; // D3
-	efm32,location =3D <1>;
+	energymicro,location =3D <1>;
 	status =3D "ok";
=20
 	ks8851@0 {
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index be44a3eeb5e8..6caeb1cac0f3 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -294,10 +294,16 @@ static void efm32_spi_probe_dt(struct platform_de=
vice *pdev,
 	u32 location;
 	int ret;
=20
-	ret =3D of_property_read_u32(np, "efm32,location", &location);
+	ret =3D of_property_read_u32(np, "energymicro,location", &location);
+
+	if (ret)
+		/* fall back to wrongly namespaced property */
+		ret =3D of_property_read_u32(np, "efm32,location", &location);
+
 	if (ret)
 		/* fall back to old and (wrongly) generic property "location" */
 		ret =3D of_property_read_u32(np, "location", &location);
+
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
 	} else {
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
