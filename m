From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: au1550: Convert to let spi core handle checking
 transfer speed
Date: Tue, 11 Feb 2014 20:49:07 +0800
Message-ID: <1392122947.1351.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
checking transfer speed. So we can remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-au1550.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index c4141c9..aafb812 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -55,8 +55,6 @@ struct au1550_spi {
 
 	volatile psc_spi_t __iomem *regs;
 	int irq;
-	unsigned freq_max;
-	unsigned freq_min;
 
 	unsigned len;
 	unsigned tx_count;
@@ -248,11 +246,8 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 			hz = t->speed_hz;
 	}
 
-	if (hz > spi->max_speed_hz || hz > hw->freq_max || hz < hw->freq_min) {
-		dev_err(&spi->dev, "setupxfer: clock rate=%d out of range\n",
-			hz);
+	if (!hz)
 		return -EINVAL;
-	}
 
 	au1550_spi_bits_handlers_set(hw, spi->bits_per_word);
 
@@ -287,23 +282,6 @@ static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	return 0;
 }
 
-static int au1550_spi_setup(struct spi_device *spi)
-{
-	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
-
-	if (spi->max_speed_hz == 0)
-		spi->max_speed_hz = hw->freq_max;
-	if (spi->max_speed_hz > hw->freq_max
-			|| spi->max_speed_hz < hw->freq_min)
-		return -EINVAL;
-	/*
-	 * NOTE: cannot change speed and other hw settings immediately,
-	 *       otherwise sharing of spi bus is not possible,
-	 *       so do not call setupxfer(spi, NULL) here
-	 */
-	return 0;
-}
-
 /*
  * for dma spi transfers, we have to setup rx channel, otherwise there is
  * no reliable way how to recognize that spi transfer is done
@@ -838,7 +816,6 @@ static int au1550_spi_probe(struct platform_device *pdev)
 	hw->bitbang.master = hw->master;
 	hw->bitbang.setup_transfer = au1550_spi_setupxfer;
 	hw->bitbang.chipselect = au1550_spi_chipsel;
-	hw->bitbang.master->setup = au1550_spi_setup;
 	hw->bitbang.txrx_bufs = au1550_spi_txrx_bufs;
 
 	if (hw->usedma) {
@@ -909,8 +886,9 @@ static int au1550_spi_probe(struct platform_device *pdev)
 	{
 		int min_div = (2 << 0) * (2 * (4 + 1));
 		int max_div = (2 << 3) * (2 * (63 + 1));
-		hw->freq_max = hw->pdata->mainclk_hz / min_div;
-		hw->freq_min = hw->pdata->mainclk_hz / (max_div + 1) + 1;
+		master->max_speed_hz = hw->pdata->mainclk_hz / min_div;
+		master->min_speed_hz =
+				hw->pdata->mainclk_hz / (max_div + 1) + 1;
 	}
 
 	au1550_spi_setup_psc_as_spi(hw);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
