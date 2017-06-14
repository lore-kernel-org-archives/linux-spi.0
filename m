From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 04/18] spi: qup: Add completion timeout for fifo/block mode
Date: Wed, 14 Jun 2017 11:22:17 +0530
Message-ID: <1497419551-21834-5-git-send-email-varada@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 272e48e..d3ccf53 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -330,7 +330,8 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -362,7 +363,8 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -381,6 +383,9 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
 
 	spi_qup_fifo_write(qup, xfer);
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
@@ -624,7 +629,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
-
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->xfer     = xfer;
 	controller->error    = 0;
@@ -635,10 +639,10 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		reinit_completion(&controller->rxc);
 		reinit_completion(&controller->txc);
-		ret = spi_qup_do_dma(master, xfer);
+		ret = spi_qup_do_dma(master, xfer, timeout);
 	} else {
 		reinit_completion(&controller->done);
-		ret = spi_qup_do_pio(master, xfer);
+		ret = spi_qup_do_pio(master, xfer, timeout);
 	}
 
 	if (ret)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
