From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sirf: send more words at the TX initial phase
Date: Tue, 20 May 2014 14:07:48 +0800
Message-ID: <1400566068-2781-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

The old codes use the below flow to do TX: send one word at first, after
this word is finished and TX empty interrupt is generated, send more
words. This causes redundant interrupt overhead at least for the 1st
word.

This patch moves to send as many as possible words at the beginning and
handle TX empty interrupt to send another bundle of words. so interrupt
overhead is decreased.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 101 ++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index 2d23899..95ac276 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -86,6 +86,7 @@
 #define SIRFSOC_SPI_TX_DONE		BIT(1)
 #define SIRFSOC_SPI_RX_OFLOW		BIT(2)
 #define SIRFSOC_SPI_TX_UFLOW		BIT(3)
+#define SIRFSOC_SPI_RX_IO_DMA		BIT(4)
 #define SIRFSOC_SPI_RX_FIFO_FULL	BIT(6)
 #define SIRFSOC_SPI_TXFIFO_EMPTY	BIT(7)
 #define SIRFSOC_SPI_RXFIFO_THD_REACH	BIT(8)
@@ -265,41 +266,34 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 {
 	struct sirfsoc_spi *sspi = dev_id;
 	u32 spi_stat = readl(sspi->base + SIRFSOC_SPI_INT_STATUS);
-
-	writel(spi_stat, sspi->base + SIRFSOC_SPI_INT_STATUS);
-
 	if (sspi->tx_by_cmd && (spi_stat & SIRFSOC_SPI_FRM_END)) {
 		complete(&sspi->tx_done);
 		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_INT_MASK_ALL,
+				sspi->base + SIRFSOC_SPI_INT_STATUS);
 		return IRQ_HANDLED;
 	}
 
 	/* Error Conditions */
 	if (spi_stat & SIRFSOC_SPI_RX_OFLOW ||
 			spi_stat & SIRFSOC_SPI_TX_UFLOW) {
+		complete(&sspi->tx_done);
 		complete(&sspi->rx_done);
 		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_INT_MASK_ALL,
+				sspi->base + SIRFSOC_SPI_INT_STATUS);
+		return IRQ_HANDLED;
 	}
+	if (spi_stat & SIRFSOC_SPI_TXFIFO_EMPTY)
+		complete(&sspi->tx_done);
+	while (!(readl(sspi->base + SIRFSOC_SPI_INT_STATUS) &
+		SIRFSOC_SPI_RX_IO_DMA))
+		cpu_relax();
+	complete(&sspi->rx_done);
+	writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
+	writel(SIRFSOC_SPI_INT_MASK_ALL,
+			sspi->base + SIRFSOC_SPI_INT_STATUS);
 
-	if (spi_stat & (SIRFSOC_SPI_FRM_END
-			| SIRFSOC_SPI_RXFIFO_THD_REACH))
-		while (!((readl(sspi->base + SIRFSOC_SPI_RXFIFO_STATUS)
-				& SIRFSOC_SPI_FIFO_EMPTY)) &&
-				sspi->left_rx_word)
-			sspi->rx_word(sspi);
-
-	if (spi_stat & (SIRFSOC_SPI_TXFIFO_EMPTY |
-			SIRFSOC_SPI_TXFIFO_THD_REACH))
-		while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS)
-				& SIRFSOC_SPI_FIFO_FULL)) &&
-				sspi->left_tx_word)
-			sspi->tx_word(sspi);
-
-	/* Received all words */
-	if ((sspi->left_rx_word == 0) && (sspi->left_tx_word == 0)) {
-		complete(&sspi->rx_done);
-		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
-	}
 	return IRQ_HANDLED;
 }
 
@@ -420,32 +414,45 @@ static void spi_sirfsoc_pio_transfer(struct spi_device *spi,
 	int timeout = t->len * 10;
 
 	sspi = spi_master_get_devdata(spi->master);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_RESET, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(SIRFSOC_SPI_FIFO_START, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
-	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
-	writel(readl(sspi->base + SIRFSOC_SPI_CTRL) | SIRFSOC_SPI_MUL_DAT_MODE |
-		SIRFSOC_SPI_ENA_AUTO_CLR, sspi->base + SIRFSOC_SPI_CTRL);
-	writel(sspi->left_tx_word - 1,
-			sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
-	writel(sspi->left_rx_word - 1,
-			sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
-	sspi->tx_word(sspi);
-	writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN | SIRFSOC_SPI_TX_UFLOW_INT_EN |
-		SIRFSOC_SPI_RX_OFLOW_INT_EN | SIRFSOC_SPI_RXFIFO_THD_INT_EN |
-		SIRFSOC_SPI_TXFIFO_THD_INT_EN | SIRFSOC_SPI_FRM_END_INT_EN|
-		SIRFSOC_SPI_RXFIFO_FULL_INT_EN,
-		sspi->base + SIRFSOC_SPI_INT_EN);
-	writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
+	do {
+		writel(SIRFSOC_SPI_FIFO_RESET,
+			sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+		writel(SIRFSOC_SPI_FIFO_RESET,
+			sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+		writel(SIRFSOC_SPI_FIFO_START,
+			sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+		writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_INT_MASK_ALL,
+			sspi->base + SIRFSOC_SPI_INT_STATUS);
+		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
+			SIRFSOC_SPI_MUL_DAT_MODE | SIRFSOC_SPI_ENA_AUTO_CLR,
+			sspi->base + SIRFSOC_SPI_CTRL);
+		writel(min(sspi->left_tx_word, (u32)(256 / sspi->word_width))
+				- 1, sspi->base + SIRFSOC_SPI_TX_DMA_IO_LEN);
+		writel(min(sspi->left_rx_word, (u32)(256 / sspi->word_width))
+				- 1, sspi->base + SIRFSOC_SPI_RX_DMA_IO_LEN);
+		while (!((readl(sspi->base + SIRFSOC_SPI_TXFIFO_STATUS)
+			& SIRFSOC_SPI_FIFO_FULL)) && sspi->left_tx_word)
+			sspi->tx_word(sspi);
+		writel(SIRFSOC_SPI_TXFIFO_EMPTY_INT_EN |
+			SIRFSOC_SPI_TX_UFLOW_INT_EN |
+			SIRFSOC_SPI_RX_OFLOW_INT_EN,
+			sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_RX_EN | SIRFSOC_SPI_TX_EN,
 			sspi->base + SIRFSOC_SPI_TX_RX_EN);
-	if (wait_for_completion_timeout(&sspi->rx_done, timeout) == 0)
-		dev_err(&spi->dev, "transfer timeout\n");
-	writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
-	writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
-	writel(0, sspi->base + SIRFSOC_SPI_TX_RX_EN);
-	writel(0, sspi->base + SIRFSOC_SPI_INT_EN);
+		if (!wait_for_completion_timeout(&sspi->tx_done, timeout) ||
+			!wait_for_completion_timeout(&sspi->rx_done, timeout)) {
+			dev_err(&spi->dev, "transfer timeout\n");
+			break;
+		}
+		while (!((readl(sspi->base + SIRFSOC_SPI_RXFIFO_STATUS)
+			& SIRFSOC_SPI_FIFO_EMPTY)) && sspi->left_rx_word)
+			sspi->rx_word(sspi);
+		writel(0, sspi->base + SIRFSOC_SPI_RXFIFO_OP);
+		writel(0, sspi->base + SIRFSOC_SPI_TXFIFO_OP);
+	} while (sspi->left_tx_word != 0 || sspi->left_rx_word != 0);
 }
 
 static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
