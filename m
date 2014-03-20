From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: coldfire-qspi: Simplify the code to set register bits
 for transfer speed
Date: Thu, 20 Mar 2014 22:59:06 +0800
Message-ID: <1395327546.25840.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi core will use spi->max_speed_hz as transfer speed if the transfer speed was
not set. So we don't need to test t->speed_hz in mcfqspi_transfer_one().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index e36c7cb..e2fa628 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -321,10 +321,7 @@ static int mcfqspi_transfer_one(struct spi_master *master,
 		qmr |= MCFQSPI_QMR_CPHA;
 	if (spi->mode & SPI_CPOL)
 		qmr |= MCFQSPI_QMR_CPOL;
-	if (t->speed_hz)
-		qmr |= mcfqspi_qmr_baud(t->speed_hz);
-	else
-		qmr |= mcfqspi_qmr_baud(spi->max_speed_hz);
+	qmr |= mcfqspi_qmr_baud(t->speed_hz);
 	mcfqspi_wr_qmr(mcfqspi, qmr);
 
 	mcfqspi_wr_qir(mcfqspi, MCFQSPI_QIR_SPIFE);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
