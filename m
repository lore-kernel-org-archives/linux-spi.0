From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2] spi: rockchip: fix warning of static check
Date: Thu, 31 Mar 2016 11:11:41 +0800
Message-ID: <1459393901-18758-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org,
	dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use dma_request_chan instead of dma_request_slave_channel,
in this case we can check EPROBE_DEFER without static
warning.

Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v2:
- use dma_request_chan and replace IS_ERR_OR_NULL()
  with IS_ERR
- do the same for rx

 drivers/spi/spi-rockchip.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index b71c1ae..6c6c001 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -730,23 +730,27 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->transfer_one = rockchip_spi_transfer_one;
 	master->handle_err = rockchip_spi_handle_err;
 
-	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
-	if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
+	rs->dma_tx.ch = dma_request_chan(rs->dev, "tx");
+	if (IS_ERR(rs->dma_tx.ch)) {
 		/* Check tx to see if we need defer probing driver */
 		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_get_fifo_len;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
+		rs->dma_tx.ch = NULL;
 	}
 
-	rs->dma_rx.ch = dma_request_slave_channel(rs->dev, "rx");
-	if (!rs->dma_rx.ch) {
-		if (rs->dma_tx.ch) {
+	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
+	if (IS_ERR(rs->dma_rx.ch)) {
+		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
 			dma_release_channel(rs->dma_tx.ch);
 			rs->dma_tx.ch = NULL;
+			ret = -EPROBE_DEFER;
+			goto err_get_fifo_len;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
+		rs->dma_rx.ch = NULL;
 	}
 
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
