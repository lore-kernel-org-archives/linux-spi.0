From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: dw: Convert to let spi core validate transfer speed
Date: Thu, 20 Feb 2014 21:37:56 +0800
Message-ID: <1392903476.16767.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set master->max_speed_hz then spi core will handle checking transfer speed.
So we can remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index bf98d63..9e4a0aa 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -439,12 +439,6 @@ static void pump_transfers(unsigned long data)
 
 		if (transfer->speed_hz != speed) {
 			speed = transfer->speed_hz;
-			if (speed > dws->max_freq) {
-				printk(KERN_ERR "MRST SPI0: unsupported"
-					"freq: %dHz\n", speed);
-				message->status = -EIO;
-				goto early_exit;
-			}
 
 			/* clk_div doesn't support odd number */
 			clk_div = dws->max_freq / speed;
@@ -809,6 +803,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->cleanup = dw_spi_cleanup;
 	master->setup = dw_spi_setup;
 	master->transfer = dw_spi_transfer;
+	master->max_speed_hz = dws->max_freq;
 
 	/* Basic HW init */
 	spi_hw_init(dws);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
