From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: fix spi incorrect endian usage" to the spi tree
Date: Thu, 20 Aug 2015 11:34:34 -0700
Message-ID: <E1ZSUfa-00009E-Tl@finisterre>
References: <1440062349-25513-2-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440062349-25513-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: fix spi incorrect endian usage

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

>From 44f636da4e71e0c73d6e29d0319a8954ce3f247a Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 20 Aug 2015 17:19:06 +0800
Subject: [PATCH] spi: mediatek: fix spi incorrect endian usage

TX_ENDIAN/RX_ENDIAN bits define whether to reverse the endian
order of the data DMA from/to memory. The endian order should
keep the same with cpu endian.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c                 | 38 ++++++++++++++------------------
 include/linux/platform_data/spi-mt65xx.h |  2 --
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 546d70c..2eda2d1 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -122,8 +122,6 @@ static const struct mtk_spi_compatible mt8173_compat = {
 static const struct mtk_chip_config mtk_default_chip_info = {
 	.rx_mlsb = 1,
 	.tx_mlsb = 1,
-	.tx_endian = 0,
-	.rx_endian = 0,
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
@@ -161,9 +159,13 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 	reg_val |= (chip_config->rx_mlsb << SPI_CMD_RXMSBF_OFFSET);
 
 	/* set the tx/rx endian */
-	reg_val &= ~(SPI_CMD_TX_ENDIAN | SPI_CMD_RX_ENDIAN);
-	reg_val |= (chip_config->tx_endian << SPI_CMD_TX_ENDIAN_OFFSET);
-	reg_val |= (chip_config->rx_endian << SPI_CMD_RX_ENDIAN_OFFSET);
+#ifdef __LITTLE_ENDIAN
+	reg_val &= ~SPI_CMD_TX_ENDIAN;
+	reg_val &= ~SPI_CMD_RX_ENDIAN;
+#else
+	reg_val |= SPI_CMD_TX_ENDIAN;
+	reg_val |= SPI_CMD_RX_ENDIAN;
+#endif
 
 	/* set finish and pause interrupt always enable */
 	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_EN;
@@ -352,7 +354,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	int cnt, i;
+	int cnt;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	mdata->cur_transfer = xfer;
@@ -364,10 +366,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 		cnt = xfer->len / 4 + 1;
 	else
 		cnt = xfer->len / 4;
-
-	for (i = 0; i < cnt; i++)
-		writel(*((u32 *)xfer->tx_buf + i),
-		       mdata->base + SPI_TX_DATA_REG);
+	iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
 
 	mtk_spi_enable_transfer(master);
 
@@ -437,7 +436,7 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
-	u32 cmd, reg_val, i;
+	u32 cmd, reg_val, cnt;
 	struct spi_master *master = dev_id;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_transfer *trans = mdata->cur_transfer;
@@ -449,18 +448,13 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->state = MTK_SPI_IDLE;
 
 	if (!master->can_dma(master, master->cur_msg->spi, trans)) {
-		/* xfer len is not N*4 bytes every time in a transfer,
-		 * but SPI_RX_DATA_REG must reads 4 bytes once,
-		 * so rx buffer byte by byte.
-		 */
 		if (trans->rx_buf) {
-			for (i = 0; i < mdata->xfer_len; i++) {
-				if (i % 4 == 0)
-					reg_val =
-					readl(mdata->base + SPI_RX_DATA_REG);
-				*((u8 *)(trans->rx_buf + i)) =
-					(reg_val >> ((i % 4) * 8)) & 0xff;
-			}
+			if (mdata->xfer_len % 4)
+				cnt = mdata->xfer_len / 4 + 1;
+			else
+				cnt = mdata->xfer_len / 4;
+			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
+				     trans->rx_buf, cnt);
 		}
 		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
diff --git a/include/linux/platform_data/spi-mt65xx.h b/include/linux/platform_data/spi-mt65xx.h
index 7512255..54b0448 100644
--- a/include/linux/platform_data/spi-mt65xx.h
+++ b/include/linux/platform_data/spi-mt65xx.h
@@ -16,7 +16,5 @@
 struct mtk_chip_config {
 	u32 tx_mlsb;
 	u32 rx_mlsb;
-	u32 tx_endian;
-	u32 rx_endian;
 };
 #endif
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
