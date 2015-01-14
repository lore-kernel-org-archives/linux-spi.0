From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Date: Wed, 14 Jan 2015 16:25:35 +0900
Message-ID: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
	yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

sh-msiof of frequency dividing does not perform the calculation, driver have
to manage setting value in the table. It is not possible to set frequency
dividing value close to the actual data in this way. This changes from
frequency dividing of table management to setting by calculation.
This driver is able to set a value close to the actual data.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 96a5fc0..58b1bfe 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -241,42 +241,37 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 
 static struct {
 	unsigned short div;
-	unsigned short scr;
-} const sh_msiof_spi_clk_table[] = {
-	{ 1,	SCR_BRPS( 1) | SCR_BRDV_DIV_1 },
-	{ 2,	SCR_BRPS( 1) | SCR_BRDV_DIV_2 },
-	{ 4,	SCR_BRPS( 1) | SCR_BRDV_DIV_4 },
-	{ 8,	SCR_BRPS( 1) | SCR_BRDV_DIV_8 },
-	{ 16,	SCR_BRPS( 1) | SCR_BRDV_DIV_16 },
-	{ 32,	SCR_BRPS( 1) | SCR_BRDV_DIV_32 },
-	{ 64,	SCR_BRPS(32) | SCR_BRDV_DIV_2 },
-	{ 128,	SCR_BRPS(32) | SCR_BRDV_DIV_4 },
-	{ 256,	SCR_BRPS(32) | SCR_BRDV_DIV_8 },
-	{ 512,	SCR_BRPS(32) | SCR_BRDV_DIV_16 },
-	{ 1024,	SCR_BRPS(32) | SCR_BRDV_DIV_32 },
+	unsigned short brdv;
+} const sh_msiof_spi_div_table[] = {
+	{ 1,	SCR_BRDV_DIV_1 },
+	{ 2,	SCR_BRDV_DIV_2 },
+	{ 4,	SCR_BRDV_DIV_4 },
+	{ 8,	SCR_BRDV_DIV_8 },
+	{ 16,	SCR_BRDV_DIV_16 },
+	{ 32,	SCR_BRDV_DIV_32 },
 };
 
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 				      unsigned long parent_rate, u32 spi_hz)
 {
 	unsigned long div = 1024;
+	unsigned long brps, scr;
 	size_t k;
 
 	if (!WARN_ON(!spi_hz || !parent_rate))
 		div = DIV_ROUND_UP(parent_rate, spi_hz);
 
-	/* TODO: make more fine grained */
-
-	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_clk_table); k++) {
-		if (sh_msiof_spi_clk_table[k].div >= div)
-			break;
+	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
+		brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
+		if (brps > 32) /* max of brsv is 32 */
+			continue;
+		break;
 	}
 
-	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
-
-	sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
+	scr = sh_msiof_spi_div_table[k].brdv | (brps -1) << 8;
+	sh_msiof_write(p, TSCR, scr);
 	if (!(p->chipdata->master_flags & SPI_MASTER_MUST_TX))
-		sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
+		sh_msiof_write(p, RSCR, scr);
 }
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
