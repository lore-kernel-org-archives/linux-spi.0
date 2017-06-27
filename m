From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v4 10/14] spi: qup: call io_config in mode specific function
Date: Tue, 27 Jun 2017 15:15:27 +0530
Message-ID: <1498556731-13087-11-git-send-email-varada@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DMA transactions should only only need to call io_config only once, but
block mode might call it several times to setup several transactions so
it can handle reads/writes larger than the max size per transaction, so
we move the call to the do_ functions.

This is just refactoring, there should be no functional change

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index bfb6d27..37b51e3 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -158,6 +158,8 @@ struct spi_qup {
 	struct dma_slave_config	tx_conf;
 };
 
+static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer);
+
 static inline bool spi_qup_is_flag_set(struct spi_qup *controller, u32 flag)
 {
 	u32 opflag = readl_relaxed(controller->base + QUP_OPERATIONAL);
@@ -416,12 +418,17 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
+	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
+	ret = spi_qup_io_config(spi, xfer);
+	if (ret)
+		return ret;
+
 	/* before issuing the descriptors, set the QUP to run */
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
@@ -457,12 +464,17 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
+	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
+	ret = spi_qup_io_config(spi, xfer);
+	if (ret)
+		return ret;
+
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
 		dev_warn(qup->dev, "cannot set RUN state\n");
@@ -743,18 +755,14 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (ret)
 		return ret;
 
-	ret = spi_qup_io_config(spi, xfer);
-	if (ret)
-		return ret;
-
 	timeout = DIV_ROUND_UP(xfer->speed_hz, MSEC_PER_SEC);
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
 	if (spi_qup_is_dma_xfer(controller->mode))
-		ret = spi_qup_do_dma(master, xfer, timeout);
+		ret = spi_qup_do_dma(spi, xfer, timeout);
 	else
-		ret = spi_qup_do_pio(master, xfer, timeout);
+		ret = spi_qup_do_pio(spi, xfer, timeout);
 
 	if (ret)
 		goto exit;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
