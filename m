From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: octeon: Convert to use devm_ioremap_resource
Date: Sun, 20 Mar 2016 08:54:46 +0800
Message-ID: <1458435286.9290.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 07e4ce8..3b17009 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -175,6 +175,7 @@ err:
 static int octeon_spi_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem;
+	void __iomem *reg_base;
 	struct spi_master *master;
 	struct octeon_spi *p;
 	int err = -ENOENT;
@@ -186,19 +187,13 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "found no memory resource\n");
-		err = -ENXIO;
-		goto fail;
-	}
-	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
-				     resource_size(res_mem), res_mem->name)) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
+	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(reg_base)) {
+		err = PTR_ERR(reg_base);
 		goto fail;
 	}
-	p->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
-					     resource_size(res_mem));
+
+	p->register_base = (u64)reg_base;
 
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPHA |
-- 
2.1.4



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
