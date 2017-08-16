From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] spi: altera: Switch to SPI core transfer queue management
Date: Wed, 16 Aug 2017 11:33:11 +0200
Message-ID: <20170816093312.23048-1-lars@metafoo.de>
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Altera SPI driver currently uses the spi-bitbang infrastructure for
transfer queue management, but non of the bitbang functionality itself.
This is because when the driver was written this was the only way to not
have to do queue management in the driver itself.

Nowadays transfer queue management is available from the SPI driver core
itself and using the bitbang infrastructure just adds an additional level
of indirection.

Switch the driver over to using the core queue management directly.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/Kconfig      |  1 -
 drivers/spi/spi-altera.c | 94 ++++++++++++++----------------------------------
 2 files changed, 27 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f9f9b0940746..a75f2a2cf780 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -55,7 +55,6 @@ comment "SPI Master Controller Drivers"
 
 config SPI_ALTERA
 	tristate "Altera SPI Controller"
-	select SPI_BITBANG
 	help
 	  This is the driver for the Altera SPI Controller.
 
diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index b95010e72452..bfac34068999 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>
 #include <linux/of.h>
 
@@ -45,10 +44,6 @@
 #define ALTERA_SPI_CONTROL_SSO_MSK	0x400
 
 struct altera_spi {
-	/* bitbang has to be first */
-	struct spi_bitbang bitbang;
-	struct completion done;
-
 	void __iomem *base;
 	int irq;
 	int len;
@@ -66,39 +61,18 @@ static inline struct altera_spi *altera_spi_to_hw(struct spi_device *sdev)
 	return spi_master_get_devdata(sdev->master);
 }
 
-static void altera_spi_chipsel(struct spi_device *spi, int value)
+static void altera_spi_set_cs(struct spi_device *spi, bool is_high)
 {
 	struct altera_spi *hw = altera_spi_to_hw(spi);
 
-	if (spi->mode & SPI_CS_HIGH) {
-		switch (value) {
-		case BITBANG_CS_INACTIVE:
-			writel(1 << spi->chip_select,
-			       hw->base + ALTERA_SPI_SLAVE_SEL);
-			hw->imr |= ALTERA_SPI_CONTROL_SSO_MSK;
-			writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-			break;
-
-		case BITBANG_CS_ACTIVE:
-			hw->imr &= ~ALTERA_SPI_CONTROL_SSO_MSK;
-			writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-			writel(0, hw->base + ALTERA_SPI_SLAVE_SEL);
-			break;
-		}
+	if (is_high) {
+		hw->imr &= ~ALTERA_SPI_CONTROL_SSO_MSK;
+		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
+		writel(0, hw->base + ALTERA_SPI_SLAVE_SEL);
 	} else {
-		switch (value) {
-		case BITBANG_CS_INACTIVE:
-			hw->imr &= ~ALTERA_SPI_CONTROL_SSO_MSK;
-			writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-			break;
-
-		case BITBANG_CS_ACTIVE:
-			writel(1 << spi->chip_select,
-			       hw->base + ALTERA_SPI_SLAVE_SEL);
-			hw->imr |= ALTERA_SPI_CONTROL_SSO_MSK;
-			writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
-			break;
-		}
+		writel(BIT(spi->chip_select), hw->base + ALTERA_SPI_SLAVE_SEL);
+		hw->imr |= ALTERA_SPI_CONTROL_SSO_MSK;
+		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
 	}
 }
 
@@ -116,9 +90,10 @@ static inline unsigned int hw_txbyte(struct altera_spi *hw, int count)
 	return 0;
 }
 
-static int altera_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
+static int altera_spi_txrx(struct spi_master *master,
+	struct spi_device *spi, struct spi_transfer *t)
 {
-	struct altera_spi *hw = altera_spi_to_hw(spi);
+	struct altera_spi *hw = spi_master_get_devdata(master);
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
@@ -133,11 +108,6 @@ static int altera_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 		/* send the first byte */
 		writel(hw_txbyte(hw, 0), hw->base + ALTERA_SPI_TXDATA);
-
-		wait_for_completion(&hw->done);
-		/* disable receive interrupt */
-		hw->imr &= ~ALTERA_SPI_CONTROL_IRRDY_MSK;
-		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
 	} else {
 		while (hw->count < hw->len) {
 			unsigned int rxd;
@@ -164,14 +134,16 @@ static int altera_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 			hw->count++;
 		}
+		spi_finalize_current_transfer(master);
 	}
 
-	return hw->count * hw->bytes_per_word;
+	return t->len;
 }
 
 static irqreturn_t altera_spi_irq(int irq, void *dev)
 {
-	struct altera_spi *hw = dev;
+	struct spi_master *master = dev;
+	struct altera_spi *hw = spi_master_get_devdata(master);
 	unsigned int rxd;
 
 	rxd = readl(hw->base + ALTERA_SPI_RXDATA);
@@ -189,10 +161,15 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 
 	hw->count++;
 
-	if (hw->count < hw->len)
+	if (hw->count < hw->len) {
 		writel(hw_txbyte(hw, hw->count), hw->base + ALTERA_SPI_TXDATA);
-	else
-		complete(&hw->done);
+	} else {
+		/* disable receive interrupt */
+		hw->imr &= ~ALTERA_SPI_CONTROL_IRRDY_MSK;
+		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
+
+		spi_finalize_current_transfer(master);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -214,14 +191,10 @@ static int altera_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	master->dev.of_node = pdev->dev.of_node;
+	master->transfer_one = altera_spi_txrx;
+	master->set_cs = altera_spi_set_cs;
 
 	hw = spi_master_get_devdata(master);
-	platform_set_drvdata(pdev, hw);
-
-	/* setup the state for the bitbang driver */
-	hw->bitbang.master = master;
-	hw->bitbang.chipselect = altera_spi_chipsel;
-	hw->bitbang.txrx_bufs = altera_spi_txrx;
 
 	/* find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -239,15 +212,13 @@ static int altera_spi_probe(struct platform_device *pdev)
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
-		init_completion(&hw->done);
 		err = devm_request_irq(&pdev->dev, hw->irq, altera_spi_irq, 0,
-				       pdev->name, hw);
+				       pdev->name, master);
 		if (err)
 			goto exit;
 	}
 
-	/* register our spi controller */
-	err = spi_bitbang_start(&hw->bitbang);
+	err = devm_spi_register_master(&pdev->dev, master);
 	if (err)
 		goto exit;
 	dev_info(&pdev->dev, "base %p, irq %d\n", hw->base, hw->irq);
@@ -258,16 +229,6 @@ static int altera_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int altera_spi_remove(struct platform_device *dev)
-{
-	struct altera_spi *hw = platform_get_drvdata(dev);
-	struct spi_master *master = hw->bitbang.master;
-
-	spi_bitbang_stop(&hw->bitbang);
-	spi_master_put(master);
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id altera_spi_match[] = {
 	{ .compatible = "ALTR,spi-1.0", },
@@ -279,7 +240,6 @@ MODULE_DEVICE_TABLE(of, altera_spi_match);
 
 static struct platform_driver altera_spi_driver = {
 	.probe = altera_spi_probe,
-	.remove = altera_spi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.pm = NULL,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
