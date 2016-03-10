From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: check return value of dmaengine_prep_slave_sg" to the spi tree
Date: Thu, 10 Mar 2016 10:39:38 +0700
Message-ID: <E1adrRq-0007el-SE@finisterre>
References: <1457511075-2134-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511075-2134-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: check return value of dmaengine_prep_slave_sg

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

>From ea98491133439773b69345eb9a314fc5f15e07a4 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Wed, 9 Mar 2016 16:11:15 +0800
Subject: [PATCH] spi: rockchip: check return value of dmaengine_prep_slave_sg

We should check return value of dmaengine_prep_slave_sg, otherwise
we take risk of null pointer.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 9a5c51764833..aa8528e9840c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -436,7 +436,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
-static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
+static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
 	struct dma_slave_config rxconf, txconf;
@@ -459,6 +459,8 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
 				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+		if (!rxdesc)
+			return -EINVAL;
 
 		rxdesc->callback = rockchip_spi_dma_rxcb;
 		rxdesc->callback_param = rs;
@@ -476,6 +478,11 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 				rs->dma_tx.ch,
 				rs->tx_sg.sgl, rs->tx_sg.nents,
 				rs->dma_tx.direction, DMA_PREP_INTERRUPT);
+		if (!txdesc) {
+			if (rxdesc)
+				dmaengine_terminate_sync(rs->dma_rx.ch);
+			return -EINVAL;
+		}
 
 		txdesc->callback = rockchip_spi_dma_txcb;
 		txdesc->callback_param = rs;
@@ -497,6 +504,8 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
+
+	return 0;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -610,12 +619,12 @@ static int rockchip_spi_transfer_one(
 	if (rs->use_dma) {
 		if (rs->tmode == CR0_XFM_RO) {
 			/* rx: dma must be prepared first */
-			rockchip_spi_prepare_dma(rs);
+			ret = rockchip_spi_prepare_dma(rs);
 			spi_enable_chip(rs, 1);
 		} else {
 			/* tx or tr: spi must be enabled first */
 			spi_enable_chip(rs, 1);
-			rockchip_spi_prepare_dma(rs);
+			ret = rockchip_spi_prepare_dma(rs);
 		}
 	} else {
 		spi_enable_chip(rs, 1);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
