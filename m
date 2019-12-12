From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 8/9] spi: stm32-qspi: Use dma_request_chan() instead dma_request_slave_channel()
Date: Thu, 12 Dec 2019 15:55:49 +0200
Message-ID: <20191212135550.4634-9-peter.ujfalusi@ti.com>
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
 drivers/spi/spi-stm32-qspi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 4e726929bb4f..4ef569b47aa6 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -470,10 +470,11 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
+static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 {
 	struct dma_slave_config dma_cfg;
 	struct device *dev = qspi->dev;
+	int ret = 0;
 
 	memset(&dma_cfg, 0, sizeof(dma_cfg));
 
@@ -484,8 +485,13 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 	dma_cfg.src_maxburst = 4;
 	dma_cfg.dst_maxburst = 4;
 
-	qspi->dma_chrx = dma_request_slave_channel(dev, "rx");
-	if (qspi->dma_chrx) {
+	qspi->dma_chrx = dma_request_chan(dev, "rx");
+	if (IS_ERR(qspi->dma_chrx)) {
+		ret = PTR_ERR(qspi->dma_chrx);
+		qspi->dma_chrx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto out;
+	} else {
 		if (dmaengine_slave_config(qspi->dma_chrx, &dma_cfg)) {
 			dev_err(dev, "dma rx config failed\n");
 			dma_release_channel(qspi->dma_chrx);
@@ -493,8 +499,11 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		}
 	}
 
-	qspi->dma_chtx = dma_request_slave_channel(dev, "tx");
-	if (qspi->dma_chtx) {
+	qspi->dma_chtx = dma_request_chan(dev, "tx");
+	if (IS_ERR(qspi->dma_chtx)) {
+		ret = PTR_ERR(qspi->dma_chtx);
+		qspi->dma_chtx = NULL;
+	} else {
 		if (dmaengine_slave_config(qspi->dma_chtx, &dma_cfg)) {
 			dev_err(dev, "dma tx config failed\n");
 			dma_release_channel(qspi->dma_chtx);
@@ -502,7 +511,13 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		}
 	}
 
+out:
 	init_completion(&qspi->dma_completion);
+
+	if (ret != -EPROBE_DEFER)
+		ret = 0;
+
+	return ret;
 }
 
 static void stm32_qspi_dma_free(struct stm32_qspi *qspi)
@@ -608,7 +623,10 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	qspi->dev = dev;
 	platform_set_drvdata(pdev, qspi);
-	stm32_qspi_dma_setup(qspi);
+	ret = stm32_qspi_dma_setup(qspi);
+	if (ret)
+		goto err;
+
 	mutex_init(&qspi->lock);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
