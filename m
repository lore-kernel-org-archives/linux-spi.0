From: Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
Subject: [PATCH] spi: fsl: Call irq_dispose_mapping in err path
Date: Thu,  9 Mar 2017 22:40:01 +0800
Message-ID: <1489070401-5663-1-git-send-email-liu.xiang6@zte.com.cn>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Irq_dispose_mapping should be called in err path to release
the resources that irq_of_parse_and_map requested.

Signed-off-by: Liu Xiang <liu.xiang6-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8b290d9..5920343 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -813,7 +813,7 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct spi_master *master;
 	struct resource mem;
-	int irq, type;
+	int irq = 0, type;
 	int ret = -ENOMEM;
 
 	ret = of_mpc8xxx_spi_probe(ofdev);
@@ -846,6 +846,7 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	return 0;
 
 err:
+	irq_dispose_mapping(irq);
 	if (type == TYPE_FSL)
 		of_fsl_spi_free_chipselects(dev);
 	return ret;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
