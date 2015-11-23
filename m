From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pl022: handle EPROBE_DEFER for dma" to the spi tree
Date: Mon, 23 Nov 2015 11:41:08 +0000
Message-ID: <E1a0pUa-0005Wg-JI@debutante>
References: <1448262825-19710-1-git-send-email-rabin.vincent@axis.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448262825-19710-1-git-send-email-rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pl022: handle EPROBE_DEFER for dma

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

>From f3d4bb3342630cd3d89882586851498d8dc7c0f2 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Date: Mon, 23 Nov 2015 08:13:45 +0100
Subject: [PATCH] spi: pl022: handle EPROBE_DEFER for dma

Handle EPROBE_DEFER explicitly so that we ensure that we get the DMA
channel specified in the device tree, instead of depending on the DMA
controller getting probed before us.

Signed-off-by: Rabin Vincent <rabin.vincent-VrBV9hrLPhE@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 94af80676684..5e5fd77e2711 100644
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
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
