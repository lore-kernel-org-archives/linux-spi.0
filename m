From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 03/14] spi: qup: Add completion timeout
Date: Fri, 28 Jul 2017 12:22:50 +0530
Message-ID: <1501224781-19519-4-git-send-email-varada@codeaurora.org>
References: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add i/o completion timeout for DMA and PIO modes.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index abe799b..fdd34c3 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -331,8 +331,10 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
+	struct spi_qup *qup = spi_master_get_devdata(master);
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
 	int ret;
 
@@ -357,10 +359,14 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 		dma_async_issue_pending(master->dma_tx);
 	}
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -379,6 +385,9 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
 
 	spi_qup_fifo_write(qup, xfer);
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
@@ -632,9 +641,9 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
 	if (spi_qup_is_dma_xfer(controller->mode))
-		ret = spi_qup_do_dma(master, xfer);
+		ret = spi_qup_do_dma(master, xfer, timeout);
 	else
-		ret = spi_qup_do_pio(master, xfer);
+		ret = spi_qup_do_pio(master, xfer, timeout);
 
 	if (ret)
 		goto exit;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
