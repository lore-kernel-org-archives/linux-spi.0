From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 1/1] ARM: spi supports 32bytes buffer for DUAL and QUAD
Date: Fri,  4 Nov 2016 17:38:54 +0900
Message-ID: <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp>
References: <1478248734-32044-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
        ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478248734-32044-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

This patch supports 32bytes of buffer for DUAL and QUAD in QSPI by
Using Transmit/Receive Buffer Data Triggering Number.
In order to improve the DUAL and QUAD's performance of SPI 
while transferring data in PIO mode, it sends/receives each 32bytes 
data instead of each byte data as current situation.

Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a816f07..fb12bc5 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -413,7 +413,7 @@ static unsigned int qspi_set_send_trigger(struct rspi_data *rspi,
 	return n;
 }
 
-static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
+static int qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 {
 	unsigned int n;
 
@@ -428,6 +428,7 @@ static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
 		qspi_update(rspi, SPBFCR_RXTRG_MASK,
 			     SPBFCR_RXTRG_1B, QSPI_SPBFCR);
 	}
+	return n;
 }
 
 #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
@@ -514,6 +515,51 @@ static int rspi_pio_transfer(struct rspi_data *rspi, const u8 *tx, u8 *rx,
 	return 0;
 }
 
+static int rspi_pio_transfer_in_or_our(struct rspi_data *rspi, const u8 *tx,
+				       u8 *rx, unsigned int n)
+{
+	unsigned int i, len;
+	int ret;
+
+	while (n > 0) {
+		if (tx) {
+			len = qspi_set_send_trigger(rspi, n);
+			if (len == QSPI_BUFFER_SIZE) {
+				ret = rspi_wait_for_tx_empty(rspi);
+				if (ret < 0) {
+					dev_err(&rspi->master->dev, "transmit timeout\n");
+					return ret;
+				}
+				for (i = 0; i < len; i++)
+					rspi_write_data(rspi, *tx++);
+			} else {
+				ret = rspi_pio_transfer(rspi, tx, NULL, n);
+				if (ret < 0)
+					return ret;
+			}
+		}
+		if (rx) {
+			len = qspi_set_receive_trigger(rspi, n);
+			if (len == QSPI_BUFFER_SIZE) {
+				ret = rspi_wait_for_rx_full(rspi);
+				if (ret < 0) {
+					dev_err(&rspi->master->dev, "receive timeout\n");
+					return ret;
+				}
+				for (i = 0; i < len; i++)
+					*rx++ = rspi_read_data(rspi);
+			} else {
+				ret = rspi_pio_transfer(rspi, NULL, rx, n);
+				if (ret < 0)
+					return ret;
+				*rx++ = ret;
+			}
+		}
+		n -= len;
+	}
+	return 0;
+}
+
 static void rspi_dma_complete(void *arg)
 {
 	struct rspi_data *rspi = arg;
@@ -793,7 +839,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	ret = rspi_pio_transfer(rspi, xfer->tx_buf, NULL, xfer->len);
+	ret = rspi_pio_transfer_in_or_our(rspi, xfer->tx_buf, NULL, xfer->len);
 	if (ret < 0)
 		return ret;
 
@@ -811,7 +857,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	return rspi_pio_transfer(rspi, NULL, xfer->rx_buf, xfer->len);
+	return rspi_pio_transfer_in_or_our(rspi, NULL, xfer->rx_buf, xfer->len);
 }
 
 static int qspi_transfer_one(struct spi_master *master, struct spi_device *spi,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
