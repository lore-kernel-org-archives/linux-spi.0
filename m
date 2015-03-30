From: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] spi: fsl-dspi: Fix clock rate scale values
Date: Mon, 30 Mar 2015 10:49:15 -0700
Message-ID: <1427737756-20487-2-git-send-email-aaron.brice@datasoft.com>
References: <1427737756-20487-1-git-send-email-aaron.brice@datasoft.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427737756-20487-1-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Previous algorithm had an outer loop with the values {2,3,5,7} and an
inner loop with {2,4,6,8,16,32,...,32768}, and would pick the first
value over the required scaling value (where the total scale was the two
numbers multiplied).

Since the inner loop went up to 32768 it would always pick a value of 2
for PBR and a much higher than necessary value for BR.  The desired
scale factor was being divided by two I believe to compensate for the
much higher scale factors (the divide by two not specified in the
reference manual).

Updated to check all values and find the smallest scale factor possible
without going over the desired clock rate.

Signed-off-by: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d1a3924..96cac87 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -148,23 +148,30 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 		16,	32,	64,	128,
 		256,	512,	1024,	2048,
 		4096,	8192,	16384,	32768 };
-	int temp, i = 0, j = 0;
-
-	temp = clkrate / 2 / speed_hz;
-
-	for (i = 0; i < ARRAY_SIZE(pbr_tbl); i++)
-		for (j = 0; j < ARRAY_SIZE(brs); j++) {
-			if (pbr_tbl[i] * brs[j] >= temp) {
-				*pbr = i;
-				*br = j;
-				return;
+	int scale_needed, scale, minscale = INT_MAX;
+	int i, j;
+
+	scale_needed = clkrate / speed_hz;
+
+	for (i = 0; i < ARRAY_SIZE(brs); i++)
+		for (j = 0; j < ARRAY_SIZE(pbr_tbl); j++) {
+			scale = brs[i] * pbr_tbl[j];
+			if (scale >= scale_needed) {
+				if (scale < minscale) {
+					minscale = scale;
+					*br = i;
+					*pbr = j;
+				}
+				break;
 			}
 		}
 
-	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld\
-		,we use the max prescaler value.\n", speed_hz, clkrate);
-	*pbr = ARRAY_SIZE(pbr_tbl) - 1;
-	*br =  ARRAY_SIZE(brs) - 1;
+	if (minscale == INT_MAX) {
+		pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld, we use the max prescaler value.\n",
+			speed_hz, clkrate);
+		*pbr = ARRAY_SIZE(pbr_tbl) - 1;
+		*br =  ARRAY_SIZE(brs) - 1;
+	}
 }
 
 static int dspi_transfer_write(struct fsl_dspi *dspi)
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
