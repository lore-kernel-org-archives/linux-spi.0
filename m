From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date: Tue, 10 Mar 2020 08:33:13 +0100
Message-ID: <20200310073313.21277-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>,
        Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the correct device to request the DMA mapping. Otherwise the IOMMU
doesn't get the mapping and it will generate a page fault.

The error messages look like:
[    3.008452] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
[    3.020123] arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8

This was tested on a custom board with a LS1028A SoC.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index cf8a141bbaf2..ad63804ef690 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -510,14 +510,16 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
+					     dspi->devtype_data->dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -554,10 +556,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_rx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dma->chan_tx->device->dev,
+			  dspi->devtype_data->dma_bufsize,
 			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -573,20 +577,19 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
-	struct device *dev = &dspi->pdev->dev;
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_unmap_single(dev, dma->tx_dma_phys,
+		dma_unmap_single(dma->chan_tx->device->dev, dma->tx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_unmap_single(dev, dma->rx_dma_phys,
+		dma_unmap_single(dma->chan_rx->device->dev, dma->rx_dma_phys,
 				 dspi->devtype_data->dma_bufsize,
 				 DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
-- 
2.20.1
