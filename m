From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH v3] spi: fsl: simplify error path in of_fsl_spi_probe()
Date: Tue, 14 Jan 2020 16:02:40 +0000 (UTC)
Message-ID: <2a4a7e11b37cfa0558d68f0d35e90d6da858b059.1579017697.git.christophe.leroy@c-s.fr>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

No need to 'goto err;' for just doing a return.
return directly from where the error happens.

Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
---
v3: rebase on today's spi/for-next and using PTR_ERR_OR_ZERO() in one place.
---
 drivers/spi/spi-fsl-spi.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index fb4159ad6bf6..3b81772fea0d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -706,8 +706,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	int irq = 0, type;
-	int ret = -ENOMEM;
+	int irq, type;
+	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -722,10 +722,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 		if (spisel_boot) {
 			pinfo->immr_spi_cs = ioremap(get_immrbase() + IMMR_SPI_CS_OFFSET, 4);
-			if (!pinfo->immr_spi_cs) {
-				ret = -ENOMEM;
-				goto err;
-			}
+			if (!pinfo->immr_spi_cs)
+				return -ENOMEM;
 		}
 #endif
 		/*
@@ -744,24 +742,15 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq = platform_get_irq(ofdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err;
-	}
+	if (irq < 0)
+		return irq;
 
 	master = fsl_spi_probe(dev, &mem, irq);
-	if (IS_ERR(master)) {
-		ret = PTR_ERR(master);
-		goto err;
-	}
-
-	return 0;
 
-err:
-	return ret;
+	return PTR_ERR_OR_ZERO(master);
 }
 
 static int of_fsl_spi_remove(struct platform_device *ofdev)
-- 
2.13.3
