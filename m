From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi: sirf: provide a shortcut for spi command-data mode
Date: Thu, 13 Feb 2014 00:30:18 +0800
Message-ID: <1392222620-17273-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

there are many SPI clients which use the following protocal:
step 1: send command bytes to clients(rx buffer is empty)
step 2: send data bytes to clients or receive data bytes from
clients.
SiRFprimaII provides a shortcut for this kind of SPI transfer.
when tx buf is less or equal than 4 bytes and rx buf is null
in a transfer, we think it as 'command' data and use hardware
command register for the transfer.
here we can save some CPU loading than doing both tx and rx
for a normal transfer.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index e430689..c400ab7 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -132,6 +132,7 @@
 #define IS_DMA_VALID(x) (x && ALIGNED(x->tx_buf) && ALIGNED(x->rx_buf) && \
 	ALIGNED(x->len) && (x->len < 2 * PAGE_SIZE))
 
+#define SIRFSOC_MAX_CMD_BYTES	4
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
 	struct completion rx_done;
@@ -161,7 +162,7 @@ struct sirfsoc_spi {
 	dma_addr_t dst_start;
 	void *dummypage;
 	int word_width; /* in bytes */
-
+	bool	tx_by_cmd;
 	int chipselect[0];
 };
 
@@ -260,6 +261,11 @@ static irqreturn_t spi_sirfsoc_irq(int irq, void *dev_id)
 
 	writel(spi_stat, sspi->base + SIRFSOC_SPI_INT_STATUS);
 
+	if (sspi->tx_by_cmd && (spi_stat & SIRFSOC_SPI_FRM_END)) {
+		complete(&sspi->tx_done);
+		writel(0x0, sspi->base + SIRFSOC_SPI_INT_EN);
+		return IRQ_HANDLED;
+	}
 	/* Error Conditions */
 	if (spi_stat & SIRFSOC_SPI_RX_OFLOW ||
 			spi_stat & SIRFSOC_SPI_TX_UFLOW) {
@@ -310,6 +316,32 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	writel(SIRFSOC_SPI_INT_MASK_ALL, sspi->base + SIRFSOC_SPI_INT_STATUS);
 
+	if (t && t->tx_buf && !t->rx_buf && (t->len <= SIRFSOC_MAX_CMD_BYTES)) {
+		const u32 *cmd_ptr;
+		u32 cmd;
+		sspi->tx_by_cmd = true;
+		cmd_ptr = sspi->tx;
+		cmd = *cmd_ptr;
+		if (sspi->word_width == 1 && !(spi->mode & SPI_LSB_FIRST))
+			cmd = cpu_to_be32(cmd) >>
+				((SIRFSOC_MAX_CMD_BYTES - t->len) * 8);
+		if (sspi->word_width == 2 && t->len == 4 &&
+				(!(spi->mode & SPI_LSB_FIRST)))
+			cmd = ((cmd & 0xffff) << 16) | (cmd >> 16);
+		writel(cmd, sspi->base + SIRFSOC_SPI_CMD);
+
+		writel(SIRFSOC_SPI_FRM_END_INT_EN,
+				sspi->base + SIRFSOC_SPI_INT_EN);
+		writel(SIRFSOC_SPI_CMD_TX_EN,
+				sspi->base + SIRFSOC_SPI_TX_RX_EN);
+
+		if (wait_for_completion_timeout(&sspi->tx_done, timeout) == 0) {
+			dev_err(&spi->dev, "transfer timeout\n");
+			return 0;
+		}
+		return t->len;
+	} else
+		sspi->tx_by_cmd = false;
 	if (sspi->left_tx_word == 1) {
 		writel(readl(sspi->base + SIRFSOC_SPI_CTRL) |
 			SIRFSOC_SPI_ENA_AUTO_CLR,
@@ -519,6 +551,11 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	writel(txfifo_ctrl, sspi->base + SIRFSOC_SPI_TXFIFO_CTRL);
 	writel(rxfifo_ctrl, sspi->base + SIRFSOC_SPI_RXFIFO_CTRL);
 
+	if (t && t->tx_buf && !t->rx_buf && (t->len <= SIRFSOC_MAX_CMD_BYTES))
+		regval |= (SIRFSOC_SPI_CMD_BYTE_NUM((t->len - 1)) |
+				SIRFSOC_SPI_CMD_MODE);
+	else
+		regval &= ~SIRFSOC_SPI_CMD_MODE;
 	writel(regval, sspi->base + SIRFSOC_SPI_CTRL);
 
 	if (IS_DMA_VALID(t)) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
