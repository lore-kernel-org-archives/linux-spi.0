From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] spi/s3c64xx: Use core DMA mapping code with dmaengine
Date: Thu, 16 Jan 2014 12:28:51 +0000
Message-ID: <1389875331-13692-2-git-send-email-broonie@kernel.org>
References: <1389875331-13692-1-git-send-email-broonie@kernel.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389875331-13692-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

When using dmaengine allow the core to do the DMA mapping. We still need
local mapping code for the non-dmaengine case so this doesn't save us
anything for now.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 178 +++++++++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ae907dde1371..e7620f299777 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -291,6 +291,81 @@ static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
 	.name = "samsung-spi-dma",
 };
 
+static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
+						struct spi_message *msg)
+{
+	struct device *dev = &sdd->pdev->dev;
+	struct spi_transfer *xfer;
+
+	if (is_polling(sdd) || msg->is_dma_mapped)
+		return 0;
+
+	/* First mark all xfer unmapped */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		xfer->rx_dma = XFER_DMAADDR_INVALID;
+		xfer->tx_dma = XFER_DMAADDR_INVALID;
+	}
+
+	/* Map until end or first fail */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+
+		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
+			continue;
+
+		if (xfer->tx_buf != NULL) {
+			xfer->tx_dma = dma_map_single(dev,
+					(void *)xfer->tx_buf, xfer->len,
+					DMA_TO_DEVICE);
+			if (dma_mapping_error(dev, xfer->tx_dma)) {
+				dev_err(dev, "dma_map_single Tx failed\n");
+				xfer->tx_dma = XFER_DMAADDR_INVALID;
+				return -ENOMEM;
+			}
+		}
+
+		if (xfer->rx_buf != NULL) {
+			xfer->rx_dma = dma_map_single(dev, xfer->rx_buf,
+						xfer->len, DMA_FROM_DEVICE);
+			if (dma_mapping_error(dev, xfer->rx_dma)) {
+				dev_err(dev, "dma_map_single Rx failed\n");
+				dma_unmap_single(dev, xfer->tx_dma,
+						xfer->len, DMA_TO_DEVICE);
+				xfer->tx_dma = XFER_DMAADDR_INVALID;
+				xfer->rx_dma = XFER_DMAADDR_INVALID;
+				return -ENOMEM;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
+						struct spi_message *msg)
+{
+	struct device *dev = &sdd->pdev->dev;
+	struct spi_transfer *xfer;
+
+	if (is_polling(sdd) || msg->is_dma_mapped)
+		return;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+
+		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
+			continue;
+
+		if (xfer->rx_buf != NULL
+				&& xfer->rx_dma != XFER_DMAADDR_INVALID)
+			dma_unmap_single(dev, xfer->rx_dma,
+						xfer->len, DMA_FROM_DEVICE);
+
+		if (xfer->tx_buf != NULL
+				&& xfer->tx_dma != XFER_DMAADDR_INVALID)
+			dma_unmap_single(dev, xfer->tx_dma,
+						xfer->len, DMA_TO_DEVICE);
+	}
+}
+
 static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 					unsigned len, dma_addr_t buf)
 {
@@ -378,8 +453,22 @@ static void s3c64xx_spi_dma_stop(struct s3c64xx_spi_driver_data *sdd,
 {
 	sdd->ops->stop((enum dma_ch)dma->ch);
 }
+
+#define s3c64xx_spi_can_dma NULL
+
 #else
 
+static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
+						struct spi_message *msg)
+{
+	return 0;
+}
+
+static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
+						struct spi_message *msg)
+{
+}
+
 static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 					unsigned len, dma_addr_t buf)
 {
@@ -437,6 +526,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 			ret = -EBUSY;
 			goto out;
 		}
+		spi->dma_rx = sdd->rx_dma.ch;
 
 		sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
 				   (void *)sdd->tx_dma.dmach, dev, "tx");
@@ -445,6 +535,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 			ret = -EBUSY;
 			goto out_rx;
 		}
+		spi->dma_tx = sdd->tx_dma.ch;
 	}
 
 	ret = pm_runtime_get_sync(&sdd->pdev->dev);
@@ -482,6 +573,16 @@ static void s3c64xx_spi_dma_stop(struct s3c64xx_spi_driver_data *sdd,
 {
 	dmaengine_terminate_all(dma->ch);
 }
+
+static bool s3c64xx_spi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+
+	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
+}
+
 #endif
 
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
@@ -774,81 +875,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 #define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
 
-static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_message *msg)
-{
-	struct device *dev = &sdd->pdev->dev;
-	struct spi_transfer *xfer;
-
-	if (is_polling(sdd) || msg->is_dma_mapped)
-		return 0;
-
-	/* First mark all xfer unmapped */
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		xfer->rx_dma = XFER_DMAADDR_INVALID;
-		xfer->tx_dma = XFER_DMAADDR_INVALID;
-	}
-
-	/* Map until end or first fail */
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-
-		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
-			continue;
-
-		if (xfer->tx_buf != NULL) {
-			xfer->tx_dma = dma_map_single(dev,
-					(void *)xfer->tx_buf, xfer->len,
-					DMA_TO_DEVICE);
-			if (dma_mapping_error(dev, xfer->tx_dma)) {
-				dev_err(dev, "dma_map_single Tx failed\n");
-				xfer->tx_dma = XFER_DMAADDR_INVALID;
-				return -ENOMEM;
-			}
-		}
-
-		if (xfer->rx_buf != NULL) {
-			xfer->rx_dma = dma_map_single(dev, xfer->rx_buf,
-						xfer->len, DMA_FROM_DEVICE);
-			if (dma_mapping_error(dev, xfer->rx_dma)) {
-				dev_err(dev, "dma_map_single Rx failed\n");
-				dma_unmap_single(dev, xfer->tx_dma,
-						xfer->len, DMA_TO_DEVICE);
-				xfer->tx_dma = XFER_DMAADDR_INVALID;
-				xfer->rx_dma = XFER_DMAADDR_INVALID;
-				return -ENOMEM;
-			}
-		}
-	}
-
-	return 0;
-}
-
-static void s3c64xx_spi_unmap_mssg(struct s3c64xx_spi_driver_data *sdd,
-						struct spi_message *msg)
-{
-	struct device *dev = &sdd->pdev->dev;
-	struct spi_transfer *xfer;
-
-	if (is_polling(sdd) || msg->is_dma_mapped)
-		return;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-
-		if (xfer->len <= ((FIFO_LVL_MASK(sdd) >> 1) + 1))
-			continue;
-
-		if (xfer->rx_buf != NULL
-				&& xfer->rx_dma != XFER_DMAADDR_INVALID)
-			dma_unmap_single(dev, xfer->rx_dma,
-						xfer->len, DMA_FROM_DEVICE);
-
-		if (xfer->tx_buf != NULL
-				&& xfer->tx_dma != XFER_DMAADDR_INVALID)
-			dma_unmap_single(dev, xfer->tx_dma,
-						xfer->len, DMA_TO_DEVICE);
-	}
-}
-
 static int s3c64xx_spi_prepare_message(struct spi_master *master,
 				       struct spi_message *msg)
 {
@@ -1347,6 +1373,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->auto_runtime_pm = true;
+	if (!is_polling(sdd))
+		master->can_dma = s3c64xx_spi_can_dma;
 
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
 	if (IS_ERR(sdd->regs)) {
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
