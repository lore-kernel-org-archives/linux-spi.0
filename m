From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH v2] spi: mxs: cleanup wait_for_completion return handling
Date: Thu,  5 Feb 2015 09:47:06 -0500
Message-ID: <1423147626-3525-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int, this
patch uses the return value of wait_for_completion_timeout in the condition
directly rather than adding a additional appropriately typed variable.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

v2: fixup my slightly brain-dead indentation as suggested by Mark Brown 
    <broonie@kernel.org>.

This patch was only compile tested with mxs_defconfig
(implies CONFIG_SPI_MXS=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

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
+					 msecs_to_jiffies(SSP_TIMEOUT))) {
 		dev_err(ssp->dev, "DMA transfer timeout\n");
 		ret = -ETIMEDOUT;
 		dmaengine_terminate_all(ssp->dmach);
-- 
1.7.10.4
