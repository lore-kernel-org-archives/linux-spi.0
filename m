From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/9] spi: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:44 +0200
Message-ID: <20191212135550.4634-4-peter.ujfalusi@ti.com>
References: <20191212135550.4634-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
To: <broonie@kernel.org>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <baohua@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212135550.4634-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-bcm2835.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 662d55e9f21d..69df79914504 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -888,8 +888,8 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 	}
 }
 
-static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
-			     struct bcm2835_spi *bs)
+static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
+			    struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
 	const __be32 *addr;
@@ -900,19 +900,24 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
 	if (!addr) {
 		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
-		goto err;
+		/* Fall back to interrupt mode */
+		return 0;
 	}
 	dma_reg_base = be32_to_cpup(addr);
 
 	/* get tx/rx dma */
-	ctlr->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!ctlr->dma_tx) {
+	ctlr->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(ctlr->dma_tx)) {
 		dev_err(dev, "no tx-dma configuration found - not using dma mode\n");
+		ret = PTR_ERR(ctlr->dma_tx);
+		ctlr->dma_tx = NULL;
 		goto err;
 	}
-	ctlr->dma_rx = dma_request_slave_channel(dev, "rx");
-	if (!ctlr->dma_rx) {
+	ctlr->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(ctlr->dma_rx)) {
 		dev_err(dev, "no rx-dma configuration found - not using dma mode\n");
+		ret = PTR_ERR(ctlr->dma_rx);
+		ctlr->dma_rx = NULL;
 		goto err_release;
 	}
 
@@ -997,7 +1002,7 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	/* all went well, so set can_dma */
 	ctlr->can_dma = bcm2835_spi_can_dma;
 
-	return;
+	return 0;
 
 err_config:
 	dev_err(dev, "issue configuring dma: %d - not using DMA mode\n",
@@ -1005,7 +1010,14 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 err_release:
 	bcm2835_dma_release(ctlr, bs);
 err:
-	return;
+	/*
+	 * Only report error for deferred probing, otherwise fall back to
+	 * interrupt mode
+	 */
+	if (ret != -EPROBE_DEFER)
+		ret = 0;
+
+	return ret;
 }
 
 static int bcm2835_spi_transfer_one_poll(struct spi_controller *ctlr,
@@ -1317,7 +1329,9 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
-	bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	if (err)
+		goto out_clk_disable;
 
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
