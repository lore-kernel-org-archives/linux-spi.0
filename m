From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 5/5] spi: img-spfi: Control CS lines with GPIO
Date: Mon,  6 Apr 2015 14:29:07 -0700
Message-ID: <1428355747-16822-5-git-send-email-abrestic@chromium.org>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Sifan Naeem <sifan.naeem@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

When the CONTINUE bit is set, the interrupt status we are polling to
identify if a transaction has finished can be sporadic.  Even though
the transfer has finished, the interrupt status may erroneously
indicate that there is still data in the FIFO.  This behaviour causes
random timeouts in large PIO transfers.

Instead of using the CONTINUE bit to control the CS lines, use the SPI
core's CS GPIO handling.  Also, now that the CONTINUE bit is not being
used, we can poll for the ALLDONE interrupt to indicate transfer
completion.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
This breaks device-tree backwards compatibility, but all existing
device-trees using this binding have been updated.
---
 .../devicetree/bindings/spi/spi-img-spfi.txt       |  1 +
 drivers/spi/spi-img-spfi.c                         | 92 +++++++++++-----------
 2 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-img-spfi.txt b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
index c7dd50f..e02fbf1 100644
--- a/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-img-spfi.txt
@@ -14,6 +14,7 @@ Required properties:
 - dma-names: Must include the following entries:
   - rx
   - tx
+- cs-gpios: Must specify the GPIOs used for chipselect lines.
 - #address-cells: Must be 1.
 - #size-cells: Must be 0.
 
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index adeaa2f..a834ca8 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -122,15 +123,6 @@ static inline void spfi_start(struct img_spfi *spfi)
 	spfi_writel(spfi, val, SPFI_CONTROL);
 }
 
-static inline void spfi_stop(struct img_spfi *spfi)
-{
-	u32 val;
-
-	val = spfi_readl(spfi, SPFI_CONTROL);
-	val &= ~SPFI_CONTROL_SPFI_EN;
-	spfi_writel(spfi, val, SPFI_CONTROL);
-}
-
 static inline void spfi_reset(struct img_spfi *spfi)
 {
 	spfi_writel(spfi, SPFI_CONTROL_SOFT_RESET, SPFI_CONTROL);
@@ -138,20 +130,25 @@ static inline void spfi_reset(struct img_spfi *spfi)
 	spfi_writel(spfi, 0, SPFI_CONTROL);
 }
 
-static void spfi_flush_tx_fifo(struct img_spfi *spfi)
+static int spfi_wait_all_done(struct img_spfi *spfi)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
 
-	spfi_writel(spfi, SPFI_INTERRUPT_SDE, SPFI_INTERRUPT_CLEAR);
 	while (time_before(jiffies, timeout)) {
-		if (spfi_readl(spfi, SPFI_INTERRUPT_STATUS) &
-		    SPFI_INTERRUPT_SDE)
-			return;
+		u32 status = spfi_readl(spfi, SPFI_INTERRUPT_STATUS);
+
+		if (status & SPFI_INTERRUPT_ALLDONETRIG) {
+			spfi_writel(spfi, SPFI_INTERRUPT_ALLDONETRIG,
+				    SPFI_INTERRUPT_CLEAR);
+			return 0;
+		}
 		cpu_relax();
 	}
 
-	dev_err(spfi->dev, "Timed out waiting for FIFO to drain\n");
+	dev_err(spfi->dev, "Timed out waiting for transaction to complete\n");
 	spfi_reset(spfi);
+
+	return -ETIMEDOUT;
 }
 
 static unsigned int spfi_pio_write32(struct img_spfi *spfi, const u32 *buf,
@@ -237,6 +234,7 @@ static int img_spfi_start_pio(struct spi_master *master,
 	const void *tx_buf = xfer->tx_buf;
 	void *rx_buf = xfer->rx_buf;
 	unsigned long timeout;
+	int ret;
 
 	if (tx_buf)
 		tx_bytes = xfer->len;
@@ -269,15 +267,15 @@ static int img_spfi_start_pio(struct spi_master *master,
 		cpu_relax();
 	}
 
+	ret = spfi_wait_all_done(spfi);
+	if (ret < 0)
+		return ret;
+
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
 		return -ETIMEDOUT;
 	}
 
-	if (tx_buf)
-		spfi_flush_tx_fifo(spfi);
-	spfi_stop(spfi);
-
 	return 0;
 }
 
@@ -286,14 +284,12 @@ static void img_spfi_dma_rx_cb(void *data)
 	struct img_spfi *spfi = data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&spfi->lock, flags);
+	spfi_wait_all_done(spfi);
 
+	spin_lock_irqsave(&spfi->lock, flags);
 	spfi->rx_dma_busy = false;
-	if (!spfi->tx_dma_busy) {
-		spfi_stop(spfi);
+	if (!spfi->tx_dma_busy)
 		spi_finalize_current_transfer(spfi->master);
-	}
-
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
@@ -302,16 +298,12 @@ static void img_spfi_dma_tx_cb(void *data)
 	struct img_spfi *spfi = data;
 	unsigned long flags;
 
-	spfi_flush_tx_fifo(spfi);
+	spfi_wait_all_done(spfi);
 
 	spin_lock_irqsave(&spfi->lock, flags);
-
 	spfi->tx_dma_busy = false;
-	if (!spfi->rx_dma_busy) {
-		spfi_stop(spfi);
+	if (!spfi->rx_dma_busy)
 		spi_finalize_current_transfer(spfi->master);
-	}
-
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
@@ -439,6 +431,25 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
+static int img_spfi_setup(struct spi_device *spi)
+{
+	int ret;
+
+	ret = gpio_request_one(spi->cs_gpio, (spi->mode & SPI_CS_HIGH) ?
+			       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+			       dev_name(&spi->dev));
+	if (ret)
+		dev_err(&spi->dev, "can't request chipselect gpio %d\n",
+				spi->cs_gpio);
+
+	return ret;
+}
+
+static void img_spfi_cleanup(struct spi_device *spi)
+{
+	gpio_free(spi->cs_gpio);
+}
+
 static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
@@ -474,10 +485,6 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	else if (xfer->tx_nbits == SPI_NBITS_QUAD &&
 		 xfer->rx_nbits == SPI_NBITS_QUAD)
 		val |= SPFI_CONTROL_TMODE_QUAD << SPFI_CONTROL_TMODE_SHIFT;
-	val &= ~SPFI_CONTROL_CONTINUE;
-	if (!xfer->cs_change && !list_is_last(&xfer->transfer_list,
-					      &master->cur_msg->transfers))
-		val |= SPFI_CONTROL_CONTINUE;
 	spfi_writel(spfi, val, SPFI_CONTROL);
 }
 
@@ -504,17 +511,6 @@ static int img_spfi_transfer_one(struct spi_master *master,
 	return ret;
 }
 
-static void img_spfi_set_cs(struct spi_device *spi, bool enable)
-{
-	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
-	u32 val;
-
-	val = spfi_readl(spfi, SPFI_PORT_STATE);
-	val &= ~(SPFI_PORT_STATE_DEV_SEL_MASK << SPFI_PORT_STATE_DEV_SEL_SHIFT);
-	val |= spi->chip_select << SPFI_PORT_STATE_DEV_SEL_SHIFT;
-	spfi_writel(spfi, val, SPFI_PORT_STATE);
-}
-
 static bool img_spfi_can_dma(struct spi_master *master, struct spi_device *spi,
 			     struct spi_transfer *xfer)
 {
@@ -603,13 +599,13 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL;
 	if (of_property_read_bool(spfi->dev->of_node, "img,supports-quad-mode"))
 		master->mode_bits |= SPI_TX_QUAD | SPI_RX_QUAD;
-	master->num_chipselect = 5;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(8);
 	master->max_speed_hz = clk_get_rate(spfi->spfi_clk) / 4;
 	master->min_speed_hz = clk_get_rate(spfi->spfi_clk) / 512;
 
-	master->set_cs = img_spfi_set_cs;
+	master->setup = img_spfi_setup;
+	master->cleanup = img_spfi_cleanup;
 	master->transfer_one = img_spfi_transfer_one;
 	master->prepare_message = img_spfi_prepare;
 	master->unprepare_message = img_spfi_unprepare;
-- 
2.2.0.rc0.207.ga3a616c
