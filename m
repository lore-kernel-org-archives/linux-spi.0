From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-ep93xx: add spi master prepare_transfer_hardware()" to the spi tree
Date: Wed, 09 Aug 2017 17:57:16 +0100
Message-ID: <E1dfUIG-0005XH-Ow@debutante>
References: <20170804000023.15624-4-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, hsweeten@visionengravers.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804000023.15624-4-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-ep93xx: add spi master prepare_transfer_hardware()

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

>From 16779622be1c8959d6a665e2b6886bb33885fcb1 Mon Sep 17 00:00:00 2001
From: H Hartley Sweeten <hsweeten@visionengravers.com>
Date: Wed, 9 Aug 2017 08:51:27 +1200
Subject: [PATCH] spi: spi-ep93xx: add spi master prepare_transfer_hardware()

This driver currently enables the hardware at the start of every
message and disabled it when the message is complete. Make it a
bit smarter by adding the prepare_transfer_hardware() and
unprepare_transfer_hardware() callbacks so that the core can
enable/disable the hardware based on spi message queue.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
[chris: use u32 instead of unsigned int]
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 72 ++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 0bd792020471..ce6ec164f2f2 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -111,33 +111,6 @@ struct ep93xx_spi {
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
-static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
-{
-	u32 val;
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
-	u32 val;
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
 	u32 val;
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
+	u32 val;
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
+	u32 val;
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
2.13.3
