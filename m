From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drivers/spi/spi-tegra114.c clean use of devm_ioremap_resource()
Date: Tue, 14 May 2013 12:07:12 +0200
Message-ID: <1368526032-31371-1-git-send-email-laurent.navet@gmail.com>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Check of 'r' and calls to dev_err are already done in devm_ioremap_resource,
so no need to do them twice.

Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-tegra114.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 598eb45..18a6592 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1059,18 +1059,12 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&tspi->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "No IO memory resource\n");
-		ret = -ENODEV;
-		goto exit_free_master;
-	}
-	tspi->phys = r->start;
 	tspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(tspi->base)) {
 		ret = PTR_ERR(tspi->base);
-		dev_err(&pdev->dev, "ioremap failed: err = %d\n", ret);
 		goto exit_free_master;
 	}
+	tspi->phys = r->start;
 
 	spi_irq = platform_get_irq(pdev, 0);
 	tspi->irq = spi_irq;
-- 
1.7.10.4
