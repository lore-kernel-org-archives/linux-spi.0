From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 29/28] spi/bfin_spi: namespace local
	structs
Date: Mon, 18 Oct 2010 02:46:17 -0400
Message-ID: <1287384377-1432-1-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |  119 +++++++++++++++++++++++----------------------
 1 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index d17ab37..ab483a0 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1,7 +1,7 @@
 /*
  * Blackfin On-Chip SPI Driver
  *
- * Copyright 2004-2007 Analog Devices Inc.
+ * Copyright 2004-2010 Analog Devices Inc.
  *
  * Enter bugs at http://blackfin.uclinux.org/
  *
@@ -42,15 +42,15 @@ MODULE_LICENSE("GPL");
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
 
-struct master_data;
+struct bfin_spi_master_data;
 
-struct transfer_ops {
-	void (*write) (struct master_data *);
-	void (*read) (struct master_data *);
-	void (*duplex) (struct master_data *);
+struct bfin_spi_transfer_ops {
+	void (*write) (struct bfin_spi_master_data *);
+	void (*read) (struct bfin_spi_master_data *);
+	void (*duplex) (struct bfin_spi_master_data *);
 };
 
-struct master_data {
+struct bfin_spi_master_data {
 	/* Driver model hookup */
 	struct platform_device *pdev;
 
@@ -80,7 +80,7 @@ struct master_data {
 	/* Current message transfer state info */
 	struct spi_message *cur_msg;
 	struct spi_transfer *cur_transfer;
-	struct slave_data *cur_chip;
+	struct bfin_spi_slave_data *cur_chip;
 	size_t len_in_bytes;
 	size_t len;
 	void *tx;
@@ -105,10 +105,10 @@ struct master_data {
 	u16 flag_reg;
 
 	int cs_change;
-	const struct transfer_ops *ops;
+	const struct bfin_spi_transfer_ops *ops;
 };
 
-struct slave_data {
+struct bfin_spi_slave_data {
 	u16 ctl_reg;
 	u16 baud;
 	u16 flag;
@@ -119,13 +119,13 @@ struct slave_data {
 	u32 cs_gpio;
 	u16 idle_tx_val;
 	u8 pio_interrupt;	/* use spi data irq */
-	const struct transfer_ops *ops;
+	const struct bfin_spi_transfer_ops *ops;
 };
 
 #define DEFINE_SPI_REG(reg, off) \
-static inline u16 read_##reg(struct master_data *drv_data) \
+static inline u16 read_##reg(struct bfin_spi_master_data *drv_data) \
 	{ return bfin_read16(drv_data->regs_base + off); } \
-static inline void write_##reg(struct master_data *drv_data, u16 v) \
+static inline void write_##reg(struct bfin_spi_master_data *drv_data, u16 v) \
 	{ bfin_write16(drv_data->regs_base + off, v); }
 
 DEFINE_SPI_REG(CTRL, 0x00)
@@ -136,7 +136,7 @@ DEFINE_SPI_REG(RDBR, 0x10)
 DEFINE_SPI_REG(BAUD, 0x14)
 DEFINE_SPI_REG(SHAW, 0x18)
 
-static void bfin_spi_enable(struct master_data *drv_data)
+static void bfin_spi_enable(struct bfin_spi_master_data *drv_data)
 {
 	u16 cr;
 
@@ -144,7 +144,7 @@ static void bfin_spi_enable(struct master_data *drv_data)
 	write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
 }
 
-static void bfin_spi_disable(struct master_data *drv_data)
+static void bfin_spi_disable(struct bfin_spi_master_data *drv_data)
 {
 	u16 cr;
 
@@ -167,7 +167,7 @@ static u16 hz_to_spi_baud(u32 speed_hz)
 	return spi_baud;
 }
 
-static int bfin_spi_flush(struct master_data *drv_data)
+static int bfin_spi_flush(struct bfin_spi_master_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
@@ -181,7 +181,7 @@ static int bfin_spi_flush(struct master_data *drv_data)
 }
 
 /* Chip select operation functions for cs_change flag */
-static void bfin_spi_cs_active(struct master_data *drv_data, struct slave_data *chip)
+static void bfin_spi_cs_active(struct bfin_spi_master_data *drv_data, struct bfin_spi_slave_data *chip)
 {
 	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
 		u16 flag = read_FLAG(drv_data);
@@ -194,7 +194,8 @@ static void bfin_spi_cs_active(struct master_data *drv_data, struct slave_data *
 	}
 }
 
-static void bfin_spi_cs_deactive(struct master_data *drv_data, struct slave_data *chip)
+static void bfin_spi_cs_deactive(struct bfin_spi_master_data *drv_data,
+                                 struct bfin_spi_slave_data *chip)
 {
 	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
 		u16 flag = read_FLAG(drv_data);
@@ -212,7 +213,8 @@ static void bfin_spi_cs_deactive(struct master_data *drv_data, struct slave_data
 }
 
 /* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
-static inline void bfin_spi_cs_enable(struct master_data *drv_data, struct slave_data *chip)
+static inline void bfin_spi_cs_enable(struct bfin_spi_master_data *drv_data,
+                                      struct bfin_spi_slave_data *chip)
 {
 	if (chip->chip_select_num < MAX_CTRL_CS) {
 		u16 flag = read_FLAG(drv_data);
@@ -223,7 +225,8 @@ static inline void bfin_spi_cs_enable(struct master_data *drv_data, struct slave
 	}
 }
 
-static inline void bfin_spi_cs_disable(struct master_data *drv_data, struct slave_data *chip)
+static inline void bfin_spi_cs_disable(struct bfin_spi_master_data *drv_data,
+                                       struct bfin_spi_slave_data *chip)
 {
 	if (chip->chip_select_num < MAX_CTRL_CS) {
 		u16 flag = read_FLAG(drv_data);
@@ -235,9 +238,9 @@ static inline void bfin_spi_cs_disable(struct master_data *drv_data, struct slav
 }
 
 /* stop controller and re-config current chip*/
-static void bfin_spi_restore_state(struct master_data *drv_data)
+static void bfin_spi_restore_state(struct bfin_spi_master_data *drv_data)
 {
-	struct slave_data *chip = drv_data->cur_chip;
+	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
 
 	/* Clear status and disable clock */
 	write_STAT(drv_data, BIT_STAT_CLR);
@@ -255,12 +258,12 @@ static void bfin_spi_restore_state(struct master_data *drv_data)
 }
 
 /* used to kick off transfer in rx mode and read unwanted RX data */
-static inline void bfin_spi_dummy_read(struct master_data *drv_data)
+static inline void bfin_spi_dummy_read(struct bfin_spi_master_data *drv_data)
 {
 	(void) read_RDBR(drv_data);
 }
 
-static void bfin_spi_u8_writer(struct master_data *drv_data)
+static void bfin_spi_u8_writer(struct bfin_spi_master_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
 	bfin_spi_dummy_read(drv_data);
@@ -276,7 +279,7 @@ static void bfin_spi_u8_writer(struct master_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_reader(struct master_data *drv_data)
+static void bfin_spi_u8_reader(struct bfin_spi_master_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
 
@@ -291,7 +294,7 @@ static void bfin_spi_u8_reader(struct master_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_duplex(struct master_data *drv_data)
+static void bfin_spi_u8_duplex(struct bfin_spi_master_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
 	bfin_spi_dummy_read(drv_data);
@@ -304,13 +307,13 @@ static void bfin_spi_u8_duplex(struct master_data *drv_data)
 	}
 }
 
-static const struct transfer_ops bfin_transfer_ops_u8 = {
+static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u8 = {
 	.write  = bfin_spi_u8_writer,
 	.read   = bfin_spi_u8_reader,
 	.duplex = bfin_spi_u8_duplex,
 };
 
-static void bfin_spi_u16_writer(struct master_data *drv_data)
+static void bfin_spi_u16_writer(struct bfin_spi_master_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
 	bfin_spi_dummy_read(drv_data);
@@ -327,7 +330,7 @@ static void bfin_spi_u16_writer(struct master_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_reader(struct master_data *drv_data)
+static void bfin_spi_u16_reader(struct bfin_spi_master_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
 
@@ -343,7 +346,7 @@ static void bfin_spi_u16_reader(struct master_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_duplex(struct master_data *drv_data)
+static void bfin_spi_u16_duplex(struct bfin_spi_master_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
 	bfin_spi_dummy_read(drv_data);
@@ -358,14 +361,14 @@ static void bfin_spi_u16_duplex(struct master_data *drv_data)
 	}
 }
 
-static const struct transfer_ops bfin_transfer_ops_u16 = {
+static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u16 = {
 	.write  = bfin_spi_u16_writer,
 	.read   = bfin_spi_u16_reader,
 	.duplex = bfin_spi_u16_duplex,
 };
 
 /* test if there is more transfer to be done */
-static void *bfin_spi_next_transfer(struct master_data *drv_data)
+static void *bfin_spi_next_transfer(struct bfin_spi_master_data *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
 	struct spi_transfer *trans = drv_data->cur_transfer;
@@ -384,9 +387,9 @@ static void *bfin_spi_next_transfer(struct master_data *drv_data)
  * caller already set message->status;
  * dma and pio irqs are blocked give finished message back
  */
-static void bfin_spi_giveback(struct master_data *drv_data)
+static void bfin_spi_giveback(struct bfin_spi_master_data *drv_data)
 {
-	struct slave_data *chip = drv_data->cur_chip;
+	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
 	struct spi_transfer *last_transfer;
 	unsigned long flags;
 	struct spi_message *msg;
@@ -418,8 +421,8 @@ static void bfin_spi_giveback(struct master_data *drv_data)
 /* spi data irq handler */
 static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 {
-	struct master_data *drv_data = dev_id;
-	struct slave_data *chip = drv_data->cur_chip;
+	struct bfin_spi_master_data *drv_data = dev_id;
+	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
 	int n_bytes = drv_data->n_bytes;
 
@@ -490,8 +493,8 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 
 static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 {
-	struct master_data *drv_data = dev_id;
-	struct slave_data *chip = drv_data->cur_chip;
+	struct bfin_spi_master_data *drv_data = dev_id;
+	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
 	unsigned long timeout;
 	unsigned short dmastat = get_dma_curr_irqstat(drv_data->dma_channel);
@@ -554,11 +557,11 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 
 static void bfin_spi_pump_transfers(unsigned long data)
 {
-	struct master_data *drv_data = (struct master_data *)data;
+	struct bfin_spi_master_data *drv_data = (struct bfin_spi_master_data *)data;
 	struct spi_message *message = NULL;
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
-	struct slave_data *chip = NULL;
+	struct bfin_spi_slave_data *chip = NULL;
 	unsigned int bits_per_word;
 	u16 cr, cr_width, dma_width, dma_config;
 	u32 tranf_success = 1;
@@ -643,12 +646,12 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		drv_data->n_bytes = 1;
 		drv_data->len = transfer->len;
 		cr_width = 0;
-		drv_data->ops = &bfin_transfer_ops_u8;
+		drv_data->ops = &bfin_bfin_spi_transfer_ops_u8;
 	} else if (bits_per_word == 16) {
 		drv_data->n_bytes = 2;
 		drv_data->len = (transfer->len) >> 1;
 		cr_width = BIT_CTL_WORDSIZE;
-		drv_data->ops = &bfin_transfer_ops_u16;
+		drv_data->ops = &bfin_bfin_spi_transfer_ops_u16;
 	} else {
 		dev_err(&drv_data->pdev->dev, "transfer: unsupported bits_per_word\n");
 		message->status = -EINVAL;
@@ -661,7 +664,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 
 	dev_dbg(&drv_data->pdev->dev,
 		"transfer: drv_data->ops is %p, chip->ops is %p, u8_ops is %p\n",
-		drv_data->ops, chip->ops, &bfin_transfer_ops_u8);
+		drv_data->ops, chip->ops, &bfin_bfin_spi_transfer_ops_u8);
 
 	message->state = RUNNING_STATE;
 	dma_config = 0;
@@ -868,10 +871,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
 /* pop a msg from queue and kick off real transfer */
 static void bfin_spi_pump_messages(struct work_struct *work)
 {
-	struct master_data *drv_data;
+	struct bfin_spi_master_data *drv_data;
 	unsigned long flags;
 
-	drv_data = container_of(work, struct master_data, pump_messages);
+	drv_data = container_of(work, struct bfin_spi_master_data, pump_messages);
 
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&drv_data->lock, flags);
@@ -925,7 +928,7 @@ static void bfin_spi_pump_messages(struct work_struct *work)
  */
 static int bfin_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 {
-	struct master_data *drv_data = spi_master_get_devdata(spi->master);
+	struct bfin_spi_master_data *drv_data = spi_master_get_devdata(spi->master);
 	unsigned long flags;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
@@ -970,8 +973,8 @@ static u16 ssel[][MAX_SPI_SSEL] = {
 static int bfin_spi_setup(struct spi_device *spi)
 {
 	struct bfin5xx_spi_chip *chip_info;
-	struct slave_data *chip = NULL;
-	struct master_data *drv_data = spi_master_get_devdata(spi->master);
+	struct bfin_spi_slave_data *chip = NULL;
+	struct bfin_spi_master_data *drv_data = spi_master_get_devdata(spi->master);
 	u16 bfin_ctl_reg;
 	int ret = -EINVAL;
 
@@ -1152,8 +1155,8 @@ static int bfin_spi_setup(struct spi_device *spi)
  */
 static void bfin_spi_cleanup(struct spi_device *spi)
 {
-	struct slave_data *chip = spi_get_ctldata(spi);
-	struct master_data *drv_data = spi_master_get_devdata(spi->master);
+	struct bfin_spi_slave_data *chip = spi_get_ctldata(spi);
+	struct bfin_spi_master_data *drv_data = spi_master_get_devdata(spi->master);
 
 	if (!chip)
 		return;
@@ -1170,7 +1173,7 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
-static inline int bfin_spi_init_queue(struct master_data *drv_data)
+static inline int bfin_spi_init_queue(struct bfin_spi_master_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1192,7 +1195,7 @@ static inline int bfin_spi_init_queue(struct master_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_start_queue(struct master_data *drv_data)
+static inline int bfin_spi_start_queue(struct bfin_spi_master_data *drv_data)
 {
 	unsigned long flags;
 
@@ -1214,7 +1217,7 @@ static inline int bfin_spi_start_queue(struct master_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_stop_queue(struct master_data *drv_data)
+static inline int bfin_spi_stop_queue(struct bfin_spi_master_data *drv_data)
 {
 	unsigned long flags;
 	unsigned limit = 500;
@@ -1243,7 +1246,7 @@ static inline int bfin_spi_stop_queue(struct master_data *drv_data)
 	return status;
 }
 
-static inline int bfin_spi_destroy_queue(struct master_data *drv_data)
+static inline int bfin_spi_destroy_queue(struct bfin_spi_master_data *drv_data)
 {
 	int status;
 
@@ -1261,7 +1264,7 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bfin5xx_spi_master *platform_info;
 	struct spi_master *master;
-	struct master_data *drv_data;
+	struct bfin_spi_master_data *drv_data;
 	struct resource *res;
 	int status = 0;
 
@@ -1371,7 +1374,7 @@ out_error_get_res:
 /* stop hardware and remove the driver */
 static int __devexit bfin_spi_remove(struct platform_device *pdev)
 {
-	struct master_data *drv_data = platform_get_drvdata(pdev);
+	struct bfin_spi_master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	if (!drv_data)
@@ -1410,7 +1413,7 @@ static int __devexit bfin_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct master_data *drv_data = platform_get_drvdata(pdev);
+	struct bfin_spi_master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	status = bfin_spi_stop_queue(drv_data);
@@ -1431,7 +1434,7 @@ static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int bfin_spi_resume(struct platform_device *pdev)
 {
-	struct master_data *drv_data = platform_get_drvdata(pdev);
+	struct bfin_spi_master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	write_CTRL(drv_data, drv_data->ctrl_reg);
-- 
1.7.3.1
