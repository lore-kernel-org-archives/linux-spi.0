From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: omap-uwire: Remove full duplex check
Date: Wed, 26 Mar 2014 19:22:08 +0800
Message-ID: <1395832928.19941.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver sets the SPI_MASTER_HALF_DUPLEX flag, so the spi core will check
transfers to ensure they are not full duplex.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap-uwire.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 95cc694..f5176bb 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -218,10 +218,6 @@ static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 	if (!t->tx_buf && !t->rx_buf)
 		return 0;
 
-	/* Microwire doesn't read and write concurrently */
-	if (t->tx_buf && t->rx_buf)
-		return -EPERM;
-
 	w = spi->chip_select << 10;
 	w |= CS_CMD;
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
