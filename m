From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:42:54 +0200
Message-ID: <20191113094256.1108-8-peter.ujfalusi@ti.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
To: <broonie@kernel.org>, <radu_nicolae.pirea@upb.ro>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <linus.walleij@linaro.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <andi@etezian.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113094256.1108-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7b7151ec14c8..cf67ea60dc0e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1154,15 +1154,13 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	if (!is_polling(sdd)) {
 		/* Acquire DMA channels */
-		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
-								  "rx");
+		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");
 		if (IS_ERR(sdd->rx_dma.ch)) {
 			dev_err(&pdev->dev, "Failed to get RX DMA channel\n");
 			ret = PTR_ERR(sdd->rx_dma.ch);
 			goto err_disable_io_clk;
 		}
-		sdd->tx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
-								  "tx");
+		sdd->tx_dma.ch = dma_request_chan(&pdev->dev, "tx");
 		if (IS_ERR(sdd->tx_dma.ch)) {
 			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
 			ret = PTR_ERR(sdd->tx_dma.ch);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
