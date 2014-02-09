From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: txx9: Convert to let spi core handle checking
 transfer speed
Date: Sun, 09 Feb 2014 12:15:07 +0800
Message-ID: <1391919307.26425.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
checking transfer speed. Then we can remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-txx9.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
index 6191ced..523f13d 100644
--- a/drivers/spi/spi-txx9.c
+++ b/drivers/spi/spi-txx9.c
@@ -80,7 +80,6 @@ struct txx9spi {
 	void __iomem *membase;
 	int baseclk;
 	struct clk *clk;
-	u32 max_speed_hz, min_speed_hz;
 	int last_chipselect;
 	int last_chipselect_val;
 };
@@ -117,9 +116,7 @@ static int txx9spi_setup(struct spi_device *spi)
 {
 	struct txx9spi *c = spi_master_get_devdata(spi->master);
 
-	if (!spi->max_speed_hz
-			|| spi->max_speed_hz > c->max_speed_hz
-			|| spi->max_speed_hz < c->min_speed_hz)
+	if (!spi->max_speed_hz)
 		return -EINVAL;
 
 	if (gpio_direction_output(spi->chip_select,
@@ -309,15 +306,12 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
 
 	/* check each transfer's parameters */
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		u32 speed_hz = t->speed_hz ? : spi->max_speed_hz;
 		u8 bits_per_word = t->bits_per_word;
 
 		if (!t->tx_buf && !t->rx_buf && t->len)
 			return -EINVAL;
 		if (t->len & ((bits_per_word >> 3) - 1))
 			return -EINVAL;
-		if (speed_hz < c->min_speed_hz || speed_hz > c->max_speed_hz)
-			return -EINVAL;
 	}
 
 	spin_lock_irqsave(&c->lock, flags);
@@ -360,8 +354,8 @@ static int txx9spi_probe(struct platform_device *dev)
 		goto exit;
 	}
 	c->baseclk = clk_get_rate(c->clk);
-	c->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
-	c->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
+	master->min_speed_hz = DIV_ROUND_UP(c->baseclk, SPI_MAX_DIVIDER + 1);
+	master->max_speed_hz = c->baseclk / (SPI_MIN_DIVIDER + 1);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
