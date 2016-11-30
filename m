From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-lpspi: read lpspi tx/rx fifo size in probe()" to the spi tree
Date: Wed, 30 Nov 2016 18:08:07 +0000
Message-ID: <E1cC9Id-0008Qe-EJ@debutante>
References: <1480302180-15550-2-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480302180-15550-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-lpspi: read lpspi tx/rx fifo size in probe()

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

>From b88a0deaaf97e394aa63818486b16dbc37273d6d Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Mon, 28 Nov 2016 11:03:00 +0800
Subject: [PATCH] spi: fsl-lpspi: read lpspi tx/rx fifo size in probe()

The lpspi tx/rx fifo size is a read only parameter resides
lpspi Parameter Register. It's better to read lpspi tx/rx
fifo size in probe().

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 47a97add0639..71eca6e3fe32 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -236,15 +236,9 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 
 static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 {
-	u8 txwatermark, rxwatermark;
 	u32 temp;
 
-	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
-	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
-	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
-	rxwatermark = fsl_lpspi->txfifosize >> 1;
-	txwatermark = fsl_lpspi->rxfifosize >> 1;
-	temp = txwatermark | rxwatermark << 16;
+	temp = fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
 
@@ -427,6 +421,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct resource *res;
 	int ret, irq;
+	u32 temp;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
 	if (!master)
@@ -476,6 +471,18 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
+	ret = clk_prepare_enable(fsl_lpspi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "can't enable lpspi clock, ret=%d\n", ret);
+		goto out_master_put;
+	}
+
+	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
+	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
+	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+
+	clk_disable_unprepare(fsl_lpspi->clk);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
