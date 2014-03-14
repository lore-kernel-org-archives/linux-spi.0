From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] spi: efm32: properly namespace location property
Date: Fri, 14 Mar 2014 21:34:22 +0100
Message-ID: <1394829262-28022-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

While reviewing an i2c driver for efm32 that needs a similar property
Wolfram Sang pointed out that "location" is a too generic name for
something that is efm32 specific. So add an appropriate namespace and
fall back to the generic name in case of failure.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since (implicit) v1, sent with
Message-Id: 1394812888-22697-1-git-send-email-u.kleine-koenig@pengutron=
ix.de:

 - rebase on top of Mark's topic/efm32 branch
 - adapt dt binding doc accordingly
=20
 Documentation/devicetree/bindings/spi/efm32-spi.txt | 4 ++--
 drivers/spi/spi-efm32.c                             | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Docu=
mentation/devicetree/bindings/spi/efm32-spi.txt
index a590ca51be75..25c02ba530da 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -8,7 +8,7 @@ Required properties:
 - interrupts: pair specifying rx and tx irq
 - clocks: phandle to the spi clock
 - cs-gpios: see spi-bus.txt
-- location: Value to write to the ROUTE register's LOCATION bitfield t=
o configure the pinmux for the device, see datasheet for values.
+- efm32,location: Value to write to the ROUTE register's LOCATION bitf=
ield to configure the pinmux for the device, see datasheet for values.
=20
 Example:
=20
@@ -20,7 +20,7 @@ spi1: spi@0x4000c400 { /* USART1 */
 	interrupts =3D <15 16>;
 	clocks =3D <&cmu 20>;
 	cs-gpios =3D <&gpio 51 1>; // D3
-	location =3D <1>;
+	efm32,location =3D <1>;
 	status =3D "ok";
=20
 	ks8851@0 {
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index 0512fedf1f13..fdb6fce0530b 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -294,7 +294,10 @@ static void efm32_spi_probe_dt(struct platform_dev=
ice *pdev,
 	u32 location;
 	int ret;
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
