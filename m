From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/5] spi: mxs: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:30:33 -0500
Message-ID: <1422865837-10357-2-git-send-email-hofrat@osadl.org>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int, this
patch uses the return value of wait_for_completion_timeout in the condition
directly rather than adding a additional appropriately typed variable.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The return type of wait_for_completion_timeout is unsigned long not
int. This patch resolves the type mismatch by moving the call to
wait_for_completion_timeout into the condition.

This patch was only compile tested with mxs_defconfig

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-mxs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 4045a1e..d051312 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -282,9 +282,8 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	dmaengine_submit(desc);
 	dma_async_issue_pending(ssp->dmach);
 
-	ret = wait_for_completion_timeout(&spi->c,
-				msecs_to_jiffies(SSP_TIMEOUT));
-	if (!ret) {
+	if (!wait_for_completion_timeout(&spi->c,
+	    msecs_to_jiffies(SSP_TIMEOUT))) {
 		dev_err(ssp->dev, "DMA transfer timeout\n");
 		ret = -ETIMEDOUT;
 		dmaengine_terminate_all(ssp->dmach);
-- 
1.7.10.4
