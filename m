From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 07/18] spi: rspi: Extract rspi_request_dma_chan()
Date: Mon,  2 Jun 2014 15:38:09 +0200
Message-ID: <1401716301-29612-8-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Setup of the receive and transmit DMA channels is very similar, so let's
consolidate.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 89 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 94a99ec7d989..0a7a2d618f0f 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -942,52 +942,73 @@ static irqreturn_t rspi_irq_tx(int irq, void *_sr)
 	return 0;
 }
 
-static int rspi_request_dma(struct rspi_data *rspi,
-				      struct platform_device *pdev)
+static struct dma_chan *rspi_request_dma_chan(struct device *dev,
+					      enum dma_transfer_direction dir,
+					      unsigned int id,
+					      dma_addr_t port_addr)
 {
-	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dma_cap_mask_t mask;
+	struct dma_chan *chan;
 	struct dma_slave_config cfg;
 	int ret;
 
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_channel(mask, shdma_chan_filter,
+				   (void *)(unsigned long)id);
+	if (!chan) {
+		dev_warn(dev, "dma_request_channel failed\n");
+		return NULL;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.slave_id = id;
+	cfg.direction = dir;
+	if (dir == DMA_MEM_TO_DEV)
+		cfg.dst_addr = port_addr;
+	else
+		cfg.src_addr = port_addr;
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret) {
+		dev_warn(dev, "dmaengine_slave_config failed %d\n", ret);
+		dma_release_channel(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
+static int rspi_request_dma(struct rspi_data *rspi,
+			    struct platform_device *pdev)
+{
+	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
 	if (!res || !rspi_pd)
 		return 0;	/* The driver assumes no error. */
 
 	/* If the module receives data by DMAC, it also needs TX DMAC */
 	if (rspi_pd->dma_rx_id && rspi_pd->dma_tx_id) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		rspi->chan_rx = dma_request_channel(mask, shdma_chan_filter,
-						    (void *)rspi_pd->dma_rx_id);
-		if (rspi->chan_rx) {
-			cfg.slave_id = rspi_pd->dma_rx_id;
-			cfg.direction = DMA_DEV_TO_MEM;
-			cfg.dst_addr = 0;
-			cfg.src_addr = res->start + RSPI_SPDR;
-			ret = dmaengine_slave_config(rspi->chan_rx, &cfg);
-			if (!ret)
-				dev_info(&pdev->dev, "Use DMA when rx.\n");
-			else
-				return ret;
-		}
+		rspi->chan_rx = rspi_request_dma_chan(&pdev->dev,
+						      DMA_DEV_TO_MEM,
+						      rspi_pd->dma_rx_id,
+						      res->start + RSPI_SPDR);
+		if (!rspi->chan_rx)
+			return -ENODEV;
+
+		dev_info(&pdev->dev, "Use DMA when rx.\n");
 	}
 	if (rspi_pd->dma_tx_id) {
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		rspi->chan_tx = dma_request_channel(mask, shdma_chan_filter,
-						    (void *)rspi_pd->dma_tx_id);
-		if (rspi->chan_tx) {
-			cfg.slave_id = rspi_pd->dma_tx_id;
-			cfg.direction = DMA_MEM_TO_DEV;
-			cfg.dst_addr = res->start + RSPI_SPDR;
-			cfg.src_addr = 0;
-			ret = dmaengine_slave_config(rspi->chan_tx, &cfg);
-			if (!ret)
-				dev_info(&pdev->dev, "Use DMA when tx\n");
-			else
-				return ret;
-		}
+		rspi->chan_tx = rspi_request_dma_chan(&pdev->dev,
+						      DMA_MEM_TO_DEV,
+						      rspi_pd->dma_tx_id,
+						      res->start + RSPI_SPDR);
+		if (!rspi->chan_tx)
+			return -ENODEV;
+
+		dev_info(&pdev->dev, "Use DMA when tx\n");
 	}
 
 	return 0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
