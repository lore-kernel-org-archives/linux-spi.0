From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: ti-qspi: Simplify qspi_write_msg and qspi_read_msg
 implementation
Date: Sun, 12 Jan 2014 14:40:22 +0800
Message-ID: <1389508822.13361.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make the unit of wlen to be byte, and simplify the code to avoid duplicate
code for different wlen cases.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 61 ++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4b413e9..2a1ab49 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -208,53 +208,36 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 	txbuf = t->tx_buf;
 	cmd = qspi->cmd | QSPI_WR_SNGL;
 	count = t->len;
-	wlen = t->bits_per_word;
+	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
 		switch (wlen) {
-		case 8:
+		case 1:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %02x\n",
 					cmd, qspi->dc, *txbuf);
 			writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
-			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-			ret = wait_for_completion_timeout(&qspi->transfer_complete,
-					QSPI_COMPLETION_TIMEOUT);
-			if (ret == 0) {
-				dev_err(qspi->dev, "write timed out\n");
-				return -ETIMEDOUT;
-			}
-			txbuf += 1;
-			count -= 1;
 			break;
-		case 16:
+		case 2:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %04x\n",
 					cmd, qspi->dc, *txbuf);
 			writew(*((u16 *)txbuf), qspi->base + QSPI_SPI_DATA_REG);
-			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-			ret = wait_for_completion_timeout(&qspi->transfer_complete,
-				QSPI_COMPLETION_TIMEOUT);
-			if (ret == 0) {
-				dev_err(qspi->dev, "write timed out\n");
-				return -ETIMEDOUT;
-			}
-			txbuf += 2;
-			count -= 2;
 			break;
-		case 32:
+		case 4:
 			dev_dbg(qspi->dev, "tx cmd %08x dc %08x data %08x\n",
 					cmd, qspi->dc, *txbuf);
 			writel(*((u32 *)txbuf), qspi->base + QSPI_SPI_DATA_REG);
-			ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-			ret = wait_for_completion_timeout(&qspi->transfer_complete,
-				QSPI_COMPLETION_TIMEOUT);
-			if (ret == 0) {
-				dev_err(qspi->dev, "write timed out\n");
-				return -ETIMEDOUT;
-			}
-			txbuf += 4;
-			count -= 4;
 			break;
 		}
+
+		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
+		ret = wait_for_completion_timeout(&qspi->transfer_complete,
+						  QSPI_COMPLETION_TIMEOUT);
+		if (ret == 0) {
+			dev_err(qspi->dev, "write timed out\n");
+			return -ETIMEDOUT;
+		}
+		txbuf += wlen;
+		count -= wlen;
 	}
 
 	return 0;
@@ -280,7 +263,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		break;
 	}
 	count = t->len;
-	wlen = t->bits_per_word;
+	wlen = t->bits_per_word >> 3;	/* in bytes */
 
 	while (count) {
 		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
@@ -292,22 +275,18 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 			return -ETIMEDOUT;
 		}
 		switch (wlen) {
-		case 8:
+		case 1:
 			*rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
-			rxbuf += 1;
-			count -= 1;
 			break;
-		case 16:
+		case 2:
 			*((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
-			rxbuf += 2;
-			count -= 2;
 			break;
-		case 32:
+		case 4:
 			*((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
-			rxbuf += 4;
-			count -= 4;
 			break;
 		}
+		rxbuf += wlen;
+		count -= wlen;
 	}
 
 	return 0;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
