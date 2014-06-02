From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 12/18] spi: rspi: Pass sg_tables instead of spi_tranfer to rspi_*_dma()
Date: Mon,  2 Jun 2014 15:38:14 +0200
Message-ID: <1401716301-29612-13-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The DMA routines only need access to the scatter-gather tables inside the
spi_transfer structures, hence just pass those.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 3dea8adfdcf3..bfa5e7e5df5a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -463,13 +463,13 @@ static void rspi_dma_complete(void *arg)
 	wake_up_interruptible(&rspi->wait);
 }
 
-static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
+static int rspi_send_dma(struct rspi_data *rspi, struct sg_table *tx)
 {
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
-	desc = dmaengine_prep_slave_sg(rspi->master->dma_tx, t->tx_sg.sgl,
-				       t->tx_sg.nents, DMA_TO_DEVICE,
+	desc = dmaengine_prep_slave_sg(rspi->master->dma_tx, tx->sgl,
+				       tx->nents, DMA_TO_DEVICE,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		return -EIO;
@@ -530,21 +530,22 @@ static void qspi_receive_init(const struct rspi_data *rspi)
 	rspi_write8(rspi, 0, QSPI_SPBFCR);
 }
 
-static int rspi_send_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
+static int rspi_send_receive_dma(struct rspi_data *rspi, struct sg_table *tx,
+				 struct sg_table *rx)
 {
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	int ret;
 
 	/* prepare transmit transfer */
-	desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx, t->tx_sg.sgl,
-					  t->tx_sg.nents, DMA_TO_DEVICE,
+	desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx, tx->sgl,
+					  tx->nents, DMA_TO_DEVICE,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx)
 		return -EIO;
 
 	/* prepare receive transfer */
-	desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx, t->rx_sg.sgl,
-					  t->rx_sg.nents, DMA_FROM_DEVICE,
+	desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx, rx->sgl,
+					  rx->nents, DMA_FROM_DEVICE,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx)
 		return -EIO;
@@ -616,9 +617,10 @@ static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
 
 	if (master->can_dma && __rspi_can_dma(rspi, xfer)) {
 		if (xfer->rx_buf)
-			return rspi_send_receive_dma(rspi, xfer);
+			return rspi_send_receive_dma(rspi, &xfer->tx_sg,
+						     &xfer->rx_sg);
 		else
-			return rspi_send_dma(rspi, xfer);
+			return rspi_send_dma(rspi, &xfer->tx_sg);
 	}
 
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
-- 
1.9.1

