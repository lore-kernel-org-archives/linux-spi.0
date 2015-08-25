From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: replace int with u32, delete TAB and define MTK_SPI_PAUSE_INT_STATUS marco" to the spi tree
Date: Tue, 25 Aug 2015 18:50:09 +0100
Message-ID: <E1ZUIML-0005P5-9A@debutante>
References: <1440387918-22191-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440387918-22191-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: replace int with u32, delete TAB and define MTK_SPI_PAUSE_INT_STATUS marco

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

>From 50f8fec2162db918540d0845481f3f6fffc5b033 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 24 Aug 2015 11:45:16 +0800
Subject: [PATCH] spi: mediatek: replace int with u32, delete TAB and define
 MTK_SPI_PAUSE_INT_STATUS marco

this patch replaces int with u32, deletes TAB, and defines
MTK_SPI_PAUSE_INT_STATUS marco.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 46d14772c0cc..81b75b94145c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -67,6 +67,8 @@
 
 #define MT8173_SPI_MAX_PAD_SEL 3
 
+#define MTK_SPI_PAUSE_INT_STATUS 0x2
+
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
@@ -179,7 +181,7 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
-	if (trans->cs_change == 0) {
+	if (!trans->cs_change) {
 		mdata->state = MTK_SPI_IDLE;
 		mtk_spi_reset(mdata);
 	}
@@ -269,11 +271,11 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 	u32 packet_size, packet_loop, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
-	packet_size = min_t(unsigned, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
+	packet_size = min_t(u32, mdata->xfer_len, MTK_SPI_PACKET_SIZE);
 	packet_loop = mdata->xfer_len / packet_size;
 
 	reg_val = readl(mdata->base + SPI_CFG1_REG);
-	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK + SPI_CFG1_PACKET_LOOP_MASK);
+	reg_val &= ~(SPI_CFG1_PACKET_LENGTH_MASK | SPI_CFG1_PACKET_LOOP_MASK);
 	reg_val |= (packet_size - 1) << SPI_CFG1_PACKET_LENGTH_OFFSET;
 	reg_val |= (packet_loop - 1) << SPI_CFG1_PACKET_LOOP_OFFSET;
 	writel(reg_val, mdata->base + SPI_CFG1_REG);
@@ -281,7 +283,7 @@ static void mtk_spi_setup_packet(struct spi_master *master)
 
 static void mtk_spi_enable_transfer(struct spi_master *master)
 {
-	int cmd;
+	u32 cmd;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	cmd = readl(mdata->base + SPI_CMD_REG);
@@ -292,9 +294,9 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-static int mtk_spi_get_mult_delta(int xfer_len)
+static int mtk_spi_get_mult_delta(u32 xfer_len)
 {
-	int mult_delta;
+	u32 mult_delta;
 
 	if (xfer_len > MTK_SPI_PACKET_SIZE)
 		mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
@@ -435,7 +437,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	struct spi_transfer *trans = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
-	if (reg_val & 0x2)
+	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
 		mdata->state = MTK_SPI_PAUSED;
 	else
 		mdata->state = MTK_SPI_IDLE;
@@ -498,7 +500,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int	irq, ret;
+	int irq, ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
