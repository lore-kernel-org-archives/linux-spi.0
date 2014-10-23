From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive data
Date: Thu, 23 Oct 2014 12:14:13 +0900
Message-ID: <1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414034053-14750-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

In order to transmit and receive data when have 32 bytes of data that
ready has prepared on Transmit/Receive Buffer to transmit or receive.
Instead transmits/receives a byte data using Transmit/Receive Buffer
Data Triggering Number will improve the speed of transfer data.

Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ad87a98..32a2515 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -182,6 +182,13 @@
 #define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset */
 #define SPBFCR_TXTRG_MASK	0x30	/* Transmit Buffer Data Triggering Number */
 #define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number */
+/* QSPI on R-Car Gen2 */
+#define SPBFCR_TXTRG_1B		0x00	/* 31 bytes (1 byte available) */
+#define SPBFCR_TXTRG_32B	0x30	/* 0 byte (32 bytes available) */
+#define SPBFCR_RXTRG_1B		0x00	/* 1 byte (31 bytes available) */
+#define SPBFCR_RXTRG_32B	0x07	/* 32 bytes (0 byte available) */
+
+#define QSPI_BUFFER_SIZE        32u
 
 struct rspi_data {
 	void __iomem *addr;
@@ -371,6 +378,52 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	return 0;
 }
 
+static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
+{
+	u8 data;
+
+	data = rspi_read8(rspi, reg);
+	data &= ~mask;
+	data |= (val & mask);
+	rspi_write8(rspi, data, reg);
+}
+
+static int qspi_set_send_trigger(struct rspi_data *rspi, unsigned int len)
+{
+	unsigned int n;
+
+	n = min(len, QSPI_BUFFER_SIZE);
+
+	if (len >= QSPI_BUFFER_SIZE) {
+		/* sets triggering number to 32 bytes */
+		qspi_update(rspi, SPBFCR_TXTRG_MASK,
+			     SPBFCR_TXTRG_32B, QSPI_SPBFCR);
+	} else {
+		/* sets triggering number to 1 byte */
+		qspi_update(rspi, SPBFCR_TXTRG_MASK,
+			     SPBFCR_TXTRG_1B, QSPI_SPBFCR);
+	}
+
+	return n;
+}
+
+static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
+{
+	unsigned int n;
+
+	n = min(len, QSPI_BUFFER_SIZE);
+
+	if (len >= QSPI_BUFFER_SIZE) {
+		/* sets triggering number to 32 bytes */
+		qspi_update(rspi, SPBFCR_RXTRG_MASK,
+			     SPBFCR_RXTRG_32B, QSPI_SPBFCR);
+	} else {
+		/* sets triggering number to 1 byte */
+		qspi_update(rspi, SPBFCR_RXTRG_MASK,
+			     SPBFCR_RXTRG_1B, QSPI_SPBFCR);
+	}
+}
+
 #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
 
 static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
@@ -614,19 +667,29 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
 	return __rspi_can_dma(rspi, xfer);
 }
 
-static int rspi_common_transfer(struct rspi_data *rspi,
-				struct spi_transfer *xfer)
+static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
+					 struct spi_transfer *xfer)
 {
-	int ret;
-
 	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
 		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
-		ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
+		int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
 					xfer->rx_buf ? &xfer->rx_sg : NULL);
 		if (ret != -EAGAIN)
-			return ret;
+			return 0;
 	}
 
+	return -EAGAIN;
+}
+
+static int rspi_common_transfer(struct rspi_data *rspi,
+				struct spi_transfer *xfer)
+{
+	int ret;
+
+	ret = rspi_dma_check_then_transfer(rspi, xfer);
+	if (ret != -EAGAIN)
+		return ret;
+
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
 	if (ret < 0)
 		return ret;
@@ -666,12 +729,59 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 	return rspi_common_transfer(rspi, xfer);
 }
 
+static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
+					u8 *rx, unsigned int len)
+{
+	unsigned int i, n, ret;
+	int error;
+
+	while (len > 0) {
+		n = qspi_set_send_trigger(rspi, len);
+		qspi_set_receive_trigger(rspi, len);
+		if (n == QSPI_BUFFER_SIZE) {
+			error = rspi_wait_for_tx_empty(rspi);
+			if (error < 0) {
+				dev_err(&rspi->master->dev, "transmit timeout\n");
+				return error;
+			}
+			for (i = 0; i < n; i++)
+				rspi_write_data(rspi, *tx++);
+
+			error = rspi_wait_for_rx_full(rspi);
+			if (error < 0) {
+				dev_err(&rspi->master->dev, "receive timeout\n");
+				return error;
+			}
+			for (i = 0; i < n; i++)
+				*rx++ = rspi_read_data(rspi);
+		} else {
+			ret = rspi_pio_transfer(rspi, tx, rx, n);
+			if (ret < 0)
+				return ret;
+		}
+		len -= n;
+	}
+
+	return 0;
+}
+
 static int qspi_transfer_out_in(struct rspi_data *rspi,
 				struct spi_transfer *xfer)
 {
+	int ret;
+
 	qspi_receive_init(rspi);
 
-	return rspi_common_transfer(rspi, xfer);
+	ret = rspi_dma_check_then_transfer(rspi, xfer);
+	if (ret != -EAGAIN)
+		return ret;
+
+	ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
+					    xfer->rx_buf, xfer->len);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
