From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Remove duplicate code to set default
 bits_per_word and max speed
Date: Sun, 02 Mar 2014 23:24:18 +0800
Message-ID: <1393773858.4044.12.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In the implementation of __spi_validate(), spi core will set transfer
bits_per_word and max speed as spi device default if it is not set for
this transfer. So we can remove the same logic in spi_clps711x_setup_xfer() and
spi_clps711x_transfer_one().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 3900c31..74642f8 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -44,17 +44,16 @@ static int spi_clps711x_setup(struct spi_device *spi)
 static void spi_clps711x_setup_xfer(struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	u32 speed = xfer->speed_hz ? : spi->max_speed_hz;
 	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
 
 	/* Setup SPI frequency divider */
-	if (!speed || (speed >= hw->max_speed_hz))
+	if (!xfer->speed_hz || (xfer->speed_hz >= hw->max_speed_hz))
 		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
 			    SYSCON1_ADCKSEL(3), SYSCON1);
-	else if (speed >= (hw->max_speed_hz / 2))
+	else if (xfer->speed_hz >= (hw->max_speed_hz / 2))
 		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
 			    SYSCON1_ADCKSEL(2), SYSCON1);
-	else if (speed >= (hw->max_speed_hz / 8))
+	else if (xfer->speed_hz >= (hw->max_speed_hz / 8))
 		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
 			    SYSCON1_ADCKSEL(1), SYSCON1);
 	else
@@ -86,7 +85,7 @@ static int spi_clps711x_transfer_one(struct spi_master *master,
 	spi_clps711x_setup_xfer(spi, xfer);
 
 	hw->len = xfer->len;
-	hw->bpw = xfer->bits_per_word ? : spi->bits_per_word;
+	hw->bpw = xfer->bits_per_word;
 	hw->tx_buf = (u8 *)xfer->tx_buf;
 	hw->rx_buf = (u8 *)xfer->rx_buf;
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
