From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 08/18] spi: rspi: Remove unneeded resource test in DMA setup
Date: Mon,  2 Jun 2014 15:38:10 +0200
Message-ID: <1401716301-29612-9-git-send-email-geert+renesas@glider.be>
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

The resource is know to exist, as rspi_probe() already mapped it.
Remove the test, and just pass the resource.
Pass the device pointer instead of the platform device pointer, as the
latter is no longer needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0a7a2d618f0f..1ec51cb00203 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -980,35 +980,32 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	return chan;
 }
 
-static int rspi_request_dma(struct rspi_data *rspi,
-			    struct platform_device *pdev)
+static int rspi_request_dma(struct device *dev, struct rspi_data *rspi,
+			    const struct resource *res)
 {
-	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	const struct rspi_plat_data *rspi_pd = dev_get_platdata(dev);
 
-	if (!res || !rspi_pd)
+	if (!rspi_pd)
 		return 0;	/* The driver assumes no error. */
 
 	/* If the module receives data by DMAC, it also needs TX DMAC */
 	if (rspi_pd->dma_rx_id && rspi_pd->dma_tx_id) {
-		rspi->chan_rx = rspi_request_dma_chan(&pdev->dev,
-						      DMA_DEV_TO_MEM,
+		rspi->chan_rx = rspi_request_dma_chan(dev, DMA_DEV_TO_MEM,
 						      rspi_pd->dma_rx_id,
 						      res->start + RSPI_SPDR);
 		if (!rspi->chan_rx)
 			return -ENODEV;
 
-		dev_info(&pdev->dev, "Use DMA when rx.\n");
+		dev_info(dev, "Use DMA when rx.\n");
 	}
 	if (rspi_pd->dma_tx_id) {
-		rspi->chan_tx = rspi_request_dma_chan(&pdev->dev,
-						      DMA_MEM_TO_DEV,
+		rspi->chan_tx = rspi_request_dma_chan(dev, DMA_MEM_TO_DEV,
 						      rspi_pd->dma_tx_id,
 						      res->start + RSPI_SPDR);
 		if (!rspi->chan_tx)
 			return -ENODEV;
 
-		dev_info(&pdev->dev, "Use DMA when tx\n");
+		dev_info(dev, "Use DMA when tx\n");
 	}
 
 	return 0;
@@ -1210,7 +1207,7 @@ static int rspi_probe(struct platform_device *pdev)
 		goto error2;
 	}
 
-	ret = rspi_request_dma(rspi, pdev);
+	ret = rspi_request_dma(&pdev->dev, rspi, res);
 	if (ret < 0)
 		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
