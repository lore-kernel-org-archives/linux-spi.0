From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] spi: spi-pxa2xx: Remove unused legacy null dma buffer and allocation for it
Date: Mon,  3 Aug 2015 13:41:12 +0300
Message-ID: <1438598472-1145-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1438598472-1145-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438598472-1145-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove null_dma_buf variable and extra allocation for it. It is not needed
since commit 6356437e65c2 ("spi: spi-pxa2xx: remove legacy PXA DMA bits").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 +---
 drivers/spi/spi-pxa2xx.h | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e924710e126c..97c323dda99e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1413,8 +1413,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Allocate master with space for drv_data and null dma buffer */
-	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
+	master = spi_alloc_master(dev, sizeof(struct driver_data));
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1441,7 +1440,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 
 	drv_data->ssp_type = ssp->type;
-	drv_data->null_dma_buf = (u32 *)PTR_ALIGN(&drv_data[1], DMA_ALIGNMENT);
 
 	drv_data->ioaddr = ssp->mmio_base;
 	drv_data->ssdr_physical = ssp->phys_base + SSDR;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 3b69c46bfbc9..0a9b6390a817 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -36,9 +36,6 @@ struct driver_data {
 	/* PXA hookup */
 	struct pxa2xx_spi_master *master_info;
 
-	/* PXA private DMA setup stuff */
-	u32 *null_dma_buf;
-
 	/* SSP register addresses */
 	void __iomem *ioaddr;
 	u32 ssdr_physical;
-- 
2.4.6

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
