From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: Remove sh_msiof_spi_priv.chipdata" to the spi tree
Date: Wed, 22 Jun 2016 16:29:11 +0100
Message-ID: <E1bFk5X-0002UL-6i@debutante>
References: <1466599803-2965-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466599803-2965-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: Remove sh_msiof_spi_priv.chipdata

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

>From a6802cc05f9e48e86bc3f9f056c74a69dc5e37fa Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Wed, 22 Jun 2016 14:50:03 +0200
Subject: [PATCH] spi: sh-msiof: Remove sh_msiof_spi_priv.chipdata

After probe time, the pointer to the sh_msiof_chipdata structure in the
sh_msiof_spi_priv structure is used only for checking the SPI master flags.
As these are also available in the spi_master structure, convert the
users to access those, and remove the pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index a7934ab00b96..0f83ad1d5a58 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -45,7 +45,6 @@ struct sh_msiof_spi_priv {
 	void __iomem *mapbase;
 	struct clk *clk;
 	struct platform_device *pdev;
-	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct completion done;
 	unsigned int tx_fifo_size;
@@ -271,7 +270,7 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 	scr = sh_msiof_spi_div_table[k].brdv | SCR_BRPS(brps);
 	sh_msiof_write(p, TSCR, scr);
-	if (!(p->chipdata->master_flags & SPI_MASTER_MUST_TX))
+	if (!(p->master->flags & SPI_MASTER_MUST_TX))
 		sh_msiof_write(p, RSCR, scr);
 }
 
@@ -336,7 +335,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	tmp |= lsb_first << MDR1_BITLSB_SHIFT;
 	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
 	sh_msiof_write(p, TMDR1, tmp | MDR1_TRMD | TMDR1_PCON);
-	if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
+	if (p->master->flags & SPI_MASTER_MUST_TX) {
 		/* These bits are reserved if RX needs TX */
 		tmp &= ~0x0000ffff;
 	}
@@ -360,7 +359,7 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 {
 	u32 dr2 = MDR2_BITLEN1(bits) | MDR2_WDLEN1(words);
 
-	if (tx_buf || (p->chipdata->master_flags & SPI_MASTER_MUST_TX))
+	if (tx_buf || (p->master->flags & SPI_MASTER_MUST_TX))
 		sh_msiof_write(p, TMDR2, dr2);
 	else
 		sh_msiof_write(p, TMDR2, dr2 | MDR2_GRPMASK1);
@@ -1152,6 +1151,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
 	struct spi_master *master;
+	const struct sh_msiof_chipdata *chipdata;
 	const struct of_device_id *of_id;
 	struct sh_msiof_spi_priv *p;
 	int i;
@@ -1170,10 +1170,10 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(sh_msiof_match, &pdev->dev);
 	if (of_id) {
-		p->chipdata = of_id->data;
+		chipdata = of_id->data;
 		p->info = sh_msiof_spi_parse_dt(&pdev->dev);
 	} else {
-		p->chipdata = (const void *)pdev->id_entry->driver_data;
+		chipdata = (const void *)pdev->id_entry->driver_data;
 		p->info = dev_get_platdata(&pdev->dev);
 	}
 
@@ -1217,8 +1217,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	/* Platform data may override FIFO sizes */
-	p->tx_fifo_size = p->chipdata->tx_fifo_size;
-	p->rx_fifo_size = p->chipdata->rx_fifo_size;
+	p->tx_fifo_size = chipdata->tx_fifo_size;
+	p->rx_fifo_size = chipdata->rx_fifo_size;
 	if (p->info->tx_fifo_override)
 		p->tx_fifo_size = p->info->tx_fifo_override;
 	if (p->info->rx_fifo_override)
@@ -1227,7 +1227,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	/* init master code */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
-	master->flags = p->chipdata->master_flags;
+	master->flags = chipdata->master_flags;
 	master->bus_num = pdev->id;
 	master->dev.of_node = pdev->dev.of_node;
 	master->num_chipselect = p->info->num_chipselect;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
