From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/3] spi: pxa2xx: Remove pointer to current SPI message from driver data
Date: Wed,  7 Sep 2016 17:04:06 +0300
Message-ID: <20160907140407.17631-2-jarkko.nikula@linux.intel.com>
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

There is no need to carry pointer to current SPI message in driver data
because cur_msg in struct spi_master holds it already when driver is using
the message queueing infrastructure from the SPI core.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c |  2 +-
 drivers/spi/spi-pxa2xx.c     | 25 +++++++++++--------------
 drivers/spi/spi-pxa2xx.h     |  1 -
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 80c8e27a2f73..38efac33da47 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -23,7 +23,7 @@
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 					     bool error)
 {
-	struct spi_message *msg = drv_data->cur_msg;
+	struct spi_message *msg = drv_data->master->cur_msg;
 
 	/*
 	 * It is possible that one CPU is handling ROR interrupt and other
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0e0d445f4028..e05af2a94d38 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -316,7 +316,7 @@ static void lpss_ssp_select_cs(struct driver_data *drv_data,
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 
-	cs = drv_data->cur_msg->spi->chip_select;
+	cs = drv_data->master->cur_msg->spi->chip_select;
 	cs <<= config->cs_sel_shift;
 	if (cs != (value & config->cs_sel_mask)) {
 		/*
@@ -508,7 +508,7 @@ static int u32_reader(struct driver_data *drv_data)
 
 void *pxa2xx_spi_next_transfer(struct driver_data *drv_data)
 {
-	struct spi_message *msg = drv_data->cur_msg;
+	struct spi_message *msg = drv_data->master->cur_msg;
 	struct spi_transfer *trans = drv_data->cur_transfer;
 
 	/* Move to next transfer */
@@ -529,8 +529,7 @@ static void giveback(struct driver_data *drv_data)
 	struct spi_message *msg;
 	unsigned long timeout;
 
-	msg = drv_data->cur_msg;
-	drv_data->cur_msg = NULL;
+	msg = drv_data->master->cur_msg;
 	drv_data->cur_transfer = NULL;
 
 	last_transfer = list_last_entry(&msg->transfers, struct spi_transfer,
@@ -610,7 +609,7 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
 
-	drv_data->cur_msg->state = ERROR_STATE;
+	drv_data->master->cur_msg->state = ERROR_STATE;
 	tasklet_schedule(&drv_data->pump_transfers);
 }
 
@@ -623,7 +622,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 
 	/* Update total byte transferred return count actual bytes read */
-	drv_data->cur_msg->actual_length += drv_data->len -
+	drv_data->master->cur_msg->actual_length += drv_data->len -
 				(drv_data->rx_end - drv_data->rx);
 
 	/* Transfer delays and chip select release are
@@ -631,7 +630,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	 */
 
 	/* Move to next transfer */
-	drv_data->cur_msg->state = pxa2xx_spi_next_transfer(drv_data);
+	drv_data->master->cur_msg->state = pxa2xx_spi_next_transfer(drv_data);
 
 	/* Schedule transfer tasklet */
 	tasklet_schedule(&drv_data->pump_transfers);
@@ -746,7 +745,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
 
-	if (!drv_data->cur_msg) {
+	if (!drv_data->master->cur_msg) {
 
 		pxa2xx_spi_write(drv_data, SSCR0,
 				 pxa2xx_spi_read(drv_data, SSCR0)
@@ -934,7 +933,7 @@ static void pump_transfers(unsigned long data)
 {
 	struct driver_data *drv_data = (struct driver_data *)data;
 	struct spi_master *master = drv_data->master;
-	struct spi_message *message;
+	struct spi_message *message = master->cur_msg;
 	struct spi_transfer *transfer;
 	struct spi_transfer *previous;
 	struct chip_data *chip;
@@ -950,7 +949,6 @@ static void pump_transfers(unsigned long data)
 	int dma_mapped;
 
 	/* Get current state information */
-	message = drv_data->cur_msg;
 	transfer = drv_data->cur_transfer;
 	chip = drv_data->cur_chip;
 
@@ -1146,16 +1144,15 @@ static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
 {
 	struct driver_data *drv_data = spi_master_get_devdata(master);
 
-	drv_data->cur_msg = msg;
 	/* Initial message state*/
-	drv_data->cur_msg->state = START_STATE;
-	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
+	msg->state = START_STATE;
+	drv_data->cur_transfer = list_entry(msg->transfers.next,
 						struct spi_transfer,
 						transfer_list);
 
 	/* prepare to setup the SSP, in pump_transfers, using the per
 	 * chip configuration */
-	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
+	drv_data->cur_chip = spi_get_ctldata(msg->spi);
 
 	/* Mark as busy and launch transfers */
 	tasklet_schedule(&drv_data->pump_transfers);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index d217ad55cc12..4f858664cee1 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -53,7 +53,6 @@ struct driver_data {
 	atomic_t dma_running;
 
 	/* Current message transfer state info */
-	struct spi_message *cur_msg;
 	struct spi_transfer *cur_transfer;
 	struct chip_data *cur_chip;
 	size_t len;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
