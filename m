From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v5 04/14] spi: qup: Place the QUP in run mode before DMA
Date: Mon, 24 Jul 2017 13:17:15 +0530
Message-ID: <1500882445-29008-5-git-send-email-varada@codeaurora.org>
References: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 92922b6..e6294f8 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -342,6 +342,14 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	else if (xfer->tx_buf)
 		tx_done = spi_qup_dma_done;
 
+	/* before issuing the descriptors, set the QUP to run */
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
+				__func__, __LINE__);
+		return ret;
+	}
+
 	if (xfer->rx_buf) {
 		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM, rx_done);
 		if (ret)
@@ -387,6 +395,13 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 
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
