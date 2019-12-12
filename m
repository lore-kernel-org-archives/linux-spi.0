From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/9] spi: spi-fsl-dspi: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:48 +0200
Message-ID: <20191212135550.4634-8-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-fsl-dspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 442cff71a0d2..52ccd8397c35 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -395,17 +395,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	if (!dma)
 		return -ENOMEM;
 
-	dma->chan_rx = dma_request_slave_channel(dev, "rx");
-	if (!dma->chan_rx) {
+	dma->chan_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->chan_rx)) {
 		dev_err(dev, "rx dma channel not available\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(dma->chan_rx);
 		return ret;
 	}
 
-	dma->chan_tx = dma_request_slave_channel(dev, "tx");
-	if (!dma->chan_tx) {
+	dma->chan_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dma->chan_tx)) {
 		dev_err(dev, "tx dma channel not available\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(dma->chan_tx);
 		goto err_tx_channel;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
