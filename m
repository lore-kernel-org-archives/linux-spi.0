From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh-hspi: Remove duplicate code to set default transfer
 speed
Date: Sun, 02 Mar 2014 23:01:50 +0800
Message-ID: <1393772510.4044.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In the implementation of __spi_validate(), spi core will use spi device's max
speed as default transfer speed if it is not set for this transfer.
So we can remove the same logic in hspi_hw_setup().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh-hspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 3c5d3b8..7435626 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -113,14 +113,9 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
 {
 	struct spi_device *spi = msg->spi;
 	struct device *dev = hspi->dev;
-	u32 target_rate;
 	u32 spcr, idiv_clk;
 	u32 rate, best_rate, min, tmp;
 
-	target_rate = t ? t->speed_hz : 0;
-	if (!target_rate)
-		target_rate = spi->max_speed_hz;
-
 	/*
 	 * find best IDIV/CLKCx settings
 	 */
@@ -140,7 +135,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
 		rate /= (((idiv_clk & 0x1F) + 1) * 2);
 
 		/* save best settings */
-		tmp = abs(target_rate - rate);
+		tmp = abs(t->speed_hz - rate);
 		if (tmp < min) {
 			min = tmp;
 			spcr = idiv_clk;
@@ -153,7 +148,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
 	if (spi->mode & SPI_CPOL)
 		spcr |= 1 << 6;
 
-	dev_dbg(dev, "speed %d/%d\n", target_rate, best_rate);
+	dev_dbg(dev, "speed %d/%d\n", t->speed_hz, best_rate);
 
 	hspi_write(hspi, SPCR, spcr);
 	hspi_write(hspi, SPSR, 0x0);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
