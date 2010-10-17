From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/28] Blackfin SPI: convert struct
	names to something more logical
Date: Sun, 17 Oct 2010 18:59:24 -0400
Message-ID: <1287356381-31495-12-git-send-email-vapier@gentoo.org>
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

The current structure names are a bit confusing as to what they represent,
so use better names.

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |  100 ++++++++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index b0de61a..9a1801b 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -42,15 +42,15 @@ MODULE_LICENSE("GPL");
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
 
-struct driver_data;
+struct master_data;
 
 struct transfer_ops {
-	void (*write) (struct driver_data *);
-	void (*read) (struct driver_data *);
-	void (*duplex) (struct driver_data *);
+	void (*write) (struct master_data *);
+	void (*read) (struct master_data *);
+	void (*duplex) (struct master_data *);
 };
 
-struct driver_data {
+struct master_data {
 	/* Driver model hookup */
 	struct platform_device *pdev;
 
@@ -80,7 +80,7 @@ struct driver_data {
 	/* Current message transfer state info */
 	struct spi_message *cur_msg;
 	struct spi_transfer *cur_transfer;
-	struct chip_data *cur_chip;
+	struct slave_data *cur_chip;
 	size_t len_in_bytes;
 	size_t len;
 	void *tx;
@@ -105,7 +105,7 @@ struct driver_data {
 	const struct transfer_ops *ops;
 };
 
-struct chip_data {
+struct slave_data {
 	u16 ctl_reg;
 	u16 baud;
 	u16 flag;
@@ -123,9 +123,9 @@ struct chip_data {
 };
 
 #define DEFINE_SPI_REG(reg, off) \
-static inline u16 read_##reg(struct driver_data *drv_data) \
+static inline u16 read_##reg(struct master_data *drv_data) \
 	{ return bfin_read16(drv_data->regs_base + off); } \
-static inline void write_##reg(struct driver_data *drv_data, u16 v) \
+static inline void write_##reg(struct master_data *drv_data, u16 v) \
 	{ bfin_write16(drv_data->regs_base + off, v); }
 
 DEFINE_SPI_REG(CTRL, 0x00)
@@ -136,7 +136,7 @@ DEFINE_SPI_REG(RDBR, 0x10)
 DEFINE_SPI_REG(BAUD, 0x14)
 DEFINE_SPI_REG(SHAW, 0x18)
 
-static void bfin_spi_enable(struct driver_data *drv_data)
+static void bfin_spi_enable(struct master_data *drv_data)
 {
 	u16 cr;
 
@@ -144,7 +144,7 @@ static void bfin_spi_enable(struct driver_data *drv_data)
 	write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
 }
 
-static void bfin_spi_disable(struct driver_data *drv_data)
+static void bfin_spi_disable(struct master_data *drv_data)
 {
 	u16 cr;
 
@@ -167,7 +167,7 @@ static u16 hz_to_spi_baud(u32 speed_hz)
 	return spi_baud;
 }
 
-static int bfin_spi_flush(struct driver_data *drv_data)
+static int bfin_spi_flush(struct master_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
@@ -181,7 +181,7 @@ static int bfin_spi_flush(struct driver_data *drv_data)
 }
 
 /* Chip select operation functions for cs_change flag */
-static void bfin_spi_cs_active(struct driver_data *drv_data, struct chip_data *chip)
+static void bfin_spi_cs_active(struct master_data *drv_data, struct slave_data *chip)
 {
 	if (likely(chip->chip_select_num)) {
 		u16 flag = read_FLAG(drv_data);
@@ -194,7 +194,7 @@ static void bfin_spi_cs_active(struct driver_data *drv_data, struct chip_data *c
 	}
 }
 
-static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
+static void bfin_spi_cs_deactive(struct master_data *drv_data, struct slave_data *chip)
 {
 	if (likely(chip->chip_select_num)) {
 		u16 flag = read_FLAG(drv_data);
@@ -212,7 +212,7 @@ static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct chip_data
 }
 
 /* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
-static inline void bfin_spi_cs_enable(struct driver_data *drv_data, struct chip_data *chip)
+static inline void bfin_spi_cs_enable(struct master_data *drv_data, struct slave_data *chip)
 {
 	u16 flag = read_FLAG(drv_data);
 
@@ -221,7 +221,7 @@ static inline void bfin_spi_cs_enable(struct driver_data *drv_data, struct chip_
 	write_FLAG(drv_data, flag);
 }
 
-static inline void bfin_spi_cs_disable(struct driver_data *drv_data, struct chip_data *chip)
+static inline void bfin_spi_cs_disable(struct master_data *drv_data, struct slave_data *chip)
 {
 	u16 flag = read_FLAG(drv_data);
 
@@ -231,9 +231,9 @@ static inline void bfin_spi_cs_disable(struct driver_data *drv_data, struct chip
 }
 
 /* stop controller and re-config current chip*/
-static void bfin_spi_restore_state(struct driver_data *drv_data)
+static void bfin_spi_restore_state(struct master_data *drv_data)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct slave_data *chip = drv_data->cur_chip;
 
 	/* Clear status and disable clock */
 	write_STAT(drv_data, BIT_STAT_CLR);
@@ -249,12 +249,12 @@ static void bfin_spi_restore_state(struct driver_data *drv_data)
 }
 
 /* used to kick off transfer in rx mode and read unwanted RX data */
-static inline void bfin_spi_dummy_read(struct driver_data *drv_data)
+static inline void bfin_spi_dummy_read(struct master_data *drv_data)
 {
 	(void) read_RDBR(drv_data);
 }
 
-static void bfin_spi_u8_writer(struct driver_data *drv_data)
+static void bfin_spi_u8_writer(struct master_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
 	bfin_spi_dummy_read(drv_data);
@@ -270,7 +270,7 @@ static void bfin_spi_u8_writer(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_reader(struct driver_data *drv_data)
+static void bfin_spi_u8_reader(struct master_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
 
@@ -285,7 +285,7 @@ static void bfin_spi_u8_reader(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_duplex(struct driver_data *drv_data)
+static void bfin_spi_u8_duplex(struct master_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
 	bfin_spi_dummy_read(drv_data);
@@ -304,7 +304,7 @@ static const struct transfer_ops bfin_transfer_ops_u8 = {
 	.duplex = bfin_spi_u8_duplex,
 };
 
-static void bfin_spi_u16_writer(struct driver_data *drv_data)
+static void bfin_spi_u16_writer(struct master_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
 	bfin_spi_dummy_read(drv_data);
@@ -321,7 +321,7 @@ static void bfin_spi_u16_writer(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_reader(struct driver_data *drv_data)
+static void bfin_spi_u16_reader(struct master_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
 
@@ -337,7 +337,7 @@ static void bfin_spi_u16_reader(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_duplex(struct driver_data *drv_data)
+static void bfin_spi_u16_duplex(struct master_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
 	bfin_spi_dummy_read(drv_data);
@@ -359,7 +359,7 @@ static const struct transfer_ops bfin_transfer_ops_u16 = {
 };
 
 /* test if ther is more transfer to be done */
-static void *bfin_spi_next_transfer(struct driver_data *drv_data)
+static void *bfin_spi_next_transfer(struct master_data *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
 	struct spi_transfer *trans = drv_data->cur_transfer;
@@ -378,9 +378,9 @@ static void *bfin_spi_next_transfer(struct driver_data *drv_data)
  * caller already set message->status;
  * dma and pio irqs are blocked give finished message back
  */
-static void bfin_spi_giveback(struct driver_data *drv_data)
+static void bfin_spi_giveback(struct master_data *drv_data)
 {
-	struct chip_data *chip = drv_data->cur_chip;
+	struct slave_data *chip = drv_data->cur_chip;
 	struct spi_transfer *last_transfer;
 	unsigned long flags;
 	struct spi_message *msg;
@@ -412,8 +412,8 @@ static void bfin_spi_giveback(struct driver_data *drv_data)
 /* spi data irq handler */
 static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 {
-	struct driver_data *drv_data = dev_id;
-	struct chip_data *chip = drv_data->cur_chip;
+	struct master_data *drv_data = dev_id;
+	struct slave_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
 	int n_bytes = drv_data->n_bytes;
 
@@ -484,8 +484,8 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
 
 static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 {
-	struct driver_data *drv_data = dev_id;
-	struct chip_data *chip = drv_data->cur_chip;
+	struct master_data *drv_data = dev_id;
+	struct slave_data *chip = drv_data->cur_chip;
 	struct spi_message *msg = drv_data->cur_msg;
 	unsigned long timeout;
 	unsigned short dmastat = get_dma_curr_irqstat(drv_data->dma_channel);
@@ -548,11 +548,11 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 
 static void bfin_spi_pump_transfers(unsigned long data)
 {
-	struct driver_data *drv_data = (struct driver_data *)data;
+	struct master_data *drv_data = (struct master_data *)data;
 	struct spi_message *message = NULL;
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
-	struct chip_data *chip = NULL;
+	struct slave_data *chip = NULL;
 	u8 width;
 	u16 cr, dma_width, dma_config;
 	u32 tranf_success = 1;
@@ -872,10 +872,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
 /* pop a msg from queue and kick off real transfer */
 static void bfin_spi_pump_messages(struct work_struct *work)
 {
-	struct driver_data *drv_data;
+	struct master_data *drv_data;
 	unsigned long flags;
 
-	drv_data = container_of(work, struct driver_data, pump_messages);
+	drv_data = container_of(work, struct master_data, pump_messages);
 
 	/* Lock queue and check for queue work */
 	spin_lock_irqsave(&drv_data->lock, flags);
@@ -929,7 +929,7 @@ static void bfin_spi_pump_messages(struct work_struct *work)
  */
 static int bfin_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 {
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct master_data *drv_data = spi_master_get_devdata(spi->master);
 	unsigned long flags;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
@@ -974,8 +974,8 @@ static u16 ssel[][MAX_SPI_SSEL] = {
 static int bfin_spi_setup(struct spi_device *spi)
 {
 	struct bfin5xx_spi_chip *chip_info;
-	struct chip_data *chip = NULL;
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct slave_data *chip = NULL;
+	struct master_data *drv_data = spi_master_get_devdata(spi->master);
 	int ret = -EINVAL;
 
 	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
@@ -1155,8 +1155,8 @@ static int bfin_spi_setup(struct spi_device *spi)
  */
 static void bfin_spi_cleanup(struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	struct slave_data *chip = spi_get_ctldata(spi);
+	struct master_data *drv_data = spi_master_get_devdata(spi->master);
 
 	if (!chip)
 		return;
@@ -1176,7 +1176,7 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
-static inline int bfin_spi_init_queue(struct driver_data *drv_data)
+static inline int bfin_spi_init_queue(struct master_data *drv_data)
 {
 	INIT_LIST_HEAD(&drv_data->queue);
 	spin_lock_init(&drv_data->lock);
@@ -1198,7 +1198,7 @@ static inline int bfin_spi_init_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_start_queue(struct driver_data *drv_data)
+static inline int bfin_spi_start_queue(struct master_data *drv_data)
 {
 	unsigned long flags;
 
@@ -1220,7 +1220,7 @@ static inline int bfin_spi_start_queue(struct driver_data *drv_data)
 	return 0;
 }
 
-static inline int bfin_spi_stop_queue(struct driver_data *drv_data)
+static inline int bfin_spi_stop_queue(struct master_data *drv_data)
 {
 	unsigned long flags;
 	unsigned limit = 500;
@@ -1249,7 +1249,7 @@ static inline int bfin_spi_stop_queue(struct driver_data *drv_data)
 	return status;
 }
 
-static inline int bfin_spi_destroy_queue(struct driver_data *drv_data)
+static inline int bfin_spi_destroy_queue(struct master_data *drv_data)
 {
 	int status;
 
@@ -1267,14 +1267,14 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bfin5xx_spi_master *platform_info;
 	struct spi_master *master;
-	struct driver_data *drv_data = 0;
+	struct master_data *drv_data = 0;
 	struct resource *res;
 	int status = 0;
 
 	platform_info = dev->platform_data;
 
 	/* Allocate master with space for drv_data */
-	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
+	master = spi_alloc_master(dev, sizeof(struct master_data) + 16);
 	if (!master) {
 		dev_err(&pdev->dev, "can not alloc spi_master\n");
 		return -ENOMEM;
@@ -1377,7 +1377,7 @@ out_error_get_res:
 /* stop hardware and remove the driver */
 static int __devexit bfin_spi_remove(struct platform_device *pdev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	if (!drv_data)
@@ -1416,7 +1416,7 @@ static int __devexit bfin_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	status = bfin_spi_stop_queue(drv_data);
@@ -1431,7 +1431,7 @@ static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int bfin_spi_resume(struct platform_device *pdev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
+	struct master_data *drv_data = platform_get_drvdata(pdev);
 	int status = 0;
 
 	/* Enable the SPI interface */
-- 
1.7.3.1
