From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove empty function pxa2xx_spi_dma_resume()" to the spi tree
Date: Thu, 01 Oct 2015 17:44:58 +0100
Message-ID: <E1ZhgyY-0005pI-83@finisterre>
References: <1443712998-39637-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443712998-39637-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove empty function pxa2xx_spi_dma_resume()

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

>From 289de5541ca6aec56308c04b76c1bb59f00b1f09 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 1 Oct 2015 18:23:18 +0300
Subject: [PATCH] spi: pxa2xx: Remove empty function pxa2xx_spi_dma_resume()

This was leftover from the legacy pxa2xx DMA implementation and not needed
anymore so remove it.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c | 4 ----
 drivers/spi/spi-pxa2xx.c     | 2 --
 drivers/spi/spi-pxa2xx.h     | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 66a1739..bd8b369 100644
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
index aed9aab..22b473e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1598,8 +1598,6 @@ static int pxa2xx_spi_resume(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;
 
-	pxa2xx_spi_dma_resume(drv_data);
-
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev))
 		clk_prepare_enable(ssp->clk);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index fd7a7bc..514cf9717 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -169,7 +169,6 @@ extern int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst);
 extern void pxa2xx_spi_dma_start(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_setup(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_release(struct driver_data *drv_data);
-extern void pxa2xx_spi_dma_resume(struct driver_data *drv_data);
 extern int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 						  struct spi_device *spi,
 						  u8 bits_per_word,
@@ -190,7 +189,6 @@ static inline int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 	return 0;
 }
 static inline void pxa2xx_spi_dma_release(struct driver_data *drv_data) {}
-static inline void pxa2xx_spi_dma_resume(struct driver_data *drv_data) {}
 static inline int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 							 struct spi_device *spi,
 							 u8 bits_per_word,
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
