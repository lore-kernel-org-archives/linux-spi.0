From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 09/14] spi: qup: call io_config in mode specific function
Date: Mon, 24 Jul 2017 13:17:20 +0530
Message-ID: <1500882445-29008-10-git-send-email-varada@codeaurora.org>
References: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500882445-29008-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DMA transactions should only only need to call io_config only once, but
block mode might call it several times to setup several transactions so
it can handle reads/writes larger than the max size per transaction, so
we move the call to the do_ functions.

This is just refactoring, there should be no functional change

Signed-off-by: Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 82593f6..b2bda47 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -156,6 +156,8 @@ struct spi_qup {
 	struct dma_slave_config	tx_conf;
 };
 
+static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer);
+
 static inline bool spi_qup_is_flag_set(struct spi_qup *controller, u32 flag)
 {
 	u32 opflag = readl_relaxed(controller->base + QUP_OPERATIONAL);
@@ -417,10 +419,12 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
+	struct spi_master *master = spi->master;
+	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
 	if (xfer->rx_buf)
@@ -428,6 +432,10 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 	else if (xfer->tx_buf)
 		tx_done = spi_qup_dma_done;
 
+	ret = spi_qup_io_config(spi, xfer);
+	if (ret)
+		return ret;
+
 	/* before issuing the descriptors, set the QUP to run */
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
@@ -461,12 +469,17 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
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
@@ -744,10 +757,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (ret)
 		return ret;
 
-	ret = spi_qup_io_config(spi, xfer);
-	if (ret)
-		return ret;
-
 	timeout = DIV_ROUND_UP(xfer->speed_hz, MSEC_PER_SEC);
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
@@ -762,9 +771,9 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
