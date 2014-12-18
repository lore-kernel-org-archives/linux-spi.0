From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/5] spi: pxa2xx: Pass driver data instead of ioaddr to wait_ssp_rx_stall()
Date: Thu, 18 Dec 2014 15:04:22 +0200
Message-ID: <1418907863-11116-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1418907863-11116-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418907863-11116-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Pass pointer to struct driver_data instead of ioaddr to wait_ssp_rx_stall()
for preparing to register access macro cleanup.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pxadma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pxadma.c b/drivers/spi/spi-pxa2xx-pxadma.c
index e8a26f25d5c0..aaa5fc6b465e 100644
--- a/drivers/spi/spi-pxa2xx-pxadma.c
+++ b/drivers/spi/spi-pxa2xx-pxadma.c
@@ -118,11 +118,11 @@ static void pxa2xx_spi_unmap_dma_buffers(struct driver_data *drv_data)
 	drv_data->dma_mapped = 0;
 }
 
-static int wait_ssp_rx_stall(void const __iomem *ioaddr)
+static int wait_ssp_rx_stall(struct driver_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
-	while ((read_SSSR(ioaddr) & SSSR_BSY) && --limit)
+	while ((read_SSSR(drv_data->ioaddr) & SSSR_BSY) && --limit)
 		cpu_relax();
 
 	return limit;
@@ -228,7 +228,7 @@ void pxa2xx_spi_dma_handler(int channel, void *data)
 		&& (drv_data->ssp_type == PXA25x_SSP)) {
 
 		/* Wait for rx to stall */
-		if (wait_ssp_rx_stall(drv_data->ioaddr) == 0)
+		if (wait_ssp_rx_stall(drv_data) == 0)
 			dev_err(&drv_data->pdev->dev,
 				"dma_handler: ssp rx stall failed\n");
 
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
