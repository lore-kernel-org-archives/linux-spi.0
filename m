From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] spi/s3c64xx: Remove S3C_DMA support
Date: Fri,  7 Feb 2014 13:11:31 +0000
Message-ID: <1391778692-20129-1-git-send-email-broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mark Brown <broonie@linaro.org>

All the platforms which use the old S3C_DMA API have now been converted to
dmaengine so we can remove the legacy code from the driver, simplifying
maintenance.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 191 ----------------------------------------------
 1 file changed, 191 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4490e8c499c0..18ec7e65a319 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -34,10 +34,6 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#ifdef CONFIG_S3C_DMA
-#include <mach/dma.h>
-#endif
-
 #define MAX_SPI_PORTS		3
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
 
@@ -200,9 +196,6 @@ struct s3c64xx_spi_driver_data {
 	unsigned                        cur_speed;
 	struct s3c64xx_spi_dma_data	rx_dma;
 	struct s3c64xx_spi_dma_data	tx_dma;
-#ifdef CONFIG_S3C_DMA
-	struct samsung_dma_ops		*ops;
-#endif
 	struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
 	bool				cs_gpio;
@@ -284,180 +277,6 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-#ifdef CONFIG_S3C_DMA
-/* FIXME: remove this section once arch/arm/mach-s3c64xx uses dmaengine */
-
-static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
-	.name = "samsung-spi-dma",
-};
-
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
-static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
-					unsigned len, dma_addr_t buf)
-{
-	struct s3c64xx_spi_driver_data *sdd;
-	struct samsung_dma_prep info;
-	struct samsung_dma_config config;
-
-	if (dma->direction == DMA_DEV_TO_MEM) {
-		sdd = container_of((void *)dma,
-			struct s3c64xx_spi_driver_data, rx_dma);
-		config.direction = sdd->rx_dma.direction;
-		config.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
-		config.width = sdd->cur_bpw / 8;
-		sdd->ops->config((enum dma_ch)sdd->rx_dma.ch, &config);
-	} else {
-		sdd = container_of((void *)dma,
-			struct s3c64xx_spi_driver_data, tx_dma);
-		config.direction =  sdd->tx_dma.direction;
-		config.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
-		config.width = sdd->cur_bpw / 8;
-		sdd->ops->config((enum dma_ch)sdd->tx_dma.ch, &config);
-	}
-
-	info.cap = DMA_SLAVE;
-	info.len = len;
-	info.fp = s3c64xx_spi_dmacb;
-	info.fp_param = dma;
-	info.direction = dma->direction;
-	info.buf = buf;
-
-	sdd->ops->prepare((enum dma_ch)dma->ch, &info);
-	sdd->ops->trigger((enum dma_ch)dma->ch);
-}
-
-static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
-{
-	struct samsung_dma_req req;
-	struct device *dev = &sdd->pdev->dev;
-
-	sdd->ops = samsung_dma_get_ops();
-
-	req.cap = DMA_SLAVE;
-	req.client = &s3c64xx_spi_dma_client;
-
-	sdd->rx_dma.ch = (struct dma_chan *)(unsigned long)sdd->ops->request(
-					sdd->rx_dma.dmach, &req, dev, "rx");
-	sdd->tx_dma.ch = (struct dma_chan *)(unsigned long)sdd->ops->request(
-					sdd->tx_dma.dmach, &req, dev, "tx");
-
-	return 1;
-}
-
-static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
-{
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
-
-	/*
-	 * If DMA resource was not available during
-	 * probe, no need to continue with dma requests
-	 * else Acquire DMA channels
-	 */
-	while (!is_polling(sdd) && !acquire_dma(sdd))
-		usleep_range(10000, 11000);
-
-	return 0;
-}
-
-static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
-{
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
-
-	/* Free DMA channels */
-	if (!is_polling(sdd)) {
-		sdd->ops->release((enum dma_ch)sdd->rx_dma.ch,
-					&s3c64xx_spi_dma_client);
-		sdd->ops->release((enum dma_ch)sdd->tx_dma.ch,
-					&s3c64xx_spi_dma_client);
-	}
-
-	return 0;
-}
-
-static void s3c64xx_spi_dma_stop(struct s3c64xx_spi_driver_data *sdd,
-				 struct s3c64xx_spi_dma_data *dma)
-{
-	sdd->ops->stop((enum dma_ch)dma->ch);
-}
-
-#define s3c64xx_spi_can_dma NULL
-
-#else
-
 static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
 						struct spi_message *msg)
 {
@@ -583,8 +402,6 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 }
 
-#endif
-
 static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 				struct spi_device *spi,
 				struct spi_transfer *xfer, int dma_mode)
@@ -616,11 +433,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-#ifndef CONFIG_S3C_DMA
 			prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
-#else
-			prepare_dma(&sdd->tx_dma, xfer->len, xfer->tx_dma);
-#endif
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -652,11 +465,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-#ifndef CONFIG_S3C_DMA
 			prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
-#else
-			prepare_dma(&sdd->rx_dma, xfer->len, xfer->rx_dma);
-#endif
 		}
 	}
 
-- 
1.9.rc1
