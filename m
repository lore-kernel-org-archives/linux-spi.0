From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: sh-msiof: remove redundant pointer dev
Date: Fri,  3 Nov 2017 13:58:29 +0000
Message-ID: <20171103135829.8697-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer dev is assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/spi/spi-sh-msiof.c:1198:2: warning: Value stored to 'dev'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-sh-msiof.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 94d15ef0e4e6..fcd261f98b9f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1190,12 +1190,10 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 {
 	struct spi_master *master = p->master;
-	struct device *dev;
 
 	if (!master->dma_tx)
 		return;
 
-	dev = &p->pdev->dev;
 	dma_unmap_single(master->dma_rx->device->dev, p->rx_dma_addr,
 			 PAGE_SIZE, DMA_FROM_DEVICE);
 	dma_unmap_single(master->dma_tx->device->dev, p->tx_dma_addr,
-- 
2.14.1
