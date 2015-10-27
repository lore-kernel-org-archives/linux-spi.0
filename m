From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: remove mtk_spi_config" to the spi tree
Date: Tue, 27 Oct 2015 13:50:13 +0900
Message-ID: <E1ZqwD7-00057t-5w@finisterre>
References: <1444793015-30359-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444793015-30359-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: remove mtk_spi_config

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

>From 79b5d3f24dcec547ea5db7d2e0b557a36f92b16b Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 26 Oct 2015 16:09:41 +0800
Subject: [PATCH] spi: mediatek: remove mtk_spi_config

mtk_spi_config() and mtk_spi_prepare_message() both initialize
spi register, so remove mtk_spi_config() and init all register
in mtk_spi_prepare_message().

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 59 +++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ecb6c58..7bd84c8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -131,10 +131,34 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
 	writel(reg_val, mdata->base + SPI_CMD_REG);
 }
 
-static void mtk_spi_config(struct mtk_spi *mdata,
-			   struct mtk_chip_config *chip_config)
+static int mtk_spi_prepare_message(struct spi_master *master,
+				   struct spi_message *msg)
 {
+	u16 cpha, cpol;
 	u32 reg_val;
+	struct mtk_chip_config *chip_config;
+	struct spi_device *spi = msg->spi;
+	struct mtk_spi *mdata = spi_master_get_devdata(master);
+
+	cpha = spi->mode & SPI_CPHA ? 1 : 0;
+	cpol = spi->mode & SPI_CPOL ? 1 : 0;
+
+	chip_config = spi->controller_data;
+	if (!chip_config) {
+		chip_config = (void *)&mtk_default_chip_info;
+		spi->controller_data = chip_config;
+	}
+
+	reg_val = readl(mdata->base + SPI_CMD_REG);
+	if (cpha)
+		reg_val |= SPI_CMD_CPHA;
+	else
+		reg_val &= ~SPI_CMD_CPHA;
+	if (cpol)
+		reg_val |= SPI_CMD_CPOL;
+	else
+		reg_val &= ~SPI_CMD_CPOL;
+	writel(reg_val, mdata->base + SPI_CMD_REG);
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 
@@ -171,37 +195,6 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	/* pad select */
 	if (mdata->dev_comp->need_pad_sel)
 		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
-}
-
-static int mtk_spi_prepare_message(struct spi_master *master,
-				   struct spi_message *msg)
-{
-	u32 reg_val;
-	u8 cpha, cpol;
-	struct mtk_chip_config *chip_config;
-	struct spi_device *spi = msg->spi;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-
-	cpha = spi->mode & SPI_CPHA ? 1 : 0;
-	cpol = spi->mode & SPI_CPOL ? 1 : 0;
-
-	reg_val = readl(mdata->base + SPI_CMD_REG);
-	if (cpha)
-		reg_val |= SPI_CMD_CPHA;
-	else
-		reg_val &= ~SPI_CMD_CPHA;
-	if (cpol)
-		reg_val |= SPI_CMD_CPOL;
-	else
-		reg_val &= ~SPI_CMD_CPOL;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
-
-	chip_config = spi->controller_data;
-	if (!chip_config) {
-		chip_config = (void *)&mtk_default_chip_info;
-		spi->controller_data = chip_config;
-	}
-	mtk_spi_config(mdata, chip_config);
 
 	return 0;
 }
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
