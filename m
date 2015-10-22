From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/7] spi: pxa2xx: derive struct chip_data from struct drv_data
Date: Thu, 22 Oct 2015 16:44:40 +0300
Message-ID: <1445521485-2029-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Since we call pxa2xx_ssp_get_clk_div() from pump_transfers() we may derive
pointer to struct chip_data from struct drv_data like it's done in the rest
of the functions. This will make it less errorprone.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 573a28b13a09..e02ea46168eb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -818,8 +818,9 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
-					   struct chip_data *chip, int rate)
+					   int rate)
 {
+	struct chip_data *chip = drv_data->cur_chip;
 	unsigned int clk_div;
 
 	switch (drv_data->ssp_type) {
@@ -925,7 +926,7 @@ static void pump_transfers(unsigned long data)
 	bits = transfer->bits_per_word;
 	speed = transfer->speed_hz;
 
-	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, speed);
+	clk_div = pxa2xx_ssp_get_clk_div(drv_data, speed);
 
 	if (bits <= 8) {
 		drv_data->n_bytes = 1;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
