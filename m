From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/3] spi: pxa2xx: Remove pointer to chip data from driver data
Date: Wed,  7 Sep 2016 17:04:07 +0300
Message-ID: <20160907140407.17631-3-jarkko.nikula@linux.intel.com>
References: <20160907140407.17631-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160907140407.17631-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Transfer state machine in this driver does not need to set/unset pointer
to chip data between queueing and finalizing message as it is not
actually used as a state info itself but just pointer passing.

Since this per SPI device specific chip data is already carried in
ctldata use that and remove pointer to chip data from driver data.

While at it, group initialized variables before uninitialized variables
in pump_transfers().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c |  3 ++-
 drivers/spi/spi-pxa2xx.c     | 28 +++++++++++++---------------
 drivers/spi/spi-pxa2xx.h     |  1 -
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 38efac33da47..04f3eecf5cf3 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -76,7 +76,8 @@ static struct dma_async_tx_descriptor *
 pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 			   enum dma_transfer_direction dir)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	struct spi_transfer *xfer = drv_data->cur_transfer;
 	enum dma_slave_buswidth width;
 	struct dma_slave_config cfg;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e05af2a94d38..6a0eb32408b6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -355,10 +355,11 @@ static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 
 static void cs_assert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 
 	if (drv_data->ssp_type == CE4100_SSP) {
-		pxa2xx_spi_write(drv_data, SSSR, drv_data->cur_chip->frm);
+		pxa2xx_spi_write(drv_data, SSSR, chip->frm);
 		return;
 	}
 
@@ -378,7 +379,8 @@ static void cs_assert(struct driver_data *drv_data)
 
 static void cs_deassert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 
 	if (drv_data->ssp_type == CE4100_SSP)
 		return;
@@ -574,13 +576,13 @@ static void giveback(struct driver_data *drv_data)
 			cs_deassert(drv_data);
 	}
 
-	drv_data->cur_chip = NULL;
 	spi_finalize_current_message(drv_data->master);
 }
 
 static void reset_sccr1(struct driver_data *drv_data)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	u32 sccr1_reg;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
@@ -904,7 +906,8 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 					   int rate)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	unsigned int clk_div;
 
 	switch (drv_data->ssp_type) {
@@ -934,23 +937,22 @@ static void pump_transfers(unsigned long data)
 	struct driver_data *drv_data = (struct driver_data *)data;
 	struct spi_master *master = drv_data->master;
 	struct spi_message *message = master->cur_msg;
+	struct chip_data *chip = spi_get_ctldata(message->spi);
+	u32 dma_thresh = chip->dma_threshold;
+	u32 dma_burst = chip->dma_burst_size;
+	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
 	struct spi_transfer *transfer;
 	struct spi_transfer *previous;
-	struct chip_data *chip;
 	u32 clk_div;
 	u8 bits;
 	u32 speed;
 	u32 cr0;
 	u32 cr1;
-	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
-	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
-	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
 	int err;
 	int dma_mapped;
 
 	/* Get current state information */
 	transfer = drv_data->cur_transfer;
-	chip = drv_data->cur_chip;
 
 	/* Handle for abort */
 	if (message->state == ERROR_STATE) {
@@ -1150,10 +1152,6 @@ static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
 						struct spi_transfer,
 						transfer_list);
 
-	/* prepare to setup the SSP, in pump_transfers, using the per
-	 * chip configuration */
-	drv_data->cur_chip = spi_get_ctldata(msg->spi);
-
 	/* Mark as busy and launch transfers */
 	tasklet_schedule(&drv_data->pump_transfers);
 	return 0;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 4f858664cee1..ae3b15ff6fb2 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -54,7 +54,6 @@ struct driver_data {
 
 	/* Current message transfer state info */
 	struct spi_transfer *cur_transfer;
-	struct chip_data *cur_chip;
 	size_t len;
 	void *tx;
 	void *tx_end;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
