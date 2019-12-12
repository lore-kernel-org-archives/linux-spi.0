From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 9/9] spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:50 +0200
Message-ID: <20191212135550.4634-10-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-stm32.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 7d75632c4151..e041f9c4ec47 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1879,17 +1879,29 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->transfer_one = stm32_spi_transfer_one;
 	master->unprepare_message = stm32_spi_unprepare_msg;
 
-	spi->dma_tx = dma_request_slave_channel(spi->dev, "tx");
-	if (!spi->dma_tx)
+	spi->dma_tx = dma_request_chan(spi->dev, "tx");
+	if (IS_ERR(spi->dma_tx)) {
+		ret = PTR_ERR(spi->dma_tx);
+		spi->dma_tx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_disable;
+
 		dev_warn(&pdev->dev, "failed to request tx dma channel\n");
-	else
+	} else {
 		master->dma_tx = spi->dma_tx;
+	}
+
+	spi->dma_rx = dma_request_chan(spi->dev, "rx");
+	if (IS_ERR(spi->dma_rx)) {
+		ret = PTR_ERR(spi->dma_rx);
+		spi->dma_rx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto err_dma_release;
 
-	spi->dma_rx = dma_request_slave_channel(spi->dev, "rx");
-	if (!spi->dma_rx)
 		dev_warn(&pdev->dev, "failed to request rx dma channel\n");
-	else
+	} else {
 		master->dma_rx = spi->dma_rx;
+	}
 
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
@@ -1901,26 +1913,26 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed: %d\n",
 			ret);
-		goto err_dma_release;
+		goto err_pm_disable;
 	}
 
 	if (!master->cs_gpiods) {
 		dev_err(&pdev->dev, "no CS gpios available\n");
 		ret = -EINVAL;
-		goto err_dma_release;
+		goto err_pm_disable;
 	}
 
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
 
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 err_dma_release:
 	if (spi->dma_tx)
 		dma_release_channel(spi->dma_tx);
 	if (spi->dma_rx)
 		dma_release_channel(spi->dma_rx);
-
-	pm_runtime_disable(&pdev->dev);
 err_clk_disable:
 	clk_disable_unprepare(spi->clk);
 err_master_put:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
