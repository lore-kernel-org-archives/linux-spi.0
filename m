From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 06/10] spi: dw: eliminate speed variable in ->transfer_one()
Date: Wed, 14 Oct 2015 23:12:21 +0300
Message-ID: <1444853545-59868-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no point to have a separate variable for speed in ->transfer_one().

While here, remove !chip->clk_div from a condition since it is assigned
simultaneously with chip->speed_hz. We can do this safely because
 a) transfer speed can't be higher than max_freq and therefore chip->clk_div
    can be 0 only when chip->speed_hz is 0, and
 b) transfer speed can't be 0, otherwise we will get division by zero
    exception.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f7e36db..5dae557 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -285,8 +285,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
-	u16 clk_div = 0;
-	u32 speed = 0;
+	u16 clk_div;
 	u32 cr0;
 	int ret;
 
@@ -301,14 +300,11 @@ static int dw_spi_transfer_one(struct spi_master *master,
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-	speed = chip->speed_hz;
-	if ((transfer->speed_hz != speed) || !chip->clk_div) {
-		speed = transfer->speed_hz;
-
+	if (transfer->speed_hz != chip->speed_hz) {
 		/* clk_div doesn't support odd number */
-		clk_div = (dws->max_freq / speed + 1) & 0xfffe;
+		clk_div = (dws->max_freq / transfer->speed_hz + 1) & 0xfffe;
 
-		chip->speed_hz = speed;
+		chip->speed_hz = transfer->speed_hz;
 		chip->clk_div = clk_div;
 
 		spi_set_clk(dws, chip->clk_div);
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
