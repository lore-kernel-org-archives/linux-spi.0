From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] spi: rspi: use correct enum for DMA transfer direction
Date: Mon, 19 Mar 2018 22:42:31 +0100
Message-ID: <20180319214231.15529-1-stefan@agner.ch>
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use enum dma_transfer_direction as required by dmaengine_prep_slave_sg
instead of enum dma_data_direction.

This fixes two warnings when building with clang:
  drivers/spi/spi-rspi.c:538:26: warning: implicit conversion from enumeration
      type 'enum dma_data_direction' to different enumeration type
      'enum dma_transfer_direction' [-Wenum-conversion]
                                        rx->sgl, rx->nents, DMA_FROM_DEVICE,
                                                            ^~~~~~~~~~~~~~~
  drivers/spi/spi-rspi.c:558:26: warning: implicit conversion from enumeration
      type 'enum dma_data_direction' to different enumeration type
      'enum dma_transfer_direction' [-Wenum-conversion]
                                        tx->sgl, tx->nents, DMA_TO_DEVICE,
                                                            ^~~~~~~~~~~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 0835a8d88fb8..3e5a31d338fe 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -535,7 +535,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 	/* First prepare and submit the DMA request(s), as this may fail */
 	if (rx) {
 		desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx,
-					rx->sgl, rx->nents, DMA_FROM_DEVICE,
+					rx->sgl, rx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx) {
 			ret = -EAGAIN;
@@ -555,7 +555,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 	if (tx) {
 		desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx,
-					tx->sgl, tx->nents, DMA_TO_DEVICE,
+					tx->sgl, tx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx) {
 			ret = -EAGAIN;
-- 
2.16.2
