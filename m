From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: altera: Consolidate TX/RX data register access" to the spi tree
Date: Wed, 16 Aug 2017 12:21:06 +0100
Message-ID: <E1dhwNm-0003jS-B7@finisterre>
References: <20170816093312.23048-2-lars@metafoo.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170816093312.23048-2-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: altera: Consolidate TX/RX data register access

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

>From b64836a5718bdcce7b23dc06eb1f3a9620cf6214 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Date: Wed, 16 Aug 2017 11:33:12 +0200
Subject: [PATCH] spi: altera: Consolidate TX/RX data register access

The patterns for accessing the TX/RX data registers is the same for the IRQ
and non-IRQ paths. Consolidate the duplicated code into shared helper
functions.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-altera.c | 75 ++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index bfac34068999..a5adf0d868fc 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -76,18 +76,43 @@ static void altera_spi_set_cs(struct spi_device *spi, bool is_high)
 	}
 }
 
-static inline unsigned int hw_txbyte(struct altera_spi *hw, int count)
+static void altera_spi_tx_word(struct altera_spi *hw)
 {
+	unsigned int txd = 0;
+
 	if (hw->tx) {
 		switch (hw->bytes_per_word) {
 		case 1:
-			return hw->tx[count];
+			txd = hw->tx[hw->count];
+			break;
 		case 2:
-			return (hw->tx[count * 2]
-				| (hw->tx[count * 2 + 1] << 8));
+			txd = (hw->tx[hw->count * 2]
+				| (hw->tx[hw->count * 2 + 1] << 8));
+			break;
 		}
 	}
-	return 0;
+
+	writel(txd, hw->base + ALTERA_SPI_TXDATA);
+}
+
+static void altera_spi_rx_word(struct altera_spi *hw)
+{
+	unsigned int rxd;
+
+	rxd = readl(hw->base + ALTERA_SPI_RXDATA);
+	if (hw->rx) {
+		switch (hw->bytes_per_word) {
+		case 1:
+			hw->rx[hw->count] = rxd;
+			break;
+		case 2:
+			hw->rx[hw->count * 2] = rxd;
+			hw->rx[hw->count * 2 + 1] = rxd >> 8;
+			break;
+		}
+	}
+
+	hw->count++;
 }
 
 static int altera_spi_txrx(struct spi_master *master,
@@ -107,32 +132,16 @@ static int altera_spi_txrx(struct spi_master *master,
 		writel(hw->imr, hw->base + ALTERA_SPI_CONTROL);
 
 		/* send the first byte */
-		writel(hw_txbyte(hw, 0), hw->base + ALTERA_SPI_TXDATA);
+		altera_spi_tx_word(hw);
 	} else {
 		while (hw->count < hw->len) {
-			unsigned int rxd;
-
-			writel(hw_txbyte(hw, hw->count),
-			       hw->base + ALTERA_SPI_TXDATA);
+			altera_spi_tx_word(hw);
 
 			while (!(readl(hw->base + ALTERA_SPI_STATUS) &
 				 ALTERA_SPI_STATUS_RRDY_MSK))
 				cpu_relax();
 
-			rxd = readl(hw->base + ALTERA_SPI_RXDATA);
-			if (hw->rx) {
-				switch (hw->bytes_per_word) {
-				case 1:
-					hw->rx[hw->count] = rxd;
-					break;
-				case 2:
-					hw->rx[hw->count * 2] = rxd;
-					hw->rx[hw->count * 2 + 1] = rxd >> 8;
-					break;
-				}
-			}
-
-			hw->count++;
+			altera_spi_rx_word(hw);
 		}
 		spi_finalize_current_transfer(master);
 	}
@@ -144,25 +153,11 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 {
 	struct spi_master *master = dev;
 	struct altera_spi *hw = spi_master_get_devdata(master);
-	unsigned int rxd;
-
-	rxd = readl(hw->base + ALTERA_SPI_RXDATA);
-	if (hw->rx) {
-		switch (hw->bytes_per_word) {
-		case 1:
-			hw->rx[hw->count] = rxd;
-			break;
-		case 2:
-			hw->rx[hw->count * 2] = rxd;
-			hw->rx[hw->count * 2 + 1] = rxd >> 8;
-			break;
-		}
-	}
 
-	hw->count++;
+	altera_spi_rx_word(hw);
 
 	if (hw->count < hw->len) {
-		writel(hw_txbyte(hw, hw->count), hw->base + ALTERA_SPI_TXDATA);
+		altera_spi_tx_word(hw);
 	} else {
 		/* disable receive interrupt */
 		hw->imr &= ~ALTERA_SPI_CONTROL_IRRDY_MSK;
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
