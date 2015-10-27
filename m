From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: handle controller_data in mtk_spi_setup" to the spi tree
Date: Tue, 27 Oct 2015 13:50:06 +0900
Message-ID: <E1ZqwD0-00057N-GI@finisterre>
References: <1444793015-30359-4-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444793015-30359-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: handle controller_data in mtk_spi_setup

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

>From 58a984c79a68d508ccfccf4b82c0eaf7f487c399 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 26 Oct 2015 16:09:43 +0800
Subject: [PATCH] spi: mediatek: handle controller_data in mtk_spi_setup

controller_data is related with device, so move to master->setup
function.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 7bd84c8..406695a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -136,19 +136,13 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 {
 	u16 cpha, cpol;
 	u32 reg_val;
-	struct mtk_chip_config *chip_config;
 	struct spi_device *spi = msg->spi;
+	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cpha = spi->mode & SPI_CPHA ? 1 : 0;
 	cpol = spi->mode & SPI_CPOL ? 1 : 0;
 
-	chip_config = spi->controller_data;
-	if (!chip_config) {
-		chip_config = (void *)&mtk_default_chip_info;
-		spi->controller_data = chip_config;
-	}
-
 	reg_val = readl(mdata->base + SPI_CMD_REG);
 	if (cpha)
 		reg_val |= SPI_CMD_CPHA;
@@ -406,6 +400,16 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 	return xfer->len > MTK_SPI_MAX_FIFO_SIZE;
 }
 
+static int mtk_spi_setup(struct spi_device *spi)
+{
+	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
+
+	if (!spi->controller_data)
+		spi->controller_data = (void *)&mtk_default_chip_info;
+
+	return 0;
+}
+
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
 	u32 cmd, reg_val, cnt;
@@ -493,6 +497,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
+	master->setup = mtk_spi_setup;
 
 	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
 	if (!of_id) {
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
