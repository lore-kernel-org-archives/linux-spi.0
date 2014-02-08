From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: ep93xx: Convert to let spi core handle checking
 transfer speed
Date: Sat, 08 Feb 2014 23:52:26 +0800
Message-ID: <1391874746.24507.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
checking transfer speed. So we can remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 1bfaed6..2f675d3 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -73,8 +73,6 @@
  * @clk: clock for the controller
  * @regs_base: pointer to ioremap()'d registers
  * @sspdr_phys: physical address of the SSPDR register
- * @min_rate: minimum clock rate (in Hz) supported by the controller
- * @max_rate: maximum clock rate (in Hz) supported by the controller
  * @wait: wait here until given transfer is completed
  * @current_msg: message that is currently processed (or %NULL if none)
  * @tx: current byte in transfer to transmit
@@ -95,8 +93,6 @@ struct ep93xx_spi {
 	struct clk			*clk;
 	void __iomem			*regs_base;
 	unsigned long			sspdr_phys;
-	unsigned long			min_rate;
-	unsigned long			max_rate;
 	struct completion		wait;
 	struct spi_message		*current_msg;
 	size_t				tx;
@@ -199,9 +195,9 @@ static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
  * @div_scr: pointer to return the scr divider
  */
 static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
-				    unsigned long rate,
-				    u8 *div_cpsr, u8 *div_scr)
+				    u32 rate, u8 *div_cpsr, u8 *div_scr)
 {
+	struct spi_master *master = platform_get_drvdata(espi->pdev);
 	unsigned long spi_clk_rate = clk_get_rate(espi->clk);
 	int cpsr, scr;
 
@@ -210,7 +206,7 @@ static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
 	 * controller. Note that minimum value is already checked in
 	 * ep93xx_spi_transfer_one_message().
 	 */
-	rate = clamp(rate, espi->min_rate, espi->max_rate);
+	rate = clamp(rate, master->min_speed_hz, master->max_speed_hz);
 
 	/*
 	 * Calculate divisors so that we can get speed according the
@@ -735,13 +731,6 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 					   struct spi_message *msg)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *t;
-
-	/* first validate each transfer */
-	list_for_each_entry(t, &msg->transfers, transfer_list) {
-		if (t->speed_hz < espi->min_rate)
-			return -EINVAL;
-	}
 
 	msg->state = NULL;
 	msg->status = 0;
@@ -917,8 +906,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	 * Calculate maximum and minimum supported clock rates
 	 * for the controller.
 	 */
-	espi->max_rate = clk_get_rate(espi->clk) / 2;
-	espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);
+	master->max_speed_hz = clk_get_rate(espi->clk) / 2;
+	master->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
 	espi->pdev = pdev;
 
 	espi->sspdr_phys = res->start + SSPDR;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
