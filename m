From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] spi: dw: move to SPI core message handling
Date: Tue, 24 Feb 2015 18:17:56 +0200
Message-ID: <1424794676-15774-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch removes a lot of duplicate code since SPI core provides a nice
message handling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Changelog v2:
- remove leftovers from spi-dw.h
- remove unused members of dw_spi, i.e. cur_dev, max_bits_per_word
- reuse chip->cs_control directly

 drivers/spi/spi-dw-mid.c |   4 +-
 drivers/spi/spi-dw.c     | 186 +++++++++++------------------------------------
 drivers/spi/spi-dw.h     |  26 -------
 3 files changed, 46 insertions(+), 170 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index a0197fd..8f68e82 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -110,7 +110,7 @@ static void dw_spi_dma_tx_done(void *arg)
 
 	if (test_and_clear_bit(TX_BUSY, &dws->dma_chan_busy) & BIT(RX_BUSY))
 		return;
-	dw_spi_xfer_done(dws);
+	spi_finalize_current_transfer(dws->master);
 }
 
 static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws)
@@ -155,7 +155,7 @@ static void dw_spi_dma_rx_done(void *arg)
 
 	if (test_and_clear_bit(RX_BUSY, &dws->dma_chan_busy) & BIT(TX_BUSY))
 		return;
-	dw_spi_xfer_done(dws);
+	spi_finalize_current_transfer(dws->master);
 }
 
 static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 281121f..0003ba5 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -28,11 +28,6 @@
 #include <linux/debugfs.h>
 #endif
 
-#define START_STATE	((void *)0)
-#define RUNNING_STATE	((void *)1)
-#define DONE_STATE	((void *)2)
-#define ERROR_STATE	((void *)-1)
-
 /* Slave spi_dev related */
 struct chip_data {
 	u16 cr0;
@@ -143,6 +138,19 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+static void dw_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct chip_data *chip = spi_get_ctldata(spi);
+
+	/* Chip select logic is inverted from spi_set_cs() */
+	if (chip->cs_control)
+		chip->cs_control(!enable);
+
+	if (!enable)
+		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+}
+
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
 {
@@ -209,93 +217,41 @@ static void dw_reader(struct dw_spi *dws)
 	}
 }
 
-static void *next_transfer(struct dw_spi *dws)
-{
-	struct spi_message *msg = dws->cur_msg;
-	struct spi_transfer *trans = dws->cur_transfer;
-
-	/* Move to next transfer */
-	if (trans->transfer_list.next != &msg->transfers) {
-		dws->cur_transfer =
-			list_entry(trans->transfer_list.next,
-					struct spi_transfer,
-					transfer_list);
-		return RUNNING_STATE;
-	}
-
-	return DONE_STATE;
-}
-
 /*
  * Note: first step is the protocol driver prepares
  * a dma-capable memory, and this func just need translate
  * the virt addr to physical
  */
-static int map_dma_buffers(struct dw_spi *dws)
+static int map_dma_buffers(struct spi_master *master,
+		struct spi_device *spi, struct spi_transfer *transfer)
 {
-	if (!dws->cur_msg->is_dma_mapped
+	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct chip_data *chip = spi_get_ctldata(spi);
+
+	if (!master->cur_msg->is_dma_mapped
 		|| !dws->dma_inited
-		|| !dws->cur_chip->enable_dma
+		|| !chip->enable_dma
 		|| !dws->dma_ops)
 		return 0;
 
-	if (dws->cur_transfer->tx_dma)
-		dws->tx_dma = dws->cur_transfer->tx_dma;
+	if (transfer->tx_dma)
+		dws->tx_dma = transfer->tx_dma;
 
-	if (dws->cur_transfer->rx_dma)
-		dws->rx_dma = dws->cur_transfer->rx_dma;
+	if (transfer->rx_dma)
+		dws->rx_dma = transfer->rx_dma;
 
 	return 1;
 }
 
-/* Caller already set message->status; dma and pio irqs are blocked */
-static void giveback(struct dw_spi *dws)
-{
-	struct spi_transfer *last_transfer;
-	struct spi_message *msg;
-
-	msg = dws->cur_msg;
-	dws->cur_msg = NULL;
-	dws->cur_transfer = NULL;
-	dws->prev_chip = dws->cur_chip;
-	dws->cur_chip = NULL;
-	dws->dma_mapped = 0;
-
-	last_transfer = list_last_entry(&msg->transfers, struct spi_transfer,
-					transfer_list);
-
-	if (!last_transfer->cs_change)
-		spi_chip_sel(dws, msg->spi, 0);
-
-	spi_finalize_current_message(dws->master);
-}
-
 static void int_error_stop(struct dw_spi *dws, const char *msg)
 {
 	/* Stop the hw */
 	spi_enable_chip(dws, 0);
 
 	dev_err(&dws->master->dev, "%s\n", msg);
-	dws->cur_msg->state = ERROR_STATE;
-	tasklet_schedule(&dws->pump_transfers);
-}
-
-void dw_spi_xfer_done(struct dw_spi *dws)
-{
-	/* Update total byte transferred return count actual bytes read */
-	dws->cur_msg->actual_length += dws->len;
-
-	/* Move to next transfer */
-	dws->cur_msg->state = next_transfer(dws);
-
-	/* Handle end of message */
-	if (dws->cur_msg->state == DONE_STATE) {
-		dws->cur_msg->status = 0;
-		giveback(dws);
-	} else
-		tasklet_schedule(&dws->pump_transfers);
+	dws->master->cur_msg->status = -EIO;
+	spi_finalize_current_transfer(dws->master);
 }
-EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
 
 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
@@ -313,7 +269,7 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 	dw_reader(dws);
 	if (dws->rx_end == dws->rx) {
 		spi_mask_intr(dws, SPI_INT_TXEI);
-		dw_spi_xfer_done(dws);
+		spi_finalize_current_transfer(dws->master);
 		return IRQ_HANDLED;
 	}
 	if (irq_status & SPI_INT_TXEI) {
@@ -328,13 +284,14 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
-	struct dw_spi *dws = dev_id;
+	struct spi_master *master = dev_id;
+	struct dw_spi *dws = spi_master_get_devdata(master);
 	u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
 
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!dws->cur_msg) {
+	if (!master->cur_msg) {
 		spi_mask_intr(dws, SPI_INT_TXEI);
 		return IRQ_HANDLED;
 	}
@@ -343,7 +300,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 }
 
 /* Must be called inside pump_transfers() */
-static void poll_transfer(struct dw_spi *dws)
+static int poll_transfer(struct dw_spi *dws)
 {
 	do {
 		dw_writer(dws);
@@ -351,17 +308,14 @@ static void poll_transfer(struct dw_spi *dws)
 		cpu_relax();
 	} while (dws->rx_end > dws->rx);
 
-	dw_spi_xfer_done(dws);
+	return 0;
 }
 
-static void pump_transfers(unsigned long data)
+static int dw_spi_transfer_one(struct spi_master *master,
+		struct spi_device *spi, struct spi_transfer *transfer)
 {
-	struct dw_spi *dws = (struct dw_spi *)data;
-	struct spi_message *message = NULL;
-	struct spi_transfer *transfer = NULL;
-	struct spi_transfer *previous = NULL;
-	struct spi_device *spi = NULL;
-	struct chip_data *chip = NULL;
+	struct dw_spi *dws = spi_master_get_devdata(master);
+	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 bits = 0;
 	u8 imask = 0;
 	u8 cs_change = 0;
@@ -370,35 +324,8 @@ static void pump_transfers(unsigned long data)
 	u32 speed = 0;
 	u32 cr0 = 0;
 
-	/* Get current state information */
-	message = dws->cur_msg;
-	transfer = dws->cur_transfer;
-	chip = dws->cur_chip;
-	spi = message->spi;
-
-	if (message->state == ERROR_STATE) {
-		message->status = -EIO;
-		goto early_exit;
-	}
-
-	/* Handle end of message */
-	if (message->state == DONE_STATE) {
-		message->status = 0;
-		goto early_exit;
-	}
-
-	/* Delay if requested at end of transfer */
-	if (message->state == RUNNING_STATE) {
-		previous = list_entry(transfer->transfer_list.prev,
-					struct spi_transfer,
-					transfer_list);
-		if (previous->delay_usecs)
-			udelay(previous->delay_usecs);
-	}
-
 	dws->n_bytes = chip->n_bytes;
 	dws->dma_width = chip->dma_width;
-	dws->cs_control = chip->cs_control;
 
 	dws->rx_dma = transfer->rx_dma;
 	dws->tx_dma = transfer->tx_dma;
@@ -406,7 +333,7 @@ static void pump_transfers(unsigned long data)
 	dws->tx_end = dws->tx + transfer->len;
 	dws->rx = transfer->rx_buf;
 	dws->rx_end = dws->rx + transfer->len;
-	dws->len = dws->cur_transfer->len;
+	dws->len = transfer->len;
 	if (chip != dws->prev_chip)
 		cs_change = 1;
 
@@ -434,13 +361,12 @@ static void pump_transfers(unsigned long data)
 			| (spi->mode << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
 	}
-	message->state = RUNNING_STATE;
 
 	/*
 	 * Adjust transfer mode if necessary. Requires platform dependent
 	 * chipselect mechanism.
 	 */
-	if (dws->cs_control) {
+	if (chip->cs_control) {
 		if (dws->rx && dws->tx)
 			chip->tmode = SPI_TMOD_TR;
 		else if (dws->rx)
@@ -453,7 +379,7 @@ static void pump_transfers(unsigned long data)
 	}
 
 	/* Check if current transfer is a DMA transaction */
-	dws->dma_mapped = map_dma_buffers(dws);
+	dws->dma_mapped = map_dma_buffers(master, spi, transfer);
 
 	/*
 	 * Interrupt mode
@@ -479,7 +405,6 @@ static void pump_transfers(unsigned long data)
 		dw_writew(dws, DW_SPI_CTRL0, cr0);
 
 		spi_set_clk(dws, chip->clk_div);
-		spi_chip_sel(dws, spi, 1);
 
 		/* Set the interrupt mask, for poll mode just disable all int */
 		spi_mask_intr(dws, 0xff);
@@ -498,31 +423,9 @@ static void pump_transfers(unsigned long data)
 		dws->dma_ops->dma_transfer(dws, cs_change);
 
 	if (chip->poll_mode)
-		poll_transfer(dws);
-
-	return;
+		return poll_transfer(dws);
 
-early_exit:
-	giveback(dws);
-}
-
-static int dw_spi_transfer_one_message(struct spi_master *master,
-		struct spi_message *msg)
-{
-	struct dw_spi *dws = spi_master_get_devdata(master);
-
-	dws->cur_msg = msg;
-	/* Initial message state */
-	dws->cur_msg->state = START_STATE;
-	dws->cur_transfer = list_entry(dws->cur_msg->transfers.next,
-						struct spi_transfer,
-						transfer_list);
-	dws->cur_chip = spi_get_ctldata(dws->cur_msg->spi);
-
-	/* Launch transfers */
-	tasklet_schedule(&dws->pump_transfers);
-
-	return 0;
+	return dws->len;
 }
 
 /* This may be called twice for each spi dev */
@@ -648,7 +551,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 
 	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
-			dws->name, dws);
+			dws->name, master);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
 		goto err_free_master;
@@ -660,7 +563,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
 	master->cleanup = dw_spi_cleanup;
-	master->transfer_one_message = dw_spi_transfer_one_message;
+	master->set_cs = dw_spi_set_cs;
+	master->transfer_one = dw_spi_transfer_one;
 	master->max_speed_hz = dws->max_freq;
 	master->dev.of_node = dev->of_node;
 
@@ -675,8 +579,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	tasklet_init(&dws->pump_transfers, pump_transfers, (unsigned long)dws);
-
 	spi_master_set_devdata(master, dws);
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 3d32be6..70cad09 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -96,7 +96,6 @@ struct dw_spi_dma_ops {
 
 struct dw_spi {
 	struct spi_master	*master;
-	struct spi_device	*cur_dev;
 	enum dw_ssi_type	type;
 	char			name[16];
 
@@ -109,13 +108,7 @@ struct dw_spi {
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
 
-	/* Message Transfer pump */
-	struct tasklet_struct	pump_transfers;
-
 	/* Current message transfer state info */
-	struct spi_message	*cur_msg;
-	struct spi_transfer	*cur_transfer;
-	struct chip_data	*cur_chip;
 	struct chip_data	*prev_chip;
 	size_t			len;
 	void			*tx;
@@ -128,10 +121,8 @@ struct dw_spi {
 	size_t			rx_map_len;
 	size_t			tx_map_len;
 	u8			n_bytes;	/* current is a 1/2 bytes op */
-	u8			max_bits_per_word;	/* maxim is 16b */
 	u32			dma_width;
 	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
-	void			(*cs_control)(u32 command);
 
 	/* Dma info */
 	int			dma_inited;
@@ -182,22 +173,6 @@ static inline void spi_set_clk(struct dw_spi *dws, u16 div)
 	dw_writel(dws, DW_SPI_BAUDR, div);
 }
 
-static inline void spi_chip_sel(struct dw_spi *dws, struct spi_device *spi,
-		int active)
-{
-	u16 cs = spi->chip_select;
-	int gpio_val = active ? (spi->mode & SPI_CS_HIGH) :
-		!(spi->mode & SPI_CS_HIGH);
-
-	if (dws->cs_control)
-		dws->cs_control(active);
-	if (gpio_is_valid(spi->cs_gpio))
-		gpio_set_value(spi->cs_gpio, gpio_val);
-
-	if (active)
-		dw_writel(dws, DW_SPI_SER, 1 << cs);
-}
-
 /* Disable IRQ bits */
 static inline void spi_mask_intr(struct dw_spi *dws, u32 mask)
 {
@@ -233,7 +208,6 @@ extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
-extern void dw_spi_xfer_done(struct dw_spi *dws);
 
 /* platform related setup */
 extern int dw_spi_mid_init(struct dw_spi *dws); /* Intel MID platforms */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
