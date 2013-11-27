From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 2/3] spi: rcar: Fix pointer cast in the remove function
Date: Wed, 27 Nov 2013 01:41:45 +0100
Message-ID: <1385512906-13108-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385512906-13108-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The platform driver data is set to point to the rspi_data structure at
probe time. Calling spi_master_get() on the pointer is just plain wrong
and only works by chance. Fix it by using the platform driver data
directly.

Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a3dca1d..621be5d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -885,14 +885,13 @@ static void rspi_release_dma(struct rspi_data *rspi)
 
 static int rspi_remove(struct platform_device *pdev)
 {
-	struct rspi_data *rspi = spi_master_get(platform_get_drvdata(pdev));
+	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	spi_unregister_master(rspi->master);
 	rspi_release_dma(rspi);
 	free_irq(platform_get_irq(pdev, 0), rspi);
 	clk_put(rspi->clk);
 	iounmap(rspi->addr);
-	spi_master_put(rspi->master);
 
 	return 0;
 }
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
