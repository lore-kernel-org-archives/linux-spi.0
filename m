From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH] spi: Compatibility with direction which is used in samsung DMA
 operation
Date: Sat, 10 Mar 2012 09:48:46 +0900
Message-ID: <003801ccfe57$8ccff2f0$a66fd8d0$%kim@samsung.com>
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

I found that there are two kind of direction type.
First one is dma_data_direction defined in include/linux/dma-direction.h.
It is used for parameter of dma_map/unmap_single in spi-s3c64xx.
The other one is dma_transter_direction defined in include/linux/dmaengine.h.
It is used for direction of samsung DMA operation
(arch/arm/plat-samsung/dma-ops.c).
This patch is just some changes to use direction defines
which is used in samsung DMA operation.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dcf7e10..003a1bf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -239,7 +239,7 @@ static void s3c64xx_spi_dmacb(void *data)
 	struct s3c64xx_spi_dma_data *dma = data;
 	unsigned long flags;
 
-	if (dma->direction == DMA_FROM_DEVICE)
+	if (dma->direction == DMA_DEV_TO_MEM)
 		sdd = container_of(data,
 			struct s3c64xx_spi_driver_data, rx_dma);
 	else
@@ -248,7 +248,7 @@ static void s3c64xx_spi_dmacb(void *data)
 
 	spin_lock_irqsave(&sdd->lock, flags);
 
-	if (dma->direction == DMA_FROM_DEVICE) {
+	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd->state &= ~RXBUSY;
 		if (!(sdd->state & TXBUSY))
 			complete(&sdd->xfer_completion);
@@ -267,7 +267,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	struct s3c64xx_spi_driver_data *sdd;
 	struct samsung_dma_prep_info info;
 
-	if (dma->direction == DMA_FROM_DEVICE)
+	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
 	else
@@ -1021,9 +1021,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
 	sdd->tx_dma.dmach = dmatx_res->start;
-	sdd->tx_dma.direction = DMA_TO_DEVICE;
+	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
 	sdd->rx_dma.dmach = dmarx_res->start;
-	sdd->rx_dma.direction = DMA_FROM_DEVICE;
+	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
 	sdd->cur_bpw = 8;
 
-- 
1.7.1
