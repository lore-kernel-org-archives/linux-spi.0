From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 15/15] spi: qup: support for qup v1 dma
Date: Tue, 20 Jun 2017 14:40:57 +0530
Message-ID: <1497949857-1852-16-git-send-email-varada@codeaurora.org>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently the QUP Version v1 does not work with DMA so added
the support for the same.

1. It uses ADM DMA which requires TX and RX CRCI
2. DMA channel initialization need to be done after setting
   block size for having valid values in maxburst
3. QUP mode should be DMOV instead of BAM.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 .../devicetree/bindings/spi/qcom,spi-qup.txt       |  6 ++++
 drivers/spi/spi-qup.c                              | 35 +++++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
index 5c09077..e754181 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
@@ -38,6 +38,12 @@ Optional properties:
 - dma-names:    Names for the dma channels, if present. There must be at
                 least one channel named "tx" for transmit and named "rx" for
                 receive.
+- qcom,tx-crci: Identificator for Client Rate Control Interface (CRCI) to be
+		used with TX DMA channel. Required when using DMA for
+		transmission with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
+- qcom,rx-crci: Identificator for Client Rate Control Interface (CRCI) to be
+		used with RX DMA channel. Required when using DMA for
+		receiving with QUP Version 1 i.e qcom,spi-qup-v1.1.1.
 
 SPI slave nodes must be children of the SPI master node and can contain
 properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ca5206e..b608efa3 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -658,7 +658,8 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 	else if (spi->master->can_dma &&
 		 spi->master->can_dma(spi->master, spi, xfer) &&
 		 spi->master->cur_msg_mapped)
-		controller->mode = QUP_IO_M_MODE_BAM;
+		controller->mode = controller->qup_v1 ? QUP_IO_M_MODE_DMOV :
+							QUP_IO_M_MODE_BAM;
 	else
 		controller->mode = QUP_IO_M_MODE_BLOCK;
 
@@ -697,6 +698,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
 		break;
 	case QUP_IO_M_MODE_BAM:
+	case QUP_IO_M_MODE_DMOV:
 		reinit_completion(&controller->txc);
 		reinit_completion(&controller->rxc);
 		writel_relaxed(controller->n_words,
@@ -901,6 +903,7 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	struct dma_slave_config *rx_conf = &spi->rx_conf,
 				*tx_conf = &spi->tx_conf;
 	struct device *dev = spi->dev;
+	u32 tx_crci = 0, rx_crci = 0;
 	int ret;
 
 	/* allocate dma resources, if available */
@@ -914,16 +917,34 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 		goto err_tx;
 	}
 
+	if (spi->qup_v1) {
+		ret = of_property_read_u32(dev->of_node, "qcom,tx-crci",
+					   &tx_crci);
+		if (ret) {
+			dev_err(dev, "missing property qcom,tx-crci\n");
+			goto err;
+		}
+
+		ret = of_property_read_u32(dev->of_node, "qcom,rx-crci",
+					   &rx_crci);
+		if (ret) {
+			dev_err(dev, "missing property qcom,rx-crci\n");
+			goto err;
+		}
+	}
+
 	/* set DMA parameters */
 	rx_conf->direction = DMA_DEV_TO_MEM;
 	rx_conf->device_fc = 1;
 	rx_conf->src_addr = base + QUP_INPUT_FIFO;
 	rx_conf->src_maxburst = spi->in_blk_sz;
+	rx_conf->slave_id = rx_crci;
 
 	tx_conf->direction = DMA_MEM_TO_DEV;
 	tx_conf->device_fc = 1;
 	tx_conf->dst_addr = base + QUP_OUTPUT_FIFO;
 	tx_conf->dst_maxburst = spi->out_blk_sz;
+	tx_conf->slave_id = tx_crci;
 
 	ret = dmaengine_slave_config(master->dma_rx, rx_conf);
 	if (ret) {
@@ -1050,12 +1071,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->cclk = cclk;
 	controller->irq = irq;
 
-	ret = spi_qup_init_dma(master, res->start);
-	if (ret == -EPROBE_DEFER)
-		goto error;
-	else if (!ret)
-		master->can_dma = spi_qup_can_dma;
-
 	/* set v1 flag if device is version 1 */
 	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
 		controller->qup_v1 = 1;
@@ -1092,6 +1107,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 		 controller->in_blk_sz, controller->in_fifo_sz,
 		 controller->out_blk_sz, controller->out_fifo_sz);
 
+	ret = spi_qup_init_dma(master, res->start);
+	if (ret == -EPROBE_DEFER)
+		goto error;
+	else if (!ret)
+		master->can_dma = spi_qup_can_dma;
+
 	writel_relaxed(1, base + QUP_SW_RESET);
 
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
