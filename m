From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/3] spi: rockchip: migrate to dmaengine_terminate_async
Date: Wed,  9 Mar 2016 16:11:23 +0800
Message-ID: <1457511083-2175-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511043-2058-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

dmaengine_terminate_all is deprecated, let's use
dmaengine_terminate_async for interrupt handling.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 91f44a3..ca4f4e0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -323,12 +323,12 @@ static void rockchip_spi_handle_err(struct spi_master *master,
 	 */
 	if (rs->use_dma) {
 		if (rs->state & RXBUSY) {
-			dmaengine_terminate_all(rs->dma_rx.ch);
+			dmaengine_terminate_async(rs->dma_rx.ch);
 			flush_fifo(rs);
 		}
 
 		if (rs->state & TXBUSY)
-			dmaengine_terminate_all(rs->dma_tx.ch);
+			dmaengine_terminate_async(rs->dma_tx.ch);
 	}
 
 	spin_unlock_irqrestore(&rs->lock, flags);
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
