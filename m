From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/3] spi: rockchip: check return value of dmaengine_prep_slave_sg
Date: Wed,  9 Mar 2016 16:11:15 +0800
Message-ID: <1457511075-2134-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511043-2058-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We should check return value of dmaengine_prep_slave_sg, otherwise
we take risk of null pointer.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

 drivers/spi/spi-rockchip.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index eb1bd45..91f44a3 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -437,7 +437,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
-static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
+static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
 	struct dma_slave_config rxconf, txconf;
@@ -463,6 +463,8 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
 				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+		if (!rxdesc)
+			return -EINVAL;
 
 		rxdesc->callback = rockchip_spi_dma_rxcb;
 		rxdesc->callback_param = rs;
@@ -483,6 +485,11 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
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
@@ -504,6 +511,8 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
+
+	return 0;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -617,12 +626,12 @@ static int rockchip_spi_transfer_one(
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
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
