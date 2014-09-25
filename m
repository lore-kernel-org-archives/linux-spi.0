From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] spi/rockchip: fix bug that cause the failture to read data in DMA mode
Date: Thu, 25 Sep 2014 14:59:41 +0800
Message-ID: <1411628381-4029-1-git-send-email-addy.ke@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

In my test on RK3288-pinky board, if spi is enabled, it will begin to
read data from slave regardless of whether the DMA is ready. So we
need prepare DMA before spi is enable.

Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3afc266..f96ea8a 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -415,7 +415,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
-static int rockchip_spi_dma_transfer(struct rockchip_spi *rs)
+static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
 	unsigned long flags;
 	struct dma_slave_config rxconf, txconf;
@@ -474,8 +474,6 @@ static int rockchip_spi_dma_transfer(struct rockchip_spi *rs)
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
-
-	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -557,16 +555,17 @@ static int rockchip_spi_transfer_one(
 	else if (rs->rx)
 		rs->tmode = CR0_XFM_RO;
 
-	if (master->can_dma && master->can_dma(master, spi, xfer))
+	/* we need prepare dma before spi was enabled */
+	if (master->can_dma && master->can_dma(master, spi, xfer)) {
 		rs->use_dma = 1;
-	else
+		rockchip_spi_prepare_dma(rs);
+	} else {
 		rs->use_dma = 0;
+	}
 
 	rockchip_spi_config(rs);
 
-	if (rs->use_dma)
-		ret = rockchip_spi_dma_transfer(rs);
-	else
+	if (!rs->use_dma)
 		ret = rockchip_spi_pio_transfer(rs);
 
 	return ret;
-- 
1.8.3.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
