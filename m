From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/3] spi: pxa2xx: Do not needlessly initialize stack variables
Date: Wed,  7 Sep 2016 17:04:05 +0300
Message-ID: <20160907140407.17631-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

All of these variables are unconditionally set before their use.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
