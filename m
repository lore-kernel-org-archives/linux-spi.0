From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Move SSP idle waiting to cs_deassert()
Date: Fri,  9 Feb 2018 16:31:07 +0200
Message-ID: <20180209143107.16671-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Move SSP idle waiting before CS deassert from error and end of message
handling function giveback() to cs_deassert(). This ensures idle waiting
is done also if there is CS change between transfers.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 487a6f1067c9..713506eff07d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -415,10 +415,17 @@ static void cs_deassert(struct driver_data *drv_data)
 {
 	struct chip_data *chip =
 		spi_get_ctldata(drv_data->master->cur_msg->spi);
+	unsigned long timeout;
 
 	if (drv_data->ssp_type == CE4100_SSP)
 		return;
 
+	/* Wait until SSP becomes idle before deasserting the CS */
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY &&
+	       !time_after(jiffies, timeout))
+		cpu_relax();
+
 	if (chip->cs_control) {
 		chip->cs_control(PXA2XX_CS_DEASSERT);
 		return;
@@ -563,7 +570,6 @@ static void giveback(struct driver_data *drv_data)
 {
 	struct spi_transfer* last_transfer;
 	struct spi_message *msg;
-	unsigned long timeout;
 
 	msg = drv_data->master->cur_msg;
 	drv_data->cur_transfer = NULL;
@@ -575,12 +581,6 @@ static void giveback(struct driver_data *drv_data)
 	if (last_transfer->delay_usecs)
 		udelay(last_transfer->delay_usecs);
 
-	/* Wait until SSP becomes idle before deasserting the CS */
-	timeout = jiffies + msecs_to_jiffies(10);
-	while (pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY &&
-	       !time_after(jiffies, timeout))
-		cpu_relax();
-
 	/* Drop chip select UNLESS cs_change is true or we are returning
 	 * a message with an error, or next message is for another chip
 	 */
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
