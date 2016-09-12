From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Do not needlessly initialize stack variables" to the spi tree
Date: Mon, 12 Sep 2016 20:08:00 +0100
Message-ID: <E1bjWaG-0002oV-Cs@debutante>
References: <20160907140407.17631-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160907140407.17631-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Do not needlessly initialize stack variables

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

>From bffc967e93c771805739a4cc4c7849a749a7b0a6 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 7 Sep 2016 17:04:05 +0300
Subject: [PATCH] spi: pxa2xx: Do not needlessly initialize stack variables

All of these variables are unconditionally set before their use.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c |  2 +-
 drivers/spi/spi-pxa2xx.c     | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index db3ae1dd829e..80c8e27a2f73 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -146,7 +146,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 int pxa2xx_spi_dma_prepare(struct driver_data *drv_data, u32 dma_burst)
 {
 	struct dma_async_tx_descriptor *tx_desc, *rx_desc;
-	int err = 0;
+	int err;
 
 	tx_desc = pxa2xx_spi_dma_prepare_one(drv_data, DMA_MEM_TO_DEV);
 	if (!tx_desc) {
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 87150a1049bd..0e0d445f4028 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -934,13 +934,13 @@ static void pump_transfers(unsigned long data)
 {
 	struct driver_data *drv_data = (struct driver_data *)data;
 	struct spi_master *master = drv_data->master;
-	struct spi_message *message = NULL;
-	struct spi_transfer *transfer = NULL;
-	struct spi_transfer *previous = NULL;
-	struct chip_data *chip = NULL;
-	u32 clk_div = 0;
-	u8 bits = 0;
-	u32 speed = 0;
+	struct spi_message *message;
+	struct spi_transfer *transfer;
+	struct spi_transfer *previous;
+	struct chip_data *chip;
+	u32 clk_div;
+	u8 bits;
+	u32 speed;
 	u32 cr0;
 	u32 cr1;
 	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
@@ -1213,7 +1213,7 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 
 static int setup(struct spi_device *spi)
 {
-	struct pxa2xx_spi_chip *chip_info = NULL;
+	struct pxa2xx_spi_chip *chip_info;
 	struct chip_data *chip;
 	const struct lpss_config *config;
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
@@ -1742,7 +1742,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status = 0;
+	int status;
 
 	status = spi_master_suspend(drv_data->master);
 	if (status != 0)
@@ -1759,7 +1759,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status = 0;
+	int status;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev))
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
