From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] spi/rockchip: do an error handling in proper time
Date: Fri, 27 Feb 2015 17:34:16 +0200
Message-ID: <1425051256-30890-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425051256-30890-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425051256-30890-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There was handle_err() callback introduced that is dedicated for error
handling. The patch moves error handling to this callback.

Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a777dc..25003c4 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -302,8 +302,8 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int rockchip_spi_unprepare_message(struct spi_master *master,
-					  struct spi_message *msg)
+static void rockchip_spi_handle_err(struct spi_master *master,
+				    struct spi_message *msg)
 {
 	unsigned long flags;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
@@ -313,8 +313,8 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 	/*
 	 * For DMA mode, we need terminate DMA channel and flush
 	 * fifo for the next transfer if DMA thansfer timeout.
-	 * unprepare_message() was called by core if transfer complete
-	 * or timeout. Maybe it is reasonable for error handling here.
+	 * handle_err() was called by core if transfer failed.
+	 * Maybe it is reasonable for error handling here.
 	 */
 	if (rs->use_dma) {
 		if (rs->state & RXBUSY) {
@@ -327,6 +327,12 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 	}
 
 	spin_unlock_irqrestore(&rs->lock, flags);
+}
+
+static int rockchip_spi_unprepare_message(struct spi_master *master,
+					  struct spi_message *msg)
+{
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	spi_enable_chip(rs, 0);
 
@@ -688,6 +694,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	master->prepare_message = rockchip_spi_prepare_message;
 	master->unprepare_message = rockchip_spi_unprepare_message;
 	master->transfer_one = rockchip_spi_transfer_one;
+	master->handle_err = rockchip_spi_handle_err;
 
 	rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
 	if (!rs->dma_tx.ch)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
