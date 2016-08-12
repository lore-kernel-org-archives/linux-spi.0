From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/PROTO 9/9 option 3] spi: sh-msiof: Configure MSIOF parent clock
Date: Fri, 12 Aug 2016 18:38:45 +0200
Message-ID: <1471019925-29083-10-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Change the clock rate in spi_master.setup() to accomodate the desired
maximum clock rate for the device being set up.
Use clk-fixed on a fake clock behaving like the internal MSIOF divider.
Setting the rate of the fake clock will make clk-fixed find an optimal
rate for the mso clock, with an optimal internal msiof divider.

Results (sequential operations during probing):
  1. msiof0 (and mso) set to 400 MHz, msiof0-div at 28.6 MHz
  2. msiof2 (and mso) set to 8 MHz, msiof2-div at 1 MHz
  3. msiof3 kept at 8 MHz, msiof3-div at 20 kHz

Observations:
  - The algorithm used by clk-fixed does find a better clock, closer
    to the target rate,
  - However, mso clock rates are really high,
  - Despite calling clk_set_rate_range() on each msiofX clock,
    clk_set_rate() on another msiofX clock may reprogram mso to
    violate the set constraints.  Hence at the end the mso clock runs
    at only 8 MHz, which is suboptimal.
  - The parent clock frequency cannot be changed while the mso clock
    is enabled. This is tricky, as the MSIOF modules are part of a
    Clock Domain, hence their clocks (and its parent clock) are under
    control of Runtime PM.
    So the parent clock may still be enabled due to asynchronous
    runtime-suspend not having disabled it yet, causing clk_set_rate()
    to fail sometimes with -EBUSY.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Not intended for upstream merge.
---
 drivers/spi/spi-sh-msiof.c | 198 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 656eaa4d03ed497b..c13420888f86371f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -44,6 +45,7 @@ struct sh_msiof_spi_priv {
 	struct spi_master *master;
 	void __iomem *mapbase;
 	struct clk *clk;
+	struct clk *div_clk;
 	struct platform_device *pdev;
 	struct sh_msiof_spi_info *info;
 	struct completion done;
@@ -579,6 +581,194 @@ static int sh_msiof_clk_notifier_cb(struct notifier_block *nb,
 	}
 }
 
+static const struct clk_div_table sh_misof_div_clk_table[] = {
+	{ .div =  1 *  1,	.val = SCR_BRDV_DIV_1  | SCR_BRPS( 1) },
+	{ .div =  1 *  2,	.val = SCR_BRDV_DIV_1  | SCR_BRPS( 2) },
+
+	{ .div =  2 *  1,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 1) },
+	{ .div =  2 *  2,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 2) },
+	{ .div =  2 *  3,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 3) },
+	{ .div =  2 *  4,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 4) },
+	{ .div =  2 *  5,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 5) },
+	{ .div =  2 *  6,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 6) },
+	{ .div =  2 *  7,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 7) },
+	{ .div =  2 *  8,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 8) },
+	{ .div =  2 *  9,	.val = SCR_BRDV_DIV_2  | SCR_BRPS( 9) },
+	{ .div =  2 * 10,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(10) },
+	{ .div =  2 * 11,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(11) },
+	{ .div =  2 * 12,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(12) },
+	{ .div =  2 * 13,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(13) },
+	{ .div =  2 * 14,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(14) },
+	{ .div =  2 * 15,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(15) },
+	{ .div =  2 * 16,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(16) },
+	{ .div =  2 * 17,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(17) },
+	{ .div =  2 * 18,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(18) },
+	{ .div =  2 * 19,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(19) },
+	{ .div =  2 * 20,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(20) },
+	{ .div =  2 * 21,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(21) },
+	{ .div =  2 * 22,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(22) },
+	{ .div =  2 * 23,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(23) },
+	{ .div =  2 * 24,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(24) },
+	{ .div =  2 * 25,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(25) },
+	{ .div =  2 * 26,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(26) },
+	{ .div =  2 * 27,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(27) },
+	{ .div =  2 * 28,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(28) },
+	{ .div =  2 * 29,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(29) },
+	{ .div =  2 * 30,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(30) },
+	{ .div =  2 * 31,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(31) },
+	{ .div =  2 * 32,	.val = SCR_BRDV_DIV_2  | SCR_BRPS(32) },
+
+	{ .div =  4 *  1,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 1) },
+	{ .div =  4 *  2,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 2) },
+	{ .div =  4 *  3,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 3) },
+	{ .div =  4 *  4,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 4) },
+	{ .div =  4 *  5,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 5) },
+	{ .div =  4 *  6,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 6) },
+	{ .div =  4 *  7,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 7) },
+	{ .div =  4 *  8,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 8) },
+	{ .div =  4 *  9,	.val = SCR_BRDV_DIV_4  | SCR_BRPS( 9) },
+	{ .div =  4 * 10,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(10) },
+	{ .div =  4 * 11,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(11) },
+	{ .div =  4 * 12,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(12) },
+	{ .div =  4 * 13,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(13) },
+	{ .div =  4 * 14,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(14) },
+	{ .div =  4 * 15,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(15) },
+	{ .div =  4 * 16,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(16) },
+	{ .div =  4 * 17,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(17) },
+	{ .div =  4 * 18,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(18) },
+	{ .div =  4 * 19,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(19) },
+	{ .div =  4 * 20,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(20) },
+	{ .div =  4 * 21,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(21) },
+	{ .div =  4 * 22,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(22) },
+	{ .div =  4 * 23,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(23) },
+	{ .div =  4 * 24,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(24) },
+	{ .div =  4 * 25,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(25) },
+	{ .div =  4 * 26,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(26) },
+	{ .div =  4 * 27,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(27) },
+	{ .div =  4 * 28,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(28) },
+	{ .div =  4 * 29,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(29) },
+	{ .div =  4 * 30,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(30) },
+	{ .div =  4 * 31,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(31) },
+	{ .div =  4 * 32,	.val = SCR_BRDV_DIV_4  | SCR_BRPS(32) },
+
+	{ .div =  8 *  1,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 1) },
+	{ .div =  8 *  2,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 2) },
+	{ .div =  8 *  3,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 3) },
+	{ .div =  8 *  4,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 4) },
+	{ .div =  8 *  5,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 5) },
+	{ .div =  8 *  6,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 6) },
+	{ .div =  8 *  7,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 7) },
+	{ .div =  8 *  8,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 8) },
+	{ .div =  8 *  9,	.val = SCR_BRDV_DIV_8  | SCR_BRPS( 9) },
+	{ .div =  8 * 10,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(10) },
+	{ .div =  8 * 11,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(11) },
+	{ .div =  8 * 12,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(12) },
+	{ .div =  8 * 13,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(13) },
+	{ .div =  8 * 14,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(14) },
+	{ .div =  8 * 15,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(15) },
+	{ .div =  8 * 16,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(16) },
+	{ .div =  8 * 17,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(17) },
+	{ .div =  8 * 18,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(18) },
+	{ .div =  8 * 19,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(19) },
+	{ .div =  8 * 20,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(20) },
+	{ .div =  8 * 21,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(21) },
+	{ .div =  8 * 22,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(22) },
+	{ .div =  8 * 23,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(23) },
+	{ .div =  8 * 24,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(24) },
+	{ .div =  8 * 25,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(25) },
+	{ .div =  8 * 26,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(26) },
+	{ .div =  8 * 27,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(27) },
+	{ .div =  8 * 28,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(28) },
+	{ .div =  8 * 29,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(29) },
+	{ .div =  8 * 30,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(30) },
+	{ .div =  8 * 31,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(31) },
+	{ .div =  8 * 32,	.val = SCR_BRDV_DIV_8  | SCR_BRPS(32) },
+
+	{ .div = 16 *  1,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 1) },
+	{ .div = 16 *  2,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 2) },
+	{ .div = 16 *  3,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 3) },
+	{ .div = 16 *  4,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 4) },
+	{ .div = 16 *  5,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 5) },
+	{ .div = 16 *  6,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 6) },
+	{ .div = 16 *  7,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 7) },
+	{ .div = 16 *  8,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 8) },
+	{ .div = 16 *  9,	.val = SCR_BRDV_DIV_16 | SCR_BRPS( 9) },
+	{ .div = 16 * 10,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(10) },
+	{ .div = 16 * 11,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(11) },
+	{ .div = 16 * 12,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(12) },
+	{ .div = 16 * 13,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(13) },
+	{ .div = 16 * 14,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(14) },
+	{ .div = 16 * 15,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(15) },
+	{ .div = 16 * 16,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(16) },
+	{ .div = 16 * 17,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(17) },
+	{ .div = 16 * 18,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(18) },
+	{ .div = 16 * 19,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(19) },
+	{ .div = 16 * 20,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(20) },
+	{ .div = 16 * 21,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(21) },
+	{ .div = 16 * 22,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(22) },
+	{ .div = 16 * 23,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(23) },
+	{ .div = 16 * 24,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(24) },
+	{ .div = 16 * 25,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(25) },
+	{ .div = 16 * 26,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(26) },
+	{ .div = 16 * 27,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(27) },
+	{ .div = 16 * 28,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(28) },
+	{ .div = 16 * 29,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(29) },
+	{ .div = 16 * 30,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(30) },
+	{ .div = 16 * 31,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(31) },
+	{ .div = 16 * 32,	.val = SCR_BRDV_DIV_16 | SCR_BRPS(32) },
+
+	{ .div = 32 *  1,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 1) },
+	{ .div = 32 *  2,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 2) },
+	{ .div = 32 *  3,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 3) },
+	{ .div = 32 *  4,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 4) },
+	{ .div = 32 *  5,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 5) },
+	{ .div = 32 *  6,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 6) },
+	{ .div = 32 *  7,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 7) },
+	{ .div = 32 *  8,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 8) },
+	{ .div = 32 *  9,	.val = SCR_BRDV_DIV_32 | SCR_BRPS( 9) },
+	{ .div = 32 * 10,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(10) },
+	{ .div = 32 * 11,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(11) },
+	{ .div = 32 * 12,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(12) },
+	{ .div = 32 * 13,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(13) },
+	{ .div = 32 * 14,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(14) },
+	{ .div = 32 * 15,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(15) },
+	{ .div = 32 * 16,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(16) },
+	{ .div = 32 * 17,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(17) },
+	{ .div = 32 * 18,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(18) },
+	{ .div = 32 * 19,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(19) },
+	{ .div = 32 * 20,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(20) },
+	{ .div = 32 * 21,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(21) },
+	{ .div = 32 * 22,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(22) },
+	{ .div = 32 * 23,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(23) },
+	{ .div = 32 * 24,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(24) },
+	{ .div = 32 * 25,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(25) },
+	{ .div = 32 * 26,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(26) },
+	{ .div = 32 * 27,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(27) },
+	{ .div = 32 * 28,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(28) },
+	{ .div = 32 * 29,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(29) },
+	{ .div = 32 * 30,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(30) },
+	{ .div = 32 * 31,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(31) },
+	{ .div = 32 * 32,	.val = SCR_BRDV_DIV_32 | SCR_BRPS(32) },
+
+	{ .div = 0,	.val = 0 },
+};
+
+static void sh_msiof_register_div_clk(struct sh_msiof_spi_priv *p)
+{
+	char parent_name[16], name[16];
+
+	snprintf(parent_name, sizeof(parent_name), "%pC", p->clk);
+	snprintf(name, sizeof(name), "%pC-div", p->clk);
+
+	p->div_clk = clk_register_divider_table(NULL, name, parent_name,
+						CLK_SET_RATE_PARENT, NULL, 0,
+						16, 0, sh_misof_div_clk_table,
+						NULL);
+	if (IS_ERR(p->div_clk))
+		pr_err("clk_register_divider_table %s failed: %ld\n", name,
+		       PTR_ERR(p->div_clk));
+}
+
 static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
@@ -594,6 +784,12 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		 "%s: master speed min %u max %u, device speed max = %u\n",
 		 __func__, min_speed_hz, max_speed_hz, spi->max_speed_hz);
 
+	clk_set_rate(p->div_clk, spi->max_speed_hz);
+	/* Set lower bound to 80% of desired rate */
+	clk_set_rate_range(p->div_clk, spi->max_speed_hz * 4 / 5,
+			   spi->max_speed_hz);
+	pr_info("%pC at %pCr, %pC at %pCr\n", p->clk, p->clk, p->div_clk, p->div_clk);
+
 	p->dev_max_speed_hz = spi->max_speed_hz;
 
 	pm_runtime_get_sync(&p->pdev->dev);
@@ -1322,6 +1518,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (clk_notifier_register(p->clk, &p->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
 
+	sh_msiof_register_div_clk(p);
+
 	/* Platform data may override FIFO sizes */
 	p->tx_fifo_size = chipdata->tx_fifo_size;
 	p->rx_fifo_size = chipdata->rx_fifo_size;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
