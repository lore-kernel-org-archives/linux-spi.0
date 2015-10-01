From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Remove empty function pxa2xx_spi_dma_resume()
Date: Thu,  1 Oct 2015 18:23:18 +0300
Message-ID: <1443712998-39637-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This was leftover from the legacy pxa2xx DMA implementation and not needed
anymore so remove it.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 4 ----
 drivers/spi/spi-pxa2xx.c     | 2 --
 drivers/spi/spi-pxa2xx.h     | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 66a173939be8..bd8b369a343c 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -344,10 +344,6 @@ void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 	}
 }
 
-void pxa2xx_spi_dma_resume(struct driver_data *drv_data)
-{
-}
-
 int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   struct spi_device *spi,
 					   u8 bits_per_word, u32 *burst_code,
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a8ef38ebb9c9..0b10f97d04b4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1614,8 +1614,6 @@ static int pxa2xx_spi_resume(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;
 
-	pxa2xx_spi_dma_resume(drv_data);
-
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev))
 		clk_prepare_enable(ssp->clk);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 0a9b6390a817..0d3dde6d54f5 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -175,7 +175,6 @@ extern int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst);
 extern void pxa2xx_spi_dma_start(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_setup(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_release(struct driver_data *drv_data);
-extern void pxa2xx_spi_dma_resume(struct driver_data *drv_data);
 extern int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 						  struct spi_device *spi,
 						  u8 bits_per_word,
@@ -196,7 +195,6 @@ static inline int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 	return 0;
 }
 static inline void pxa2xx_spi_dma_release(struct driver_data *drv_data) {}
-static inline void pxa2xx_spi_dma_resume(struct driver_data *drv_data) {}
 static inline int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 							 struct spi_device *spi,
 							 u8 bits_per_word,
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
