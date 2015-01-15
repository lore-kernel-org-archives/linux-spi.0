From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH v2] spi: sh-msiof: Update calculation of frequency dividing
Date: Thu, 15 Jan 2015 10:50:13 +0900
Message-ID: <1421286613-8240-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
	geert@glider.be, yoshihiro.shimoda.uh@renesas.com,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

sh-msiof of frequency dividing does not perform the calculation, driver have
to manage setting value in the table. It is not possible to set frequency
dividing value close to the actual data in this way. This changes from
frequency dividing of table management to setting by calculation.
This driver is able to set a value close to the actual data.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 V2:
   - use u32 instead of unsigned long.
   - Fix loop.
   - Use SCR_BRPS instead of hoard code shift.
   - Add check of div maximum value.

 drivers/spi/spi-sh-msiof.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 96a5fc0..545ffff 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -241,42 +241,41 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 
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
 
-static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
+static int sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 				      unsigned long parent_rate, u32 spi_hz)
 {
 	unsigned long div = 1024;
+	u32 brps, scr;
 	size_t k;
 
 	if (!WARN_ON(!spi_hz || !parent_rate))
 		div = DIV_ROUND_UP(parent_rate, spi_hz);
 
-	/* TODO: make more fine grained */
+	if (div > 1024) /* Max of divider is 1024 */
+		return -EINVAL;
 
-	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_clk_table); k++) {
-		if (sh_msiof_spi_clk_table[k].div >= div)
+	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
+		brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
+		if (brps <= 32) /* max of brdv is 32 */
 			break;
 	}
 
-	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
-
-	sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
+	scr = sh_msiof_spi_div_table[k].brdv | SCR_BRPS(brps);
+	sh_msiof_write(p, TSCR, scr);
 	if (!(p->chipdata->master_flags & SPI_MASTER_MUST_TX))
-		sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
+		sh_msiof_write(p, RSCR, scr);
+
+	return 0;
 }
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
@@ -804,7 +803,9 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	int ret;
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+	ret = sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+	if (ret)
+		return ret;
 
 	while (master->dma_tx && len > 15) {
 		/*
-- 
2.1.3

