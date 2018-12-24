From: cezary.gapinski@gmail.com
Subject: [PATCH v2 03/14] spi: stm32: fix DMA configuration with only one channel
Date: Mon, 24 Dec 2018 23:00:29 +0100
Message-ID: <1545688840-23992-4-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

When SPI driver is configured to work only with TX or RX DMA channel
then dmaengine functions can dereferene NULL pointer.

Running full-duplex mode when when only RX or TX DMA channel is
available can cause overrun condition or incorrect writing to transmit
buffer so disable this types of DMA configuration and go back to
interrupt mode.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 51d7f72..8310f14 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -427,9 +427,9 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
 		stm32_spi_read_rxfifo(spi, true);
 
-	if (spi->cur_usedma && spi->tx_buf)
+	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
-	if (spi->cur_usedma && spi->rx_buf)
+	if (spi->cur_usedma && spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 	stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
@@ -750,7 +750,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	spin_lock_irqsave(&spi->lock, flags);
 
 	rx_dma_desc = NULL;
-	if (spi->rx_buf) {
+	if (spi->rx_buf && spi->dma_rx) {
 		stm32_spi_dma_config(spi, &rx_dma_conf, DMA_DEV_TO_MEM);
 		dmaengine_slave_config(spi->dma_rx, &rx_dma_conf);
 
@@ -765,7 +765,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	tx_dma_desc = NULL;
-	if (spi->tx_buf) {
+	if (spi->tx_buf && spi->dma_tx) {
 		stm32_spi_dma_config(spi, &tx_dma_conf, DMA_MEM_TO_DEV);
 		dmaengine_slave_config(spi->dma_tx, &tx_dma_conf);
 
@@ -776,8 +776,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					DMA_PREP_INTERRUPT);
 	}
 
-	if ((spi->tx_buf && !tx_dma_desc) ||
-	    (spi->rx_buf && !rx_dma_desc))
+	if ((spi->tx_buf && spi->dma_tx && !tx_dma_desc) ||
+	    (spi->rx_buf && spi->dma_rx && !rx_dma_desc))
+		goto dma_desc_error;
+
+	if (spi->cur_comm == SPI_FULL_DUPLEX && (!tx_dma_desc || !rx_dma_desc))
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
@@ -822,7 +825,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	return 1;
 
 dma_submit_error:
-	if (spi->rx_buf)
+	if (spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 dma_desc_error:
@@ -832,6 +835,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 	dev_info(spi->dev, "DMA issue: fall back to irq transfer\n");
 
+	spi->cur_usedma = false;
 	return stm32_spi_transfer_one_irq(spi);
 }
 
@@ -984,7 +988,7 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
 	spi->cur_usedma = (master->can_dma &&
-			   stm32_spi_can_dma(master, spi_dev, transfer));
+			   master->can_dma(master, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
-- 
2.7.4
