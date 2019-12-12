From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 6/9] spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:47 +0200
Message-ID: <20191212135550.4634-7-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-sirf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index e1e639191557..8419e6722e17 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1126,16 +1126,16 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* request DMA channels */
-	sspi->rx_chan = dma_request_slave_channel(&pdev->dev, "rx");
-	if (!sspi->rx_chan) {
+	sspi->rx_chan = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(sspi->rx_chan)) {
 		dev_err(&pdev->dev, "can not allocate rx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(sspi->rx_chan);
 		goto free_master;
 	}
-	sspi->tx_chan = dma_request_slave_channel(&pdev->dev, "tx");
-	if (!sspi->tx_chan) {
+	sspi->tx_chan = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(sspi->tx_chan)) {
 		dev_err(&pdev->dev, "can not allocate tx dma channel\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(sspi->tx_chan);
 		goto free_rx_dma;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
