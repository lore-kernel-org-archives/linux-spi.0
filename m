From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/1] spi-pxa2xx: choose closest lower speed
Date: Thu,  8 Oct 2015 14:43:13 +0300
Message-ID: <1444304593-14669-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As per discussion [1] the best choice is to set closest speed which is not
going over the asked one.

Do the same approach for Intel Quark boards.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dee5b38..82493c2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -734,7 +734,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 	mul = (1 << 24) >> 1;
 
 	/* Calculate initial quot */
-	q1 = DIV_ROUND_CLOSEST(fref1, rate);
+	q1 = DIV_ROUND_UP(fref1, rate);
 
 	/* Scale q1 if it's too big */
 	if (q1 > 256) {
@@ -759,7 +759,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 	/* Case 2 */
 
-	q2 = DIV_ROUND_CLOSEST(fref2, rate);
+	q2 = DIV_ROUND_UP(fref2, rate);
 	r2 = abs(fref2 / q2 - rate);
 
 	/*
@@ -778,13 +778,13 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 		mul = (1 << 24) * 2 / 5;
 	}
 
-	/* Check case 3 only If the divisor is big enough */
+	/* Check case 3 only if the divisor is big enough */
 	if (fref / rate >= 80) {
 		u64 fssp;
 		u32 m;
 
 		/* Calculate initial quot */
-		q1 = DIV_ROUND_CLOSEST(fref, rate);
+		q1 = DIV_ROUND_UP(fref, rate);
 		m = (1 << 24) / q1;
 
 		/* Get the remainder */
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
