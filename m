From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: Limit minimum divider on R-Car Gen3" to the spi tree
Date: Mon, 17 Jul 2017 17:06:56 +0100
Message-ID: <E1dX8Xw-0005GJ-FP@debutante>
References: <1499855161-20518-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499855161-20518-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: Limit minimum divider on R-Car Gen3

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

>From 61a8dec502b873879fa240ec7614601523b46a43 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Wed, 12 Jul 2017 12:26:01 +0200
Subject: [PATCH] spi: sh-msiof: Limit minimum divider on R-Car Gen3

On R-Car Gen3 SoCs (excluding R-Car H3 ES1.x, which cannot be used for
SPI due to a hardware erratum), BRPS x BRDV = 1/1 is an invalid divider
setting.
Implement this limitation using an SoC/family-specific minimum divider.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index c304c7167866..0eb1e9583485 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -38,6 +38,7 @@ struct sh_msiof_chipdata {
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
 	u16 master_flags;
+	u16 min_div;
 };
 
 struct sh_msiof_spi_priv {
@@ -49,6 +50,7 @@ struct sh_msiof_spi_priv {
 	struct completion done;
 	unsigned int tx_fifo_size;
 	unsigned int rx_fifo_size;
+	unsigned int min_div;
 	void *tx_dma_page;
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
@@ -261,6 +263,8 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 	if (!WARN_ON(!spi_hz || !parent_rate))
 		div = DIV_ROUND_UP(parent_rate, spi_hz);
 
+	div = max_t(unsigned long, div, p->min_div);
+
 	for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
 		brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
 		/* SCR_BRDV_DIV_1 is valid only if BRPS is x 1/1 or x 1/2 */
@@ -998,24 +1002,33 @@ static const struct sh_msiof_chipdata sh_data = {
 	.tx_fifo_size = 64,
 	.rx_fifo_size = 64,
 	.master_flags = 0,
+	.min_div = 1,
+};
+
+static const struct sh_msiof_chipdata rcar_gen2_data = {
+	.tx_fifo_size = 64,
+	.rx_fifo_size = 64,
+	.master_flags = SPI_MASTER_MUST_TX,
+	.min_div = 1,
 };
 
-static const struct sh_msiof_chipdata r8a779x_data = {
+static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.tx_fifo_size = 64,
 	.rx_fifo_size = 64,
 	.master_flags = SPI_MASTER_MUST_TX,
+	.min_div = 2,
 };
 
 static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
-	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
-	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
-	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
-	{ .compatible = "renesas,msiof-r8a7793",   .data = &r8a779x_data },
-	{ .compatible = "renesas,msiof-r8a7794",   .data = &r8a779x_data },
-	{ .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
-	{ .compatible = "renesas,msiof-r8a7796",   .data = &r8a779x_data },
-	{ .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7790",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7791",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7792",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
+	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
 	{},
 };
@@ -1230,6 +1243,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 	p->master = master;
 	p->info = info;
+	p->min_div = chipdata->min_div;
 
 	init_completion(&p->done);
 
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
