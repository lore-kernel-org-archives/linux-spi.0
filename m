From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 08/26] spi: tegra114: configure dma burst size to fifo trig level
Date: Tue, 26 Mar 2019 22:56:29 -0700
Message-ID: <1553666207-11414-8-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fixes: Configure DMA burst size to be same as SPI TX/RX trigger levels
to avoid mismatch.

SPI FIFO trigger levels are calculated based on the transfer length.
So this patch moves DMA slave configuration to happen before start
of DMAs.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 477828051aba..b7e71676a506 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -530,6 +530,8 @@ static int tegra_spi_start_dma_based_transfer(
 	u32 val;
 	unsigned int len;
 	int ret = 0;
+	u8 dma_burst;
+	struct dma_slave_config dma_sconfig = {0};
 
 	val = SPI_DMA_BLK_SET(tspi->curr_dma_words - 1);
 	tegra_spi_writel(tspi, val, SPI_DMA_BLK);
@@ -541,12 +543,16 @@ static int tegra_spi_start_dma_based_transfer(
 		len = tspi->curr_dma_words * 4;
 
 	/* Set attention level based on length of transfer */
-	if (len & 0xF)
+	if (len & 0xF) {
 		val |= SPI_TX_TRIG_1 | SPI_RX_TRIG_1;
-	else if (((len) >> 4) & 0x1)
+		dma_burst = 1;
+	} else if (((len) >> 4) & 0x1) {
 		val |= SPI_TX_TRIG_4 | SPI_RX_TRIG_4;
-	else
+		dma_burst = 4;
+	} else {
 		val |= SPI_TX_TRIG_8 | SPI_RX_TRIG_8;
+		dma_burst = 8;
+	}
 
 	if (tspi->cur_direction & DATA_DIR_TX)
 		val |= SPI_IE_TX;
@@ -557,7 +563,18 @@ static int tegra_spi_start_dma_based_transfer(
 	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
 	tspi->dma_control_reg = val;
 
+	dma_sconfig.device_fc = true;
 	if (tspi->cur_direction & DATA_DIR_TX) {
+		dma_sconfig.dst_addr = tspi->phys + SPI_TX_FIFO;
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.dst_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tspi->tx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
 		tegra_spi_copy_client_txbuf_to_spi_txbuf(tspi, t);
 		ret = tegra_spi_start_tx_dma(tspi, len);
 		if (ret < 0) {
@@ -568,6 +585,16 @@ static int tegra_spi_start_dma_based_transfer(
 	}
 
 	if (tspi->cur_direction & DATA_DIR_RX) {
+		dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.src_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tspi->rx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
 		/* Make the dma buffer to read by dma */
 		dma_sync_single_for_device(tspi->dev, tspi->rx_dma_phys,
 				tspi->dma_buf_size, DMA_FROM_DEVICE);
@@ -628,7 +655,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	u32 *dma_buf;
 	dma_addr_t dma_phys;
 	int ret;
-	struct dma_slave_config dma_sconfig;
 
 	dma_chan = dma_request_slave_channel_reason(tspi->dev,
 					dma_to_memory ? "rx" : "tx");
@@ -649,19 +675,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 	}
 
 	if (dma_to_memory) {
-		dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
-		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.src_maxburst = 0;
-	} else {
-		dma_sconfig.dst_addr = tspi->phys + SPI_TX_FIFO;
-		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.dst_maxburst = 0;
-	}
-
-	ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
-	if (ret)
-		goto scrub;
-	if (dma_to_memory) {
 		tspi->rx_dma_chan = dma_chan;
 		tspi->rx_dma_buf = dma_buf;
 		tspi->rx_dma_phys = dma_phys;
@@ -671,11 +684,6 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
 		tspi->tx_dma_phys = dma_phys;
 	}
 	return 0;
-
-scrub:
-	dma_free_coherent(tspi->dev, tspi->dma_buf_size, dma_buf, dma_phys);
-	dma_release_channel(dma_chan);
-	return ret;
 }
 
 static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
-- 
2.7.4
