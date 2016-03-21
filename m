From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: octeon: Convert to use devm_ioremap_resource" to the spi tree
Date: Mon, 21 Mar 2016 17:06:47 +0000
Message-ID: <E1ai3Hz-0005Od-1k@debutante>
References: <1458435286.9290.0.camel@ingics.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458435286.9290.0.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: octeon: Convert to use devm_ioremap_resource

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3ae36c8b67e450dcb7011181658c198bec386e98 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sun, 20 Mar 2016 08:54:46 +0800
Subject: [PATCH] spi: octeon: Convert to use devm_ioremap_resource

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 07e4ce8273df..3b170093989f 100644
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
