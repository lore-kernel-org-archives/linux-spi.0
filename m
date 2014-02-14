From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH 3/3] spi: coldfire-qspi: Use core message handling
Date: Fri, 14 Feb 2014 09:55:55 +0800
Message-ID: <1392342955.22981.4.camel@phoenix>
References: <1392342780.22981.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392342780.22981.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert to use default implementation of transfer_one_message().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
Hi Steven,
I don't have this h/w, can you help testing if this patch works.
Thanks,
Axel
 drivers/spi/spi-coldfire-qspi.c | 81 +++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 0fcec3b..c29bbb0 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -298,58 +298,44 @@ static void mcfqspi_transfer_msg16(struct mcfqspi *mcfqspi, unsigned count,
 	}
 }
 
-static int mcfqspi_transfer_one_message(struct spi_master *master,
-					 struct spi_message *msg)
+static void mcfqspi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
-	struct spi_transfer *t;
-	int status = 0;
-
-	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		bool cs_high = spi->mode & SPI_CS_HIGH;
-		u16 qmr = MCFQSPI_QMR_MSTR;
-
-		qmr |= t->bits_per_word << 10;
-		if (spi->mode & SPI_CPHA)
-			qmr |= MCFQSPI_QMR_CPHA;
-		if (spi->mode & SPI_CPOL)
-			qmr |= MCFQSPI_QMR_CPOL;
-		if (t->speed_hz)
-			qmr |= mcfqspi_qmr_baud(t->speed_hz);
-		else
-			qmr |= mcfqspi_qmr_baud(spi->max_speed_hz);
-		mcfqspi_wr_qmr(mcfqspi, qmr);
+	struct mcfqspi *mcfqspi = spi_master_get_devdata(spi->master);
+	bool cs_high = spi->mode & SPI_CS_HIGH;
 
+	if (enable)
 		mcfqspi_cs_select(mcfqspi, spi->chip_select, cs_high);
+	else
+		mcfqspi_cs_deselect(mcfqspi, spi->chip_select, cs_high);
+}
 
-		mcfqspi_wr_qir(mcfqspi, MCFQSPI_QIR_SPIFE);
-		if (t->bits_per_word == 8)
-			mcfqspi_transfer_msg8(mcfqspi, t->len, t->tx_buf,
-					t->rx_buf);
-		else
-			mcfqspi_transfer_msg16(mcfqspi, t->len / 2, t->tx_buf,
-					t->rx_buf);
-		mcfqspi_wr_qir(mcfqspi, 0);
-
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-		if (t->cs_change) {
-			if (!list_is_last(&t->transfer_list, &msg->transfers))
-				mcfqspi_cs_deselect(mcfqspi, spi->chip_select,
-						cs_high);
-		} else {
-			if (list_is_last(&t->transfer_list, &msg->transfers))
-				mcfqspi_cs_deselect(mcfqspi, spi->chip_select,
-						cs_high);
-		}
-		msg->actual_length += t->len;
-	}
-	msg->status = status;
-	spi_finalize_current_message(master);
+static int mcfqspi_transfer_one(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *t)
+{
+	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	u16 qmr = MCFQSPI_QMR_MSTR;
+
+	qmr |= t->bits_per_word << 10;
+	if (spi->mode & SPI_CPHA)
+		qmr |= MCFQSPI_QMR_CPHA;
+	if (spi->mode & SPI_CPOL)
+		qmr |= MCFQSPI_QMR_CPOL;
+	if (t->speed_hz)
+		qmr |= mcfqspi_qmr_baud(t->speed_hz);
+	else
+		qmr |= mcfqspi_qmr_baud(spi->max_speed_hz);
+	mcfqspi_wr_qmr(mcfqspi, qmr);
 
-	return status;
+	mcfqspi_wr_qir(mcfqspi, MCFQSPI_QIR_SPIFE);
+	if (t->bits_per_word == 8)
+		mcfqspi_transfer_msg8(mcfqspi, t->len, t->tx_buf, t->rx_buf);
+	else
+		mcfqspi_transfer_msg16(mcfqspi, t->len / 2, t->tx_buf,
+				       t->rx_buf);
+	mcfqspi_wr_qir(mcfqspi, 0);
 
+	return 0;
 }
 
 static int mcfqspi_setup(struct spi_device *spi)
@@ -432,7 +418,8 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
 	master->setup = mcfqspi_setup;
-	master->transfer_one_message = mcfqspi_transfer_one_message;
+	master->set_cs = mcfqspi_set_cs;
+	master->transfer_one = mcfqspi_transfer_one;
 	master->auto_runtime_pm = true;
 
 	platform_set_drvdata(pdev, master);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
