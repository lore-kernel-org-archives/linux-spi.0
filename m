From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH v2 2/7] spi: spi-ep93xx: use 32-bit read/write for all registers
Date: Fri,  4 Aug 2017 12:00:18 +1200
Message-ID: <20170804000023.15624-3-chris.packham@alliedtelesis.co.nz>
References: <20170804000023.15624-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170804000023.15624-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

All the EP93xx SSP registers are 32-bit. Since most of the upper bits
are unused, this driver tries to be tricky and uses 8 or 16-bit I/O to
access the registers. This really just adds a bit of confusion.

Simplify the I/O by using 32-bit read/write's for all of the registers.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
[chris: use u32 instead of unsigned int]
Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 83 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 49c42a6c2be1..0bd792020471 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -113,47 +113,47 @@ struct ep93xx_spi {
 
 static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
 {
-	u8 regval;
+	u32 val;
 	int err;
 
 	err = clk_enable(espi->clk);
 	if (err)
 		return err;
 
-	regval = readb(espi->mmio + SSPCR1);
-	regval |= SSPCR1_SSE;
-	writeb(regval, espi->mmio + SSPCR1);
+	val = readl(espi->mmio + SSPCR1);
+	val |= SSPCR1_SSE;
+	writel(val, espi->mmio + SSPCR1);
 
 	return 0;
 }
 
 static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
 {
-	u8 regval;
+	u32 val;
 
-	regval = readb(espi->mmio + SSPCR1);
-	regval &= ~SSPCR1_SSE;
-	writeb(regval, espi->mmio + SSPCR1);
+	val = readl(espi->mmio + SSPCR1);
+	val &= ~SSPCR1_SSE;
+	writel(val, espi->mmio + SSPCR1);
 
 	clk_disable(espi->clk);
 }
 
 static void ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
 {
-	u8 regval;
+	u32 val;
 
-	regval = readb(espi->mmio + SSPCR1);
-	regval |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	writeb(regval, espi->mmio + SSPCR1);
+	val = readl(espi->mmio + SSPCR1);
+	val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
+	writel(val, espi->mmio + SSPCR1);
 }
 
 static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
 {
-	u8 regval;
+	u32 val;
 
-	regval = readb(espi->mmio + SSPCR1);
-	regval &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	writeb(regval, espi->mmio + SSPCR1);
+	val = readl(espi->mmio + SSPCR1);
+	val &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
+	writel(val, espi->mmio + SSPCR1);
 }
 
 /**
@@ -230,47 +230,41 @@ static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
 		spi->mode, div_cpsr, div_scr, dss);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x\n", cr0);
 
-	writeb(div_cpsr, espi->mmio + SSPCPSR);
-	writew(cr0, espi->mmio + SSPCR0);
+	writel(div_cpsr, espi->mmio + SSPCPSR);
+	writel(cr0, espi->mmio + SSPCR0);
 
 	return 0;
 }
 
 static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
 {
-	if (t->bits_per_word > 8) {
-		u16 tx_val = 0;
+	u32 val = 0;
 
+	if (t->bits_per_word > 8) {
 		if (t->tx_buf)
-			tx_val = ((u16 *)t->tx_buf)[espi->tx];
-		writew(tx_val, espi->mmio + SSPDR);
-		espi->tx += sizeof(tx_val);
+			val = ((u16 *)t->tx_buf)[espi->tx];
+		espi->tx += 2;
 	} else {
-		u8 tx_val = 0;
-
 		if (t->tx_buf)
-			tx_val = ((u8 *)t->tx_buf)[espi->tx];
-		writeb(tx_val, espi->mmio + SSPDR);
-		espi->tx += sizeof(tx_val);
+			val = ((u8 *)t->tx_buf)[espi->tx];
+		espi->tx += 1;
 	}
+	writel(val, espi->mmio + SSPDR);
 }
 
 static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
 {
-	if (t->bits_per_word > 8) {
-		u16 rx_val;
+	u32 val;
 
-		rx_val = readw(espi->mmio + SSPDR);
+	val = readl(espi->mmio + SSPDR);
+	if (t->bits_per_word > 8) {
 		if (t->rx_buf)
-			((u16 *)t->rx_buf)[espi->rx] = rx_val;
-		espi->rx += sizeof(rx_val);
+			((u16 *)t->rx_buf)[espi->rx] = val;
+		espi->rx += 2;
 	} else {
-		u8 rx_val;
-
-		rx_val = readb(espi->mmio + SSPDR);
 		if (t->rx_buf)
-			((u8 *)t->rx_buf)[espi->rx] = rx_val;
-		espi->rx += sizeof(rx_val);
+			((u8 *)t->rx_buf)[espi->rx] = val;
+		espi->rx += 1;
 	}
 }
 
@@ -291,7 +285,7 @@ static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
 	struct spi_transfer *t = msg->state;
 
 	/* read as long as RX FIFO has frames in it */
-	while ((readb(espi->mmio + SSPSR) & SSPSR_RNE)) {
+	while ((readl(espi->mmio + SSPSR) & SSPSR_RNE)) {
 		ep93xx_do_read(espi, t);
 		espi->fifo_level--;
 	}
@@ -593,14 +587,14 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	 * Just to be sure: flush any data from RX FIFO.
 	 */
 	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
-	while (readw(espi->mmio + SSPSR) & SSPSR_RNE) {
+	while (readl(espi->mmio + SSPSR) & SSPSR_RNE) {
 		if (time_after(jiffies, timeout)) {
 			dev_warn(&espi->pdev->dev,
 				 "timeout while flushing RX FIFO\n");
 			msg->status = -ETIMEDOUT;
 			return;
 		}
-		readw(espi->mmio + SSPDR);
+		readl(espi->mmio + SSPDR);
 	}
 
 	/*
@@ -649,15 +643,14 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 {
 	struct ep93xx_spi *espi = dev_id;
-	u8 irq_status = readb(espi->mmio + SSPIIR);
 
 	/*
 	 * If we got ROR (receive overrun) interrupt we know that something is
 	 * wrong. Just abort the message.
 	 */
-	if (unlikely(irq_status & SSPIIR_RORIS)) {
+	if (readl(espi->mmio + SSPIIR) & SSPIIR_RORIS) {
 		/* clear the overrun interrupt */
-		writeb(0, espi->mmio + SSPICR);
+		writel(0, espi->mmio + SSPICR);
 		dev_warn(&espi->pdev->dev,
 			 "receive overrun, aborting the message\n");
 		espi->current_msg->status = -EIO;
@@ -857,7 +850,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "DMA setup failed. Falling back to PIO\n");
 
 	/* make sure that the hardware is disabled */
-	writeb(0, espi->mmio + SSPCR1);
+	writel(0, espi->mmio + SSPCR1);
 
 	error = devm_spi_register_master(&pdev->dev, master);
 	if (error) {
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
