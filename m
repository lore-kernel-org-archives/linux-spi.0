From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: omap-100k: Remove unused fields from struct
 omap1_spi100k
Date: Sun, 09 Feb 2014 11:35:59 +0800
Message-ID: <1391916959.20382.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Both *master and state are not really used, remove them.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 657184a..81f2e6e 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -83,15 +83,11 @@
 #define SPI_SHUTDOWN	1
 
 struct omap1_spi100k {
-	struct spi_master       *master;
 	struct clk              *ick;
 	struct clk              *fck;
 
 	/* Virtual base address of the controller */
 	void __iomem            *base;
-
-	/* State of the SPI */
-	unsigned int		state;
 };
 
 struct omap1_spi100k_cs {
@@ -427,7 +423,6 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	spi100k = spi_master_get_devdata(master);
-	spi100k->master = master;
 
 	/*
 	 * The memory region base address is taken as the platform_data.
@@ -454,8 +449,6 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto err;
 
-	spi100k->state = SPI_RUNNING;
-
 	return status;
 
 err:
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
