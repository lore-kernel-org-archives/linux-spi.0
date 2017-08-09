From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-ep93xx: remove io wrappers" to the spi tree
Date: Wed, 09 Aug 2017 17:57:23 +0100
Message-ID: <E1dfUIN-0005Zc-Om@debutante>
References: <20170216234851.97938-2-hsweeten@visionengravers.com>
Cc: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216234851.97938-2-hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-ep93xx: remove io wrappers

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

>From 1232978a0dff2d361c3d43cd74e46200c9933466 Mon Sep 17 00:00:00 2001
From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Date: Wed, 9 Aug 2017 08:51:25 +1200
Subject: [PATCH] spi: spi-ep93xx: remove io wrappers

The io wrappers just add obfuscation to the driver. Remove them.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 72 +++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index b5d766064b7b..49c42a6c2be1 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -72,7 +72,7 @@
  * struct ep93xx_spi - EP93xx SPI controller structure
  * @pdev: pointer to platform device
  * @clk: clock for the controller
- * @regs_base: pointer to ioremap()'d registers
+ * @mmio: pointer to ioremap()'d registers
  * @sspdr_phys: physical address of the SSPDR register
  * @wait: wait here until given transfer is completed
  * @current_msg: message that is currently processed (or %NULL if none)
@@ -92,7 +92,7 @@
 struct ep93xx_spi {
 	const struct platform_device	*pdev;
 	struct clk			*clk;
-	void __iomem			*regs_base;
+	void __iomem			*mmio;
 	unsigned long			sspdr_phys;
 	struct completion		wait;
 	struct spi_message		*current_msg;
@@ -111,28 +111,6 @@ struct ep93xx_spi {
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
-static void ep93xx_spi_write_u8(const struct ep93xx_spi *espi,
-				u16 reg, u8 value)
-{
-	writeb(value, espi->regs_base + reg);
-}
-
-static u8 ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
-{
-	return readb(spi->regs_base + reg);
-}
-
-static void ep93xx_spi_write_u16(const struct ep93xx_spi *espi,
-				 u16 reg, u16 value)
-{
-	writew(value, espi->regs_base + reg);
-}
-
-static u16 ep93xx_spi_read_u16(const struct ep93xx_spi *spi, u16 reg)
-{
-	return readw(spi->regs_base + reg);
-}
-
 static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
 {
 	u8 regval;
@@ -142,9 +120,9 @@ static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
 	if (err)
 		return err;
 
-	regval = ep93xx_spi_read_u8(espi, SSPCR1);
+	regval = readb(espi->mmio + SSPCR1);
 	regval |= SSPCR1_SSE;
-	ep93xx_spi_write_u8(espi, SSPCR1, regval);
+	writeb(regval, espi->mmio + SSPCR1);
 
 	return 0;
 }
@@ -153,9 +131,9 @@ static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
 {
 	u8 regval;
 
-	regval = ep93xx_spi_read_u8(espi, SSPCR1);
+	regval = readb(espi->mmio + SSPCR1);
 	regval &= ~SSPCR1_SSE;
-	ep93xx_spi_write_u8(espi, SSPCR1, regval);
+	writeb(regval, espi->mmio + SSPCR1);
 
 	clk_disable(espi->clk);
 }
@@ -164,18 +142,18 @@ static void ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
 {
 	u8 regval;
 
-	regval = ep93xx_spi_read_u8(espi, SSPCR1);
+	regval = readb(espi->mmio + SSPCR1);
 	regval |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	ep93xx_spi_write_u8(espi, SSPCR1, regval);
+	writeb(regval, espi->mmio + SSPCR1);
 }
 
 static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
 {
 	u8 regval;
 
-	regval = ep93xx_spi_read_u8(espi, SSPCR1);
+	regval = readb(espi->mmio + SSPCR1);
 	regval &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	ep93xx_spi_write_u8(espi, SSPCR1, regval);
+	writeb(regval, espi->mmio + SSPCR1);
 }
 
 /**
@@ -252,8 +230,8 @@ static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
 		spi->mode, div_cpsr, div_scr, dss);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x\n", cr0);
 
-	ep93xx_spi_write_u8(espi, SSPCPSR, div_cpsr);
-	ep93xx_spi_write_u16(espi, SSPCR0, cr0);
+	writeb(div_cpsr, espi->mmio + SSPCPSR);
+	writew(cr0, espi->mmio + SSPCR0);
 
 	return 0;
 }
@@ -265,14 +243,14 @@ static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
 
 		if (t->tx_buf)
 			tx_val = ((u16 *)t->tx_buf)[espi->tx];
-		ep93xx_spi_write_u16(espi, SSPDR, tx_val);
+		writew(tx_val, espi->mmio + SSPDR);
 		espi->tx += sizeof(tx_val);
 	} else {
 		u8 tx_val = 0;
 
 		if (t->tx_buf)
 			tx_val = ((u8 *)t->tx_buf)[espi->tx];
-		ep93xx_spi_write_u8(espi, SSPDR, tx_val);
+		writeb(tx_val, espi->mmio + SSPDR);
 		espi->tx += sizeof(tx_val);
 	}
 }
@@ -282,14 +260,14 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
 	if (t->bits_per_word > 8) {
 		u16 rx_val;
 
-		rx_val = ep93xx_spi_read_u16(espi, SSPDR);
+		rx_val = readw(espi->mmio + SSPDR);
 		if (t->rx_buf)
 			((u16 *)t->rx_buf)[espi->rx] = rx_val;
 		espi->rx += sizeof(rx_val);
 	} else {
 		u8 rx_val;
 
-		rx_val = ep93xx_spi_read_u8(espi, SSPDR);
+		rx_val = readb(espi->mmio + SSPDR);
 		if (t->rx_buf)
 			((u8 *)t->rx_buf)[espi->rx] = rx_val;
 		espi->rx += sizeof(rx_val);
@@ -313,7 +291,7 @@ static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
 	struct spi_transfer *t = msg->state;
 
 	/* read as long as RX FIFO has frames in it */
-	while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE)) {
+	while ((readb(espi->mmio + SSPSR) & SSPSR_RNE)) {
 		ep93xx_do_read(espi, t);
 		espi->fifo_level--;
 	}
@@ -615,14 +593,14 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	 * Just to be sure: flush any data from RX FIFO.
 	 */
 	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
-	while (ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_RNE) {
+	while (readw(espi->mmio + SSPSR) & SSPSR_RNE) {
 		if (time_after(jiffies, timeout)) {
 			dev_warn(&espi->pdev->dev,
 				 "timeout while flushing RX FIFO\n");
 			msg->status = -ETIMEDOUT;
 			return;
 		}
-		ep93xx_spi_read_u16(espi, SSPDR);
+		readw(espi->mmio + SSPDR);
 	}
 
 	/*
@@ -671,7 +649,7 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 {
 	struct ep93xx_spi *espi = dev_id;
-	u8 irq_status = ep93xx_spi_read_u8(espi, SSPIIR);
+	u8 irq_status = readb(espi->mmio + SSPIIR);
 
 	/*
 	 * If we got ROR (receive overrun) interrupt we know that something is
@@ -679,7 +657,7 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	 */
 	if (unlikely(irq_status & SSPIIR_RORIS)) {
 		/* clear the overrun interrupt */
-		ep93xx_spi_write_u8(espi, SSPICR, 0);
+		writeb(0, espi->mmio + SSPICR);
 		dev_warn(&espi->pdev->dev,
 			 "receive overrun, aborting the message\n");
 		espi->current_msg->status = -EIO;
@@ -862,9 +840,9 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	espi->sspdr_phys = res->start + SSPDR;
 
-	espi->regs_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(espi->regs_base)) {
-		error = PTR_ERR(espi->regs_base);
+	espi->mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(espi->mmio)) {
+		error = PTR_ERR(espi->mmio);
 		goto fail_release_master;
 	}
 
@@ -879,7 +857,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "DMA setup failed. Falling back to PIO\n");
 
 	/* make sure that the hardware is disabled */
-	ep93xx_spi_write_u8(espi, SSPCR1, 0);
+	writeb(0, espi->mmio + SSPCR1);
 
 	error = devm_spi_register_master(&pdev->dev, master);
 	if (error) {
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
