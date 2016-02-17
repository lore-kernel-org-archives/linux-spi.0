From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: use proper dev_* functions for driver messages" to the spi tree
Date: Wed, 17 Feb 2016 19:13:47 +0000
Message-ID: <E1aW7Xn-0001r6-5p@debutante>
References: <1455715739-25161-3-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-3-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: use proper dev_* functions for driver messages

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

>From 6aa800ca65b1788e8c2e4ffd1e57a4c4355fe0ed Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Wed, 17 Feb 2016 14:28:48 +0100
Subject: [PATCH] spi: imx: use proper dev_* functions for driver messages

Add a struct device * member to the private driver data and use
it to print messages using dev_* functions rather than pr_*.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d98c33cb64f9..7ac206b8cc93 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -86,6 +86,7 @@ struct spi_imx_devtype_data {
 
 struct spi_imx_data {
 	struct spi_bitbang bitbang;
+	struct device *dev;
 
 	struct completion xfer_done;
 	void __iomem *base;
@@ -250,14 +251,15 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
 /* MX51 eCSPI */
-static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
-				      unsigned int *fres)
+static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
+				      unsigned int fspi, unsigned int *fres)
 {
 	/*
 	 * there are two 4-bit dividers, the pre-divider divides by
 	 * $pre, the post-divider by 2^$post
 	 */
 	unsigned int pre, post;
+	unsigned int fin = spi_imx->spi_clk;
 
 	if (unlikely(fspi > fin))
 		return 0;
@@ -270,14 +272,14 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
 
 	post = max(4U, post) - 4;
 	if (unlikely(post > 0xf)) {
-		pr_err("%s: cannot set clock freq: %u (base freq: %u)\n",
-				__func__, fspi, fin);
+		dev_err(spi_imx->dev, "cannot set clock freq: %u (base freq: %u)\n",
+				fspi, fin);
 		return 0xff;
 	}
 
 	pre = DIV_ROUND_UP(fin, fspi << post) - 1;
 
-	pr_debug("%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
+	dev_dbg(spi_imx->dev, "%s: fin: %u, fspi: %u, post: %u, pre: %u\n",
 			__func__, fin, fspi, post, pre);
 
 	/* Resulting frequency for the SCLK line. */
@@ -330,7 +332,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	ctrl |= MX51_ECSPI_CTRL_MODE_MASK;
 
 	/* set clock speed */
-	ctrl |= mx51_ecspi_clkdiv(spi_imx->spi_clk, config->speed_hz, &clk);
+	ctrl |= mx51_ecspi_clkdiv(spi_imx, config->speed_hz, &clk);
 
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
@@ -977,18 +979,14 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
 						IMX_DMA_TIMEOUT);
 	if (!timeout) {
-		pr_warn("%s %s: I/O Error in DMA TX\n",
-			dev_driver_string(&master->dev),
-			dev_name(&master->dev));
+		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
 		dmaengine_terminate_all(master->dma_tx);
 		dmaengine_terminate_all(master->dma_rx);
 	} else {
 		timeout = wait_for_completion_timeout(
 				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
 		if (!timeout) {
-			pr_warn("%s %s: I/O Error in DMA RX\n",
-				dev_driver_string(&master->dev),
-				dev_name(&master->dev));
+			dev_err(spi_imx->dev, "I/O Error in DMA RX\n");
 			spi_imx->devtype_data->reset(spi_imx);
 			dmaengine_terminate_all(master->dma_rx);
 		}
@@ -1009,9 +1007,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	return ret;
 
 no_dma:
-	pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
-		     dev_driver_string(&master->dev),
-		     dev_name(&master->dev));
+	dev_warn_once(spi_imx->dev, "DMA not available, falling back to PIO\n");
 	return -EAGAIN;
 }
 
@@ -1141,6 +1137,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
+	spi_imx->dev = &pdev->dev;
 
 	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
