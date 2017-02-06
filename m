From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] spi: davinci: Use SPI framework to handle DMA mapping
Date: Mon,  6 Feb 2017 15:57:07 +0100
Message-ID: <20170206145708.24356-1-fparent@baylibre.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Uppers layers like MTD can pass vmalloc'd buffers to the SPI driver,
and the current implementation will fail to map these kind of buffers.
The SPI framework is able to detect the best way to handle and map
buffers.

This commit updates the davinci SPI driver in order to use the SPI
framework to handle the DMA mapping of buffers coming from an upper
layer.

Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 78 ++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 02fb96797ac8..cb80c1d3f86a 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -630,7 +630,6 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		};
 		struct dma_async_tx_descriptor *rxdesc;
 		struct dma_async_tx_descriptor *txdesc;
-		void *buf;
 
 		dummy_buf = kzalloc(t->len, GFP_KERNEL);
 		if (!dummy_buf)
@@ -639,42 +638,40 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		dmaengine_slave_config(dspi->dma_rx, &dma_rx_conf);
 		dmaengine_slave_config(dspi->dma_tx, &dma_tx_conf);
 
-		sg_init_table(&sg_rx, 1);
-		if (!t->rx_buf)
-			buf = dummy_buf;
-		else
-			buf = t->rx_buf;
-		t->rx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
-			ret = -EFAULT;
-			goto err_rx_map;
+		if (!t->rx_buf) {
+			sg_init_table(&sg_rx, 1);
+			t->rx_dma = dma_map_single(&spi->dev, dummy_buf,
+					t->len, DMA_FROM_DEVICE);
+			if (dma_mapping_error(&spi->dev, !t->rx_dma)) {
+				ret = -EFAULT;
+				goto err_rx_map;
+			}
+			sg_dma_address(&sg_rx) = t->rx_dma;
+			sg_dma_len(&sg_rx) = t->len;
 		}
-		sg_dma_address(&sg_rx) = t->rx_dma;
-		sg_dma_len(&sg_rx) = t->len;
 
 		sg_init_table(&sg_tx, 1);
-		if (!t->tx_buf)
-			buf = dummy_buf;
-		else
-			buf = (void *)t->tx_buf;
-		t->tx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			ret = -EFAULT;
-			goto err_tx_map;
+		if (!t->tx_buf) {
+			t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
+					t->len, DMA_TO_DEVICE);
+			if (dma_mapping_error(&spi->dev, t->tx_dma)) {
+				ret = -EFAULT;
+				goto err_tx_map;
+			}
+			sg_dma_address(&sg_tx) = t->tx_dma;
+			sg_dma_len(&sg_tx) = t->len;
 		}
-		sg_dma_address(&sg_tx) = t->tx_dma;
-		sg_dma_len(&sg_tx) = t->len;
 
 		rxdesc = dmaengine_prep_slave_sg(dspi->dma_rx,
-				&sg_rx, 1, DMA_DEV_TO_MEM,
+				t->rx_sg.sgl ?: &sg_rx, t->rx_sg.nents ?: 1,
+				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!rxdesc)
 			goto err_desc;
 
 		txdesc = dmaengine_prep_slave_sg(dspi->dma_tx,
-				&sg_tx, 1, DMA_MEM_TO_DEV,
+				t->tx_sg.sgl ?: &sg_tx, t->tx_sg.nents ?: 1,
+				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!txdesc)
 			goto err_desc;
@@ -713,10 +710,12 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
-		dma_unmap_single(&spi->dev, t->rx_dma,
-				t->len, DMA_FROM_DEVICE);
-		dma_unmap_single(&spi->dev, t->tx_dma,
-				t->len, DMA_TO_DEVICE);
+		if (!t->rx_buf)
+			dma_unmap_single(&spi->dev, t->rx_dma,
+					t->len, DMA_FROM_DEVICE);
+		if (!t->tx_buf)
+			dma_unmap_single(&spi->dev, t->tx_dma,
+					t->len, DMA_TO_DEVICE);
 		kfree(dummy_buf);
 	}
 
@@ -742,9 +741,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 
 err_desc:
-	dma_unmap_single(&spi->dev, t->tx_dma, t->len, DMA_TO_DEVICE);
+	if (!t->tx_buf)
+		dma_unmap_single(&spi->dev, t->tx_dma, t->len, DMA_TO_DEVICE);
 err_tx_map:
-	dma_unmap_single(&spi->dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
+	if (!t->rx_buf)
+		dma_unmap_single(&spi->dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
 err_rx_map:
 	kfree(dummy_buf);
 err_alloc_dummy_buf:
@@ -898,6 +899,18 @@ static struct davinci_spi_platform_data
 }
 #endif
 
+static bool davinci_spi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct davinci_spi_config *spicfg = spi->controller_data;
+
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
+
+	return spicfg->io_type == SPI_IO_TYPE_DMA;
+}
+
 /**
  * davinci_spi_probe - probe function for SPI Master Controller
  * @pdev: platform_device structure which contains plateform specific data
@@ -990,6 +1003,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
+	master->can_dma = davinci_spi_can_dma;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
