From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] spi: Add the use of DMA config operation
Date: Wed, 08 Feb 2012 15:52:33 +0900
Message-ID: <000401cce62e$3c0cd5e0$b42681a0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Grant Likely' <grant.likely@secretlab.ca>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Kyoungil Kim' <ki0351.kim@samsung.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Config operation is separated from request operation in DMA common operation.
Because spi driver can change the DMA config for every message.
So this patch is using the separated DMA config operation.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dcf7e10..f3b7f6a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -265,15 +265,27 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 					unsigned len, dma_addr_t buf)
 {
 	struct s3c64xx_spi_driver_data *sdd;
-	struct samsung_dma_prep_info info;
+	struct samsung_dma_prep info;
+	struct samsung_dma_config config;
 
-	if (dma->direction == DMA_FROM_DEVICE)
+	if (dma->direction == DMA_FROM_DEVICE) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-	else
+
+		config.direction = sdd->rx_dma.direction;
+		config.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
+		config.width = sdd->cur_bpw / 8;
+		sdd->ops->config(sdd->rx_dma.ch, &config);
+	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
 
+		config.direction =  sdd->tx_dma.direction;
+		config.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+		config.width = sdd->cur_bpw / 8;
+		sdd->ops->config(sdd->tx_dma.ch, &config);
+	}
+
 	info.cap = DMA_SLAVE;
 	info.len = len;
 	info.fp = s3c64xx_spi_dmacb;
@@ -287,20 +299,15 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
 {
-	struct samsung_dma_info info;
+	struct samsung_dma_req req;
 
 	sdd->ops = samsung_dma_get_ops();
 
-	info.cap = DMA_SLAVE;
-	info.client = &s3c64xx_spi_dma_client;
-	info.width = sdd->cur_bpw / 8;
-
-	info.direction = sdd->rx_dma.direction;
-	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
-	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &info);
-	info.direction =  sdd->tx_dma.direction;
-	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
-	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &info);
+	req.cap = DMA_SLAVE;
+	req.client = &s3c64xx_spi_dma_client;
+
+	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &req);
+	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &req);
 
 	return 1;
 }
-- 
1.7.1
