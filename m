From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/2] spi: fsl-dspi: increase precision of baud rate approximation
Date: Thu,  2 Apr 2015 12:11:46 +0300
Message-ID: <1427965907-28125-2-git-send-email-andy.shevchenko@gmail.com>
References: <1427965907-28125-1-git-send-email-andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427965907-28125-1-git-send-email-andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The current approximation relies on scale comparison which is wrong in
two ways: a) the required scale doesn't take into consideration
remainder of the division, and b) minimal scale doesn't guarantee the
best approximation.

This patch change the approach to use comparison between remainders
instead of direct scale testing.

Signed-off-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 96cac87..31cdee5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -144,34 +144,24 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 {
 	/* Valid baud rate pre-scaler values */
 	int pbr_tbl[4] = {2, 3, 5, 7};
-	int brs[16] = {	2,	4,	6,	8,
+	int brs[16] = {
+		2,	4,	6,	8,
 		16,	32,	64,	128,
 		256,	512,	1024,	2048,
-		4096,	8192,	16384,	32768 };
-	int scale_needed, scale, minscale = INT_MAX;
+		4096,	8192,	16384,	32768,
+	};
+	unsigned long r = INT_MAX, tmp;
 	int i, j;
 
-	scale_needed = clkrate / speed_hz;
-
 	for (i = 0; i < ARRAY_SIZE(brs); i++)
 		for (j = 0; j < ARRAY_SIZE(pbr_tbl); j++) {
-			scale = brs[i] * pbr_tbl[j];
-			if (scale >= scale_needed) {
-				if (scale < minscale) {
-					minscale = scale;
-					*br = i;
-					*pbr = j;
-				}
-				break;
-			}
+			tmp = abs(clkrate / pbr_tbl[j] / brs[i] - speed_hz);
+			if (tmp >= r)
+				continue;
+			r = tmp;
+			*br = i;
+			*pbr = j;
 		}
-
-	if (minscale == INT_MAX) {
-		pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld, we use the max prescaler value.\n",
-			speed_hz, clkrate);
-		*pbr = ARRAY_SIZE(pbr_tbl) - 1;
-		*br =  ARRAY_SIZE(brs) - 1;
-	}
 }
 
 static int dspi_transfer_write(struct fsl_dspi *dspi)
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
