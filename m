From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/3] spi: rockchip: check requesting dma channel with EPROBE_DEFER
Date: Wed,  9 Mar 2016 16:11:32 +0800
Message-ID: <1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511043-2058-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Let's defer probing the driver if the return value of
dma_request_slave_channel is ERR_PTR(-EPROBE_DEFER) instead
of disabling dma capability directly.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/spi/spi-rockchip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ca4f4e0..75fa990 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -737,8 +737,14 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->handle_err = rockchip_spi_handle_err;
 
 	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
-	if (!rs->dma_tx.ch)
+	if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
+		/* Check tx to see if we need defer probing driver */
+		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_get_fifo_len;
+		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
+	}
 
 	rs->dma_rx.ch = dma_request_slave_channel(rs->dev, "rx");
 	if (!rs->dma_rx.ch) {
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
