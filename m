From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: dw: Don't call kfree for memory allocated by
 devm_kzalloc
Date: Tue, 25 Mar 2014 12:44:13 +0800
Message-ID: <1395722653.16744.1.camel@phoenix>
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

With devm_kzalloc, the memory is automatically freed when spi_device detach from
the bus.

Fixes: commit 43f627ac9de42 (spi: dw: fix memory leak on error path)
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
v2: Correct Fixes tag and also add Baruch's Ack.
 drivers/spi/spi-dw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 8b7e4a3..712ac562 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -664,12 +664,6 @@ static int dw_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void dw_spi_cleanup(struct spi_device *spi)
-{
-	struct chip_data *chip = spi_get_ctldata(spi);
-	kfree(chip);
-}
-
 static int init_queue(struct dw_spi *dws)
 {
 	INIT_LIST_HEAD(&dws->queue);
@@ -799,7 +793,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
-	master->cleanup = dw_spi_cleanup;
 	master->setup = dw_spi_setup;
 	master->transfer = dw_spi_transfer;
 	master->max_speed_hz = dws->max_freq;
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
