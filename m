From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: fsl-lpspi: clean up indentation issue
Date: Thu, 26 Sep 2019 12:37:01 +0100
Message-ID: <20190926113701.26986-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The complete call is indented incorrectly, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d08e9324140e..5efd73cd0ead 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -779,7 +779,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-			complete(&fsl_lpspi->xfer_done);
+		complete(&fsl_lpspi->xfer_done);
 		return IRQ_HANDLED;
 	}
 
-- 
2.20.1
