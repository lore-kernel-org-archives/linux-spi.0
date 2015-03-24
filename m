From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/2] spi: pxa2xx: replace ugly table by approximation
Date: Tue, 24 Mar 2015 17:43:22 +0200
Message-ID: <1427211802-217454-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427211802-217454-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Quark SoC data sheet describes the baud rate setting using fractional
divider. The subset of possible values represented by a table suggests that the
divisor has one block that could divide by 5. This explains a satan number in
some cases in the table Thus, in this particular case the divisor can be
evaluated as

	5^i * 2^j * 2 * k,

where

	i = [0, 1]
	j = [0, 23]
	k = [1, 256]

There are few special cases as mentioned in the data sheet, i.e. better form of
the clock signal will be in case if DDS_CLK_RATE either 2^n or 2/5. It's also
possible to use any value that is less or equal to 0x33333 (1/5/16 = 1/80).

All three cases are compared to each other and the one that suits better is
chosen by approximation algorithm. Anyone can play with the script [1] that
represents the algorithm.

[1] https://gist.github.com/06b084488b3629898121

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 151 ++++++++++++++++++++++++++++-------------------
 1 file changed, 89 insertions(+), 62 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dd56bf5..6212802 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
@@ -67,54 +68,6 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_TX_LOTHRESH_DFLT	160
 #define LPSS_TX_HITHRESH_DFLT	224
 
-struct quark_spi_rate {
-	u32 bitrate;
-	u32 dds_clk_rate;
-	u32 clk_div;
-};
-
-/*
- * 'rate', 'dds', 'clk_div' lookup table, which is defined in
- * the Quark SPI datasheet.
- */
-static const struct quark_spi_rate quark_spi_rate_table[] = {
-/*	bitrate,	dds_clk_rate,	clk_div */
-	{50000000,	0x800000,	0},
-	{40000000,	0x666666,	0},
-	{25000000,	0x400000,	0},
-	{20000000,	0x666666,	1},
-	{16667000,	0x800000,	2},
-	{13333000,	0x666666,	2},
-	{12500000,	0x200000,	0},
-	{10000000,	0x800000,	4},
-	{8000000,	0x666666,	4},
-	{6250000,	0x400000,	3},
-	{5000000,	0x400000,	4},
-	{4000000,	0x666666,	9},
-	{3125000,	0x80000,	0},
-	{2500000,	0x400000,	9},
-	{2000000,	0x666666,	19},
-	{1563000,	0x40000,	0},
-	{1250000,	0x200000,	9},
-	{1000000,	0x400000,	24},
-	{800000,	0x666666,	49},
-	{781250,	0x20000,	0},
-	{625000,	0x200000,	19},
-	{500000,	0x400000,	49},
-	{400000,	0x666666,	99},
-	{390625,	0x10000,	0},
-	{250000,	0x400000,	99},
-	{200000,	0x666666,	199},
-	{195313,	0x8000,		0},
-	{125000,	0x100000,	49},
-	{100000,	0x200000,	124},
-	{50000,		0x100000,	124},
-	{25000,		0x80000,	124},
-	{10016,		0x20000,	77},
-	{5040,		0x20000,	154},
-	{1002,		0x8000,		194},
-};
-
 /* Offset from drv_data->lpss_base */
 #define GENERAL_REG		0x08
 #define GENERAL_REG_RXTO_HOLDOFF_DISABLE BIT(24)
@@ -701,25 +654,99 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 }
 
 /*
- * The Quark SPI data sheet gives a table, and for the given 'rate',
- * the 'dds' and 'clk_div' can be found in the table.
+ * The Quark SPI has an additional 24 bit register to multiply input frequency
+ * by fractions of 2^24. It also has a divider by 5.
+ *
+ * Fssp = Fsys * DDS_CLK_RATE / 2**24
+ * Baud rate = Fsclk = Fssp / (2 * (SCR + 1))
+ *
+ * DDS_CLK_RATE either 2^n or 2^n / 5.
+ * SCR is in range 0 .. 255
+ *
+ * Divisor = 5^i * 2^j * 2 * k
+ *       i = [0, 1]      i = 1 iff j = 0 or j > 3
+ *       j = [0, 23]     j = 0 iff i = 1
+ *       k = [1, 256]
+ * Special case: j = 0, i = 1: Divisor = 2 / 5
+ *
+ * We can also specify any value of DDS_CLK_RATE that is less or equal 1 / 80,
+ * i.e. 0x33333.
  */
-static u32 quark_x1000_set_clk_regvals(u32 rate, u32 *dds, u32 *clk_div)
+static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(quark_spi_rate_table); i++) {
-		if (rate >= quark_spi_rate_table[i].bitrate) {
-			*dds = quark_spi_rate_table[i].dds_clk_rate;
-			*clk_div = quark_spi_rate_table[i].clk_div;
-			return quark_spi_rate_table[i].bitrate;
+	/* Quark SoC has 200MHz xtal */
+	unsigned long xtal = 200000000, fref = xtal / 2;
+	/* Define two reference frequencies */
+	unsigned long fref1 = fref / 2, fref2 = fref * 2 / 5;
+	/* Keep quots and remainders for different cases here */
+	unsigned long q, q1, q2;
+	unsigned long scale;
+	long r, r1, r2;
+	u32 mul, mul1;
+
+	/* Set initial value for DDS_CLK_RATE */
+	mul1 = (1 << 24) >> 1;
+
+	/* Calculate initial quot */
+	q1 = DIV_ROUND_CLOSEST(fref1, rate);
+
+	/* Scale q1 if it's too big */
+	if (q1 > 256) {
+		/* Scale q1 to range [1, 512] */
+		scale = fls_long(q1 - 1);
+		if (scale > 9) {
+			q1 >>= scale - 9;
+			mul1 >>= scale - 9;
 		}
+
+		/* Round the result if we have a remainder */
+		q1 += q1 & 1;
 	}
 
-	*dds = quark_spi_rate_table[i-1].dds_clk_rate;
-	*clk_div = quark_spi_rate_table[i-1].clk_div;
+	/* Decrease DDS_CLK_RATE as much as we can without loss in precision */
+	scale = __ffs(q1);
+	q1 >>= scale;
+	mul1 >>= scale;
+
+	/* Get the remainder */
+	r1 = abs(fref1 / (1 << (24 - fls_long(mul1))) / q1 - rate);
+
+	q2 = DIV_ROUND_CLOSEST(fref2, rate);
+	r2 = abs(fref2 / q2 - rate);
+
+	/* Choose the best between two */
+	if (r2 >= r1 || q2 > 256) {
+		r = r1;
+		q = q1;
+		mul = mul1;
+	} else {
+		r = r2;
+		q = q2;
+		mul = (1 << 24) * 2 / 5;		/* 0x666666 */
+	}
+
+	/* In case the divisor is big enough */
+	if (fref / rate >= 80) {
+		u64 fssp;
+
+		/* Calculate initial quot */
+		q1 = DIV_ROUND_CLOSEST(fref, rate);
+		mul1 = (1 << 24) / q1;
+
+		/* Get the remainder */
+		fssp = (u64)fref * mul1;
+		do_div(fssp, 1 << 24);
+		r1 = abs(fssp - rate);
+
+		/* Choose this one if it suits better */
+		if (r1 < r) {
+			q = 1;
+			mul = mul1;
+		}
+	}
 
-	return quark_spi_rate_table[i-1].bitrate;
+	*dds = mul;
+	return q - 1;
 }
 
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
@@ -742,7 +769,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
-		quark_x1000_set_clk_regvals(rate, &chip->dds_rate, &clk_div);
+		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
 	default:
 		clk_div = ssp_get_clk_div(drv_data, rate);
 	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
