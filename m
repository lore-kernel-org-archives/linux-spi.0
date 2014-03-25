From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] spi: efm32: use $vendor,$device scheme for compatible string
Date: Tue, 25 Mar 2014 15:51:50 +0100
Message-ID: <1395759110-10747-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395756019-23989-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use =
the
common scheme and prefix device with "efm32-". The old compatible strin=
g
is left in place until arch/arm/boot/dts/efm32* is fixed.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since (implicit) v1, sent with
Message-id: 1395756019-23989-1-git-send-email-u.kleine-koenig@pengutron=
ix.de:
 - fix binding doc accordingly

 Documentation/devicetree/bindings/spi/efm32-spi.txt | 4 ++--
 drivers/spi/spi-efm32.c                             | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Docu=
mentation/devicetree/bindings/spi/efm32-spi.txt
index 25c02ba530da..8f081c96a4fa 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -3,7 +3,7 @@
 Required properties:
 - #address-cells: see spi-bus.txt
 - #size-cells: see spi-bus.txt
-- compatible: should be "efm32,spi"
+- compatible: should be "energymicro,efm32-spi"
 - reg: Offset and length of the register set for the controller
 - interrupts: pair specifying rx and tx irq
 - clocks: phandle to the spi clock
@@ -15,7 +15,7 @@ Example:
 spi1: spi@0x4000c400 { /* USART1 */
 	#address-cells =3D <1>;
 	#size-cells =3D <0>;
-	compatible =3D "efm32,spi";
+	compatible =3D "energymicro,efm32-spi";
 	reg =3D <0x4000c400 0x400>;
 	interrupts =3D <15 16>;
 	clocks =3D <&cmu 20>;
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index daa73358f92d..d02f28b56041 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -490,6 +490,9 @@ static int efm32_spi_remove(struct platform_device =
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
