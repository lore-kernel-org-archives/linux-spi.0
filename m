From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: Prevent overflows in FIFO transfers" to the spi tree
Date: Wed, 30 Dec 2015 18:05:27 +0000
Message-ID: <E1aEL7n-0007UR-Su@debutante>
References: <1451211426-20436-1-git-send-email-drinkcat@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451211426-20436-1-git-send-email-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: Prevent overflows in FIFO transfers

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

>From de327e4966cdbad2b7053c84a6f591fbdc54f7cb Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Sun, 27 Dec 2015 18:17:06 +0800
Subject: [PATCH] spi: mediatek: Prevent overflows in FIFO transfers

In the case where transfer length is not a multiple of 4, KASAN
reports 2 out-of-bounds memory accesses:
 - mtk_spi_interrupt: ioread32_rep writes past the end of
   trans->rx_buf.
 - mtk_spi_fifo_transfer: iowrite32_rep reads past the end of
   xfer->tx_buf.

Fix this by using memcpy on the remainder of the bytes.

Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 563954a61424..375d412dbf05 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -323,7 +323,8 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	int cnt;
+	int cnt, remainder;
+	u32 reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	mdata->cur_transfer = xfer;
@@ -331,12 +332,16 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
-	if (xfer->len % 4)
-		cnt = xfer->len / 4 + 1;
-	else
-		cnt = xfer->len / 4;
+	cnt = xfer->len / 4;
 	iowrite32_rep(mdata->base + SPI_TX_DATA_REG, xfer->tx_buf, cnt);
 
+	remainder = xfer->len % 4;
+	if (remainder > 0) {
+		reg_val = 0;
+		memcpy(&reg_val, xfer->tx_buf + (cnt * 4), remainder);
+		writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+	}
+
 	mtk_spi_enable_transfer(master);
 
 	return 1;
@@ -418,7 +423,7 @@ static int mtk_spi_setup(struct spi_device *spi)
 
 static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 {
-	u32 cmd, reg_val, cnt;
+	u32 cmd, reg_val, cnt, remainder;
 	struct spi_master *master = dev_id;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_transfer *trans = mdata->cur_transfer;
@@ -431,12 +436,15 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 
 	if (!master->can_dma(master, master->cur_msg->spi, trans)) {
 		if (trans->rx_buf) {
-			if (mdata->xfer_len % 4)
-				cnt = mdata->xfer_len / 4 + 1;
-			else
-				cnt = mdata->xfer_len / 4;
+			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
 				     trans->rx_buf, cnt);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = readl(mdata->base + SPI_RX_DATA_REG);
+				memcpy(trans->rx_buf + (cnt * 4),
+					&reg_val, remainder);
+			}
 		}
 		spi_finalize_current_transfer(master);
 		return IRQ_HANDLED;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
