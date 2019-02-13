From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] spi: sprd: Add a prefix for SPI DMA channel macros
Date: Wed, 13 Feb 2019 21:08:16 +0800
Message-ID: <94b245cf862bddcbeba065b6adc3e20f4155bdca.1550063176.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add a prefix for SPI DMA channel macros to avoid namespace conflicts,
and no functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 0c04a1d..1b7eebb 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -135,14 +135,14 @@
 #define SPRD_SPI_DMA_STEP		8
 
 enum sprd_spi_dma_channel {
-	SPI_RX,
-	SPI_TX,
-	SPI_MAX,
+	SPRD_SPI_RX,
+	SPRD_SPI_TX,
+	SPRD_SPI_MAX,
 };
 
 struct sprd_spi_dma {
 	bool enable;
-	struct dma_chan *dma_chan[SPI_MAX];
+	struct dma_chan *dma_chan[SPRD_SPI_MAX];
 	enum dma_slave_buswidth width;
 	u32 fragmens_len;
 	u32 rx_len;
@@ -516,7 +516,7 @@ static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
 
 static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_RX];
 	struct dma_slave_config config = {
 		.src_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -534,7 +534,7 @@ static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_TX];
 	struct dma_slave_config config = {
 		.dst_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -552,23 +552,23 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_request(struct sprd_spi *ss)
 {
-	ss->dma.dma_chan[SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_RX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_RX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+	ss->dma.dma_chan[SPRD_SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 
 		dev_err(ss->dev, "request RX DMA channel failed!\n");
-		return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 	}
 
-	ss->dma.dma_chan[SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_TX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_TX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+	ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 
 		dev_err(ss->dev, "request TX DMA channel failed!\n");
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
-		return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 	}
 
 	return 0;
@@ -576,11 +576,11 @@ static int sprd_spi_dma_request(struct sprd_spi *ss)
 
 static void sprd_spi_dma_release(struct sprd_spi *ss)
 {
-	if (ss->dma.dma_chan[SPI_RX])
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+	if (ss->dma.dma_chan[SPRD_SPI_RX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
 
-	if (ss->dma.dma_chan[SPI_TX])
-		dma_release_channel(ss->dma.dma_chan[SPI_TX]);
+	if (ss->dma.dma_chan[SPRD_SPI_TX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_TX]);
 }
 
 static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
-- 
1.7.9.5
