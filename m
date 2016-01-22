From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v7 9/9] spi: rockchip: modify DMA max burst to 1
Date: Fri, 22 Jan 2016 19:06:52 +0800
Message-ID: <1453460812-8498-10-git-send-email-wxt@rock-chips.com>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
Cc: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453460812-8498-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Generic dma controller on Rockchips' platform cannot support
DMAFLUSHP instruction which make dma to flush the req of non-aligned
or non-multiple of what we need. That will cause an unrecoverable
dma bus error. The saftest way is to set dma max burst to 1.

Signed-off-by: Addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Fixes: 64e36824b32b06 ("spi/rockchip: add driver for Rockchip...")
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
cc: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v7: None
Changes in v6:
- remove quirks and get dma caps in order to limit burst

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/spi/spi-rockchip.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79a8bc4..aa9561f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -199,6 +199,7 @@ struct rockchip_spi {
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
 	struct rockchip_spi_dma_data dma_tx;
+	struct dma_slave_caps dma_caps;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
@@ -449,7 +450,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxconf.direction = rs->dma_rx.direction;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
-		rxconf.src_maxburst = rs->n_bytes;
+		if (rs->dma_caps.max_burst > 4)
+			rxconf.src_maxburst = 4;
+		else
+			rxconf.src_maxburst = 1;
 		dmaengine_slave_config(rs->dma_rx.ch, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
@@ -466,7 +470,10 @@ static void rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txconf.direction = rs->dma_tx.direction;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
-		txconf.dst_maxburst = rs->n_bytes;
+		if (rs->dma_caps.max_burst > 4)
+			txconf.dst_maxburst = 4;
+		else
+			txconf.dst_maxburst = 1;
 		dmaengine_slave_config(rs->dma_tx.ch, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
@@ -730,6 +737,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
+		dma_get_slave_caps(rs->dma_rx.ch, &(rs->dma_caps));
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
 		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
