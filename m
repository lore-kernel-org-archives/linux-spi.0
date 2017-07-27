From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [RFC PATCH v2 02/12] spi: spi-ep93xx: add spi master prepare_transfer_hardware()
Date: Fri, 28 Jul 2017 10:03:12 +1200
Message-ID: <20170727220322.26654-3-chris.packham@alliedtelesis.co.nz>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

This driver currently enables the hardware at the start of every
message and disabled it when the message is complete. Make it a
bit smarter by adding the prepare_transfer_hardware() and
unprepare_transfer_hardware() callbacks so that the core can
enable/disable the hardware based on spi message queue.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 72 ++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index bc1db022d353..dd179f3fbeeb 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -111,33 +111,6 @@ struct ep93xx_spi {
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
-static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
-{
-	unsigned int val;
-	int err;
-
-	err = clk_enable(espi->clk);
-	if (err)
-		return err;
-
-	val = readl(espi->mmio + SSPCR1);
-	val |= SSPCR1_SSE;
-	writel(val, espi->mmio + SSPCR1);
-
-	return 0;
-}
-
-static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
-{
-	unsigned int val;
-
-	val = readl(espi->mmio + SSPCR1);
-	val &= ~SSPCR1_SSE;
-	writel(val, espi->mmio + SSPCR1);
-
-	clk_disable(espi->clk);
-}
-
 static void ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
 {
 	unsigned int val;
@@ -571,17 +544,6 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 {
 	unsigned long timeout;
 	struct spi_transfer *t;
-	int err;
-
-	/*
-	 * Enable the SPI controller and its clock.
-	 */
-	err = ep93xx_spi_enable(espi);
-	if (err) {
-		dev_err(&espi->pdev->dev, "failed to enable SPI controller\n");
-		msg->status = err;
-		return;
-	}
 
 	/*
 	 * Just to be sure: flush any data from RX FIFO.
@@ -619,7 +581,6 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	 * deselect the device and disable the SPI controller.
 	 */
 	ep93xx_spi_cs_control(msg->spi, false);
-	ep93xx_spi_disable(espi);
 }
 
 static int ep93xx_spi_transfer_one_message(struct spi_master *master,
@@ -679,6 +640,37 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int ep93xx_spi_prepare_hardware(struct spi_master *master)
+{
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	unsigned int val;
+	int ret;
+
+	ret = clk_enable(espi->clk);
+	if (ret)
+		return ret;
+
+	val = readl(espi->mmio + SSPCR1);
+	val |= SSPCR1_SSE;
+	writel(val, espi->mmio + SSPCR1);
+
+	return 0;
+}
+
+static int ep93xx_spi_unprepare_hardware(struct spi_master *master)
+{
+	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	unsigned int val;
+
+	val = readl(espi->mmio + SSPCR1);
+	val &= ~SSPCR1_SSE;
+	writel(val, espi->mmio + SSPCR1);
+
+	clk_disable(espi->clk);
+
+	return 0;
+}
+
 static bool ep93xx_spi_dma_filter(struct dma_chan *chan, void *filter_param)
 {
 	if (ep93xx_dma_chan_is_m2p(chan))
@@ -780,6 +772,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	master->prepare_transfer_hardware = ep93xx_spi_prepare_hardware;
+	master->unprepare_transfer_hardware = ep93xx_spi_unprepare_hardware;
 	master->transfer_one_message = ep93xx_spi_transfer_one_message;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
