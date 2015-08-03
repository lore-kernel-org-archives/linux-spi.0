From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-pxa2xx: Remove unused legacy PXA DMA API channel numbers
Date: Mon,  3 Aug 2015 13:41:11 +0300
Message-ID: <1438598472-1145-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These became unused by the commit 6356437e65c2
("spi: spi-pxa2xx: remove legacy PXA DMA bits").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 --
 drivers/spi/spi-pxa2xx.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2c9fa409d2bf..e924710e126c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1475,8 +1475,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Setup DMA if requested */
-	drv_data->tx_channel = -1;
-	drv_data->rx_channel = -1;
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 9f01e9c9aa75..3b69c46bfbc9 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -37,8 +37,6 @@ struct driver_data {
 	struct pxa2xx_spi_master *master_info;
 
 	/* PXA private DMA setup stuff */
-	int rx_channel;
-	int tx_channel;
 	u32 *null_dma_buf;
 
 	/* SSP register addresses */
-- 
2.4.6

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
