From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] spi: rockchip: potential NULL dereference on error
Date: Wed, 4 May 2016 09:25:46 +0300
Message-ID: <20160504062546.GG22064@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We were calling dma_release_channel(rs->dma_tx.ch) when "rs->dma_tx.ch"
is potentially NULL.  There is actually a call to that in the unwind
code at the bottom of the function so we can just re-arrange this a bit
and remove the call.  Also there is no need to set rs->dma_tx.ch to
NULL on this error path.

Fixes: e4c0e06f949b ('spi: rockchip: fix probe deferral handling')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6c6c001..cd89682 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -744,10 +744,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->dma_rx.ch = dma_request_chan(rs->dev, "rx");
 	if (IS_ERR(rs->dma_rx.ch)) {
 		if (PTR_ERR(rs->dma_rx.ch) == -EPROBE_DEFER) {
-			dma_release_channel(rs->dma_tx.ch);
-			rs->dma_tx.ch = NULL;
 			ret = -EPROBE_DEFER;
-			goto err_get_fifo_len;
+			goto err_free_dma_tx;
 		}
 		dev_warn(rs->dev, "Failed to request RX DMA channel\n");
 		rs->dma_rx.ch = NULL;
@@ -775,10 +773,11 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 err_register_master:
 	pm_runtime_disable(&pdev->dev);
-	if (rs->dma_tx.ch)
-		dma_release_channel(rs->dma_tx.ch);
 	if (rs->dma_rx.ch)
 		dma_release_channel(rs->dma_rx.ch);
+err_free_dma_tx:
+	if (rs->dma_tx.ch)
+		dma_release_channel(rs->dma_tx.ch);
 err_get_fifo_len:
 	clk_disable_unprepare(rs->spiclk);
 err_spiclk_enable:
