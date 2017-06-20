From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v3 05/15] spi: qup: Place the QUP in run mode before DMA
Date: Tue, 20 Jun 2017 14:40:47 +0530
Message-ID: <1497949857-1852-6-git-send-email-varada@codeaurora.org>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index d3ccf53..0683e47 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -336,6 +336,14 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
+	/* before issuing the descriptors, set the QUP to run */
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
+				__func__, __LINE__);
+		return ret;
+	}
+
 	if (xfer->rx_buf) {
 		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM,
 					spi_qup_dma_done, &qup->rxc);
@@ -383,6 +391,13 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 
 	spi_qup_fifo_write(qup, xfer);
 
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
+				__func__, __LINE__);
+		return ret;
+	}
+
 	if (!wait_for_completion_timeout(&qup->done, timeout))
 		return -ETIMEDOUT;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
