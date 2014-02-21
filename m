From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] spi: dup: Convert ot let spi core handle checking
 transfer speed
Date: Fri, 21 Feb 2014 09:12:15 +0800
Message-ID: <1392945135.4125.3.camel@phoenix>
References: <1392945066.4125.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392945066.4125.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set master->max_speed_hz then spi core will handle checking transfer speed.
So we can remove the same checking in this driver.

Also remove checking spi->chip_select in spi_qup_setup(), the checking is done
by spi core.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-qup.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 5edc56f..dec339d 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -134,7 +134,6 @@ struct spi_qup {
 	struct clk		*cclk;	/* core clock */
 	struct clk		*iclk;	/* interface clock */
 	int			irq;
-	u32			max_speed_hz;
 	spinlock_t		lock;
 
 	int			in_fifo_sz;
@@ -517,18 +516,6 @@ static int spi_qup_setup(struct spi_device *spi)
 	struct spi_qup *controller = spi_master_get_devdata(spi->master);
 	struct spi_qup_device *chip = spi_get_ctldata(spi);
 
-	if (spi->chip_select >= spi->master->num_chipselect) {
-		dev_err(controller->dev, "invalid chip_select %d\n",
-			spi->chip_select);
-		return -EINVAL;
-	}
-
-	if (spi->max_speed_hz > controller->max_speed_hz) {
-		dev_err(controller->dev, "invalid max_speed_hz %d\n",
-			spi->max_speed_hz);
-		return -EINVAL;
-	}
-
 	if (!chip) {
 		/* First setup */
 		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -629,6 +616,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->num_chipselect = SPI_NUM_CHIPSELECTS;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	master->max_speed_hz = max_freq;
 	master->setup = spi_qup_setup;
 	master->cleanup = spi_qup_cleanup;
 	master->set_cs = spi_qup_set_cs;
@@ -645,7 +633,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->iclk = iclk;
 	controller->cclk = cclk;
 	controller->irq = irq;
-	controller->max_speed_hz = max_freq;
 
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
