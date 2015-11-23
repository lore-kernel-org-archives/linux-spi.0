From: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Subject: [PATCH] spi: pl022: handle EPROBE_DEFER for dma
Date: Mon, 23 Nov 2015 08:13:45 +0100
Message-ID: <1448262825-19710-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rabin Vincent <rabinv-VrBV9hrLPhE@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Handle EPROBE_DEFER explicitly so that we ensure that we get the DMA
channel specified in the device tree, instead of depending on the DMA
controller getting probed before us.

Signed-off-by: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 94af806..5e5fd77 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1171,19 +1171,31 @@ err_no_rxchan:
 static int pl022_dma_autoprobe(struct pl022 *pl022)
 {
 	struct device *dev = &pl022->adev->dev;
+	struct dma_chan *chan;
+	int err;
 
 	/* automatically configure DMA channels from platform, normally using DT */
-	pl022->dma_rx_channel = dma_request_slave_channel(dev, "rx");
-	if (!pl022->dma_rx_channel)
+	chan = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(chan)) {
+		err = PTR_ERR(chan);
 		goto err_no_rxchan;
+	}
+
+	pl022->dma_rx_channel = chan;
 
-	pl022->dma_tx_channel = dma_request_slave_channel(dev, "tx");
-	if (!pl022->dma_tx_channel)
+	chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(chan)) {
+		err = PTR_ERR(chan);
 		goto err_no_txchan;
+	}
+
+	pl022->dma_tx_channel = chan;
 
 	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!pl022->dummypage)
+	if (!pl022->dummypage) {
+		err = -ENOMEM;
 		goto err_no_dummypage;
+	}
 
 	return 0;
 
@@ -1194,7 +1206,7 @@ err_no_txchan:
 	dma_release_channel(pl022->dma_rx_channel);
 	pl022->dma_rx_channel = NULL;
 err_no_rxchan:
-	return -ENODEV;
+	return err;
 }
 		
 static void terminate_dma(struct pl022 *pl022)
@@ -2236,6 +2248,10 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Get DMA channels, try autoconfiguration first */
 	status = pl022_dma_autoprobe(pl022);
+	if (status == -EPROBE_DEFER) {
+		dev_dbg(dev, "deferring probe to get DMA channel\n");
+		goto err_no_irq;
+	}
 
 	/* If that failed, use channels from platform_info */
 	if (status == 0)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
