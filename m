From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: coldfire-qspi: Fix bits per word setting when
 t->bits_per_word is not set
Date: Thu, 27 Feb 2014 09:05:02 +0800
Message-ID: <1393463102.12945.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This ensures to use spi_device's bits_per_word setting when t->bits_per_word is
not set. This looks like a bug introduced by commit 24778be20f8
"spi: convert drivers to use bits_per_word_mask".

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index c29bbb0..8c85bea 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -315,12 +315,16 @@ static int mcfqspi_transfer_one(struct spi_master *master,
 {
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
 	u16 qmr = MCFQSPI_QMR_MSTR;
+	u8 bpw;
 
-	qmr |= t->bits_per_word << 10;
+	bpw = t->bits_per_word ? : spi->bits_per_word;
+
+	qmr |= bpw << 10;
 	if (spi->mode & SPI_CPHA)
 		qmr |= MCFQSPI_QMR_CPHA;
 	if (spi->mode & SPI_CPOL)
 		qmr |= MCFQSPI_QMR_CPOL;
+
 	if (t->speed_hz)
 		qmr |= mcfqspi_qmr_baud(t->speed_hz);
 	else
@@ -328,7 +332,7 @@ static int mcfqspi_transfer_one(struct spi_master *master,
 	mcfqspi_wr_qmr(mcfqspi, qmr);
 
 	mcfqspi_wr_qir(mcfqspi, MCFQSPI_QIR_SPIFE);
-	if (t->bits_per_word == 8)
+	if (bpw == 8)
 		mcfqspi_transfer_msg8(mcfqspi, t->len, t->tx_buf, t->rx_buf);
 	else
 		mcfqspi_transfer_msg16(mcfqspi, t->len / 2, t->tx_buf,
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
