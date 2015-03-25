From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/1] spi: dw: fix crash on setup stage
Date: Wed, 25 Mar 2015 20:26:26 +0200
Message-ID: <1427307986-112219-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit 1a7b7ee72c21 (spi: Ensure that CS line is in non-active state after
spi_setup()) introduces an unconditional call of spi_set_cs() before ->setup().
The dw_spi_set_cs() relies on that fact that ->setup() is already called, but
it doesn't now. This patch fixes the crash by adding an additional check to
dw_spi_set_cs().

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index cafac22..8d67d03 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,7 +144,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	struct chip_data *chip = spi_get_ctldata(spi);
 
 	/* Chip select logic is inverted from spi_set_cs() */
-	if (chip->cs_control)
+	if (chip && chip->cs_control)
 		chip->cs_control(!enable);
 
 	if (!enable)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
