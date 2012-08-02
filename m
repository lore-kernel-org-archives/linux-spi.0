From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] spi: spi-rspi: fix build error for the latest shdma driver
Date: Thu, 02 Aug 2012 17:17:33 +0900
Message-ID: <501A379D.6060009@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Because the latest shdma driver changed, it caused build error in
the spi-rspi driver. This patch fixed the build error.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/spi/spi-rspi.c |   56 +++++++++++++++++++++++++++++------------------
 1 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 4894bde..30faf6d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -147,8 +147,6 @@ struct rspi_data {
 	unsigned char spsr;

 	/* for dmaengine */
-	struct sh_dmae_slave dma_tx;
-	struct sh_dmae_slave dma_rx;
 	struct dma_chan *chan_tx;
 	struct dma_chan *chan_rx;
 	int irq;
@@ -663,20 +661,16 @@ static irqreturn_t rspi_irq(int irq, void *_sr)
 	return ret;
 }

-static bool rspi_filter(struct dma_chan *chan, void *filter_param)
-{
-	chan->private = filter_param;
-	return true;
-}
-
-static void __devinit rspi_request_dma(struct rspi_data *rspi,
-				       struct platform_device *pdev)
+static int __devinit rspi_request_dma(struct rspi_data *rspi,
+				      struct platform_device *pdev)
 {
 	struct rspi_plat_data *rspi_pd = pdev->dev.platform_data;
 	dma_cap_mask_t mask;
+	struct dma_slave_config cfg;
+	int ret;

 	if (!rspi_pd)
-		return;
+		return 0;	/* The driver assumes no error. */

 	rspi->dma_width_16bit = rspi_pd->dma_width_16bit;

@@ -684,21 +678,35 @@ static void __devinit rspi_request_dma(struct rspi_data *rspi,
 	if (rspi_pd->dma_rx_id && rspi_pd->dma_tx_id) {
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
-		rspi->dma_rx.slave_id = rspi_pd->dma_rx_id;
-		rspi->chan_rx = dma_request_channel(mask, rspi_filter,
-						    &rspi->dma_rx);
-		if (rspi->chan_rx)
-			dev_info(&pdev->dev, "Use DMA when rx.\n");
+		rspi->chan_rx = dma_request_channel(mask, shdma_chan_filter,
+						    (void *)rspi_pd->dma_rx_id);
+		if (rspi->chan_rx) {
+			cfg.slave_id = rspi_pd->dma_rx_id;
+			cfg.direction = DMA_DEV_TO_MEM;
+			ret = dmaengine_slave_config(rspi->chan_rx, &cfg);
+			if (!ret)
+				dev_info(&pdev->dev, "Use DMA when rx.\n");
+			else
+				return ret;
+		}
 	}
 	if (rspi_pd->dma_tx_id) {
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
-		rspi->dma_tx.slave_id = rspi_pd->dma_tx_id;
-		rspi->chan_tx = dma_request_channel(mask, rspi_filter,
-						    &rspi->dma_tx);
-		if (rspi->chan_tx)
-			dev_info(&pdev->dev, "Use DMA when tx\n");
+		rspi->chan_tx = dma_request_channel(mask, shdma_chan_filter,
+						    (void *)rspi_pd->dma_tx_id);
+		if (rspi->chan_tx) {
+			cfg.slave_id = rspi_pd->dma_tx_id;
+			cfg.direction = DMA_MEM_TO_DEV;
+			ret = dmaengine_slave_config(rspi->chan_tx, &cfg);
+			if (!ret)
+				dev_info(&pdev->dev, "Use DMA when tx\n");
+			else
+				return ret;
+		}
 	}
+
+	return 0;
 }

 static void __devexit rspi_release_dma(struct rspi_data *rspi)
@@ -788,7 +796,11 @@ static int __devinit rspi_probe(struct platform_device *pdev)
 	}

 	rspi->irq = irq;
-	rspi_request_dma(rspi, pdev);
+	ret = rspi_request_dma(rspi, pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
+		goto error4;
+	}

 	ret = spi_register_master(master);
 	if (ret < 0) {
-- 
1.7.1
