From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: ti-ssp: Remove duplicate code to check full duplex
 transfer
Date: Tue, 18 Mar 2014 10:48:37 +0800
Message-ID: <1395110917.15410.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver has set SPI_MASTER_HALF_DUPLEX flag, so spi core will reject full
duplex transfer. We can remove the same checking in ti_ssp_spi_transfer().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-ti-ssp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-ti-ssp.c b/drivers/spi/spi-ti-ssp.c
index 7d20e12..116640c 100644
--- a/drivers/spi/spi-ti-ssp.c
+++ b/drivers/spi/spi-ti-ssp.c
@@ -256,11 +256,6 @@ static int ti_ssp_spi_transfer(struct spi_device *spi, struct spi_message *m)
 			dev_err(&spi->dev, "invalid xfer, no buffer\n");
 			return -EINVAL;
 		}
-
-		if (t->len && t->rx_buf && t->tx_buf) {
-			dev_err(&spi->dev, "invalid xfer, full duplex\n");
-			return -EINVAL;
-		}
 	}
 
 	spin_lock(&hw->lock);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
