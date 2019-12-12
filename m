From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/9] spi: atmel: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:42 +0200
Message-ID: <20191212135550.4634-2-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-atmel.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 56f0ca361deb..013458cabe3c 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -514,26 +514,19 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		err = PTR_ERR(master->dma_tx);
-		if (err == -EPROBE_DEFER) {
-			dev_warn(dev, "no DMA channel available at the moment\n");
-			goto error_clear;
-		}
-		dev_err(dev,
-			"DMA TX channel not available, SPI unable to use DMA\n");
-		err = -EBUSY;
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "No TX DMA channel, DMA is disabled\n");
 		goto error_clear;
 	}
 
-	/*
-	 * No reason to check EPROBE_DEFER here since we have already requested
-	 * tx channel. If it fails here, it's for another reason.
-	 */
-	master->dma_rx = dma_request_slave_channel(dev, "rx");
-
-	if (!master->dma_rx) {
-		dev_err(dev,
-			"DMA RX channel not available, SPI unable to use DMA\n");
-		err = -EBUSY;
+	master->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		err = PTR_ERR(master->dma_rx);
+		/*
+		 * No reason to check EPROBE_DEFER here since we have already
+		 * requested tx channel.
+		 */
+		dev_err(dev, "No RX DMA channel, DMA is disabled\n");
 		goto error;
 	}
 
@@ -548,7 +541,7 @@ static int atmel_spi_configure_dma(struct spi_master *master,
 
 	return 0;
 error:
-	if (master->dma_rx)
+	if (!IS_ERR(master->dma_rx))
 		dma_release_channel(master->dma_rx);
 	if (!IS_ERR(master->dma_tx))
 		dma_release_channel(master->dma_tx);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
