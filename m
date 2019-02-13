From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: Add a prefix for SPI DMA channel macros" to the spi tree
Date: Wed, 13 Feb 2019 15:57:03 +0000 (GMT)
Message-ID: <20190213155703.14C9C1128158@debutante.sirena.org.uk>
References: <94b245cf862bddcbeba065b6adc3e20f4155bdca.1550063176.git.baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94b245cf862bddcbeba065b6adc3e20f4155bdca.1550063176.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: Add a prefix for SPI DMA channel macros

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5e060c48bc52d6e269cd01261cce3b260eba84ba Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 13 Feb 2019 21:08:16 +0800
Subject: [PATCH] spi: sprd: Add a prefix for SPI DMA channel macros

Add a prefix for SPI DMA channel macros to avoid namespace conflicts,
and no functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a4398e737650..f6c8838f7dc3 100644
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
@@ -514,7 +514,7 @@ static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
 
 static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_RX];
 	struct dma_slave_config config = {
 		.src_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -532,7 +532,7 @@ static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_TX];
 	struct dma_slave_config config = {
 		.dst_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -550,23 +550,23 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
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
@@ -574,11 +574,11 @@ static int sprd_spi_dma_request(struct sprd_spi *ss)
 
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
2.20.1
