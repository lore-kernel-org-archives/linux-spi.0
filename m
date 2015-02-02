From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 3/5] spi: sh-msiof: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:30:34 -0500
Message-ID: <1422865837-10357-3-git-send-email-hofrat@osadl.org>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <der.herr@hofr.at>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Nicholas Mc Guire <der.herr@hofr.at>

return type of wait_for_completion_timeout is unsigned long not int, this
patch uses the return value of wait_for_completion_timeout in the condition 
directly rather than assigning it to an incorrect type variable.

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

The return type of wait_for_completion_timeout is unsigned long not
int. This patch resolves the type missmatch by moving the call to
wait_for_completion_timeout into the condition.

This patch was only compile tested with: polaris_defconfig
CONFIG_SPI=y, CONFIG_SPI_SH_MSIOF=m

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi-sh-msiof.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9a884e6..9409873 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -640,8 +640,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	ret = wait_for_completion_timeout(&p->done, HZ);
-	if (!ret) {
+	if (!wait_for_completion_timeout(&p->done, HZ)) {
 		dev_err(&p->pdev->dev, "PIO timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
@@ -751,8 +750,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	ret = wait_for_completion_timeout(&p->done, HZ);
-	if (!ret) {
+	if (!wait_for_completion_timeout(&p->done, HZ)) {
 		dev_err(&p->pdev->dev, "DMA timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
-- 
1.7.10.4
