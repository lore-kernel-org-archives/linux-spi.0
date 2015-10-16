From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: choose closest lower speed" to the spi tree
Date: Fri, 16 Oct 2015 19:11:10 +0100
Message-ID: <E1Zn9TC-0003Ee-6p@debutante>
References: <1444304593-14669-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444304593-14669-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: choose closest lower speed

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3ad48062233f32a8dd2649403f5afc076710f86b Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 13 Oct 2015 17:09:14 +0300
Subject: [PATCH] spi: pxa2xx: choose closest lower speed

As per discussion [1] the best choice is to set closest speed which is not
going over the asked one.

Do the same approach for Intel Quark boards.

[1] http://www.spinics.net/lists/linux-spi/msg03389.html

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 22b473ebf607..158967a10bec 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -730,7 +730,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 	mul = (1 << 24) >> 1;
 
 	/* Calculate initial quot */
-	q1 = DIV_ROUND_CLOSEST(fref1, rate);
+	q1 = DIV_ROUND_UP(fref1, rate);
 
 	/* Scale q1 if it's too big */
 	if (q1 > 256) {
@@ -755,7 +755,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 	/* Case 2 */
 
-	q2 = DIV_ROUND_CLOSEST(fref2, rate);
+	q2 = DIV_ROUND_UP(fref2, rate);
 	r2 = abs(fref2 / q2 - rate);
 
 	/*
@@ -774,13 +774,13 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
