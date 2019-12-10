From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] spi: fsl: simplify error path in of_fsl_spi_probe()
Date: Tue, 10 Dec 2019 15:17:16 +0000 (UTC)
Message-ID: <539a3b82463f64e8055f166c915f0e90f752c7b0.1575990944.git.christophe.leroy@c-s.fr>
References: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1cdd0a26d7e1545f32c8bc4dc7458ebecdd6aaed.1575990944.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

No need to 'goto err;' for just doing a return.
return directly from where the error happens.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/spi/spi-fsl-spi.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 2d85c81983b1..e991c6ff4e7a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -725,8 +725,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	int irq = 0, type;
-	int ret = -ENOMEM;
+	int irq, type;
+	int ret;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
 	if (ret)
@@ -741,10 +741,8 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
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
@@ -763,24 +761,17 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 
 	ret = of_address_to_resource(np, 0, &mem);
 	if (ret)
-		goto err;
+		return ret;
 
 	irq = of_irq_to_resource(np, 0, NULL);
-	if (irq <= 0) {
-		ret = -EINVAL;
-		goto err;
-	}
+	if (irq <= 0)
+		return -EINVAL;
 
 	master = fsl_spi_probe(dev, &mem, irq);
-	if (IS_ERR(master)) {
-		ret = PTR_ERR(master);
-		goto err;
-	}
+	if (IS_ERR(master))
+		return PTR_ERR(master);
 
 	return 0;
-
-err:
-	return ret;
 }
 
 static int of_fsl_spi_remove(struct platform_device *ofdev)
-- 
2.13.3
