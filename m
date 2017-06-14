From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 08/18] spi: qup: Handle v1 dma completion differently
Date: Wed, 14 Jun 2017 11:22:21 +0530
Message-ID: <1497419551-21834-9-git-send-email-varada@codeaurora.org>
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

Do not assign i/o completion callbacks while running
on v1 of QUP.

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 7c22ee4..0f6a4c7 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -334,6 +334,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
+	dma_async_tx_callback done = qup->qup_v1 ? NULL : spi_qup_dma_done;
 	int ret;
 
 	/* before issuing the descriptors, set the QUP to run */
@@ -346,7 +347,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 
 	if (xfer->rx_buf) {
 		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM,
-					spi_qup_dma_done, &qup->rxc);
+					done, &qup->rxc);
 		if (ret)
 			return ret;
 
@@ -355,7 +356,7 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
 
 	if (xfer->tx_buf) {
 		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV,
-					spi_qup_dma_done, &qup->txc);
+					done, &qup->txc);
 		if (ret)
 			return ret;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
