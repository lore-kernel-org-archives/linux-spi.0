From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] spi: s3c64xx: Fix build
Date: Wed, 14 Mar 2012 16:52:14 +0000
Message-ID: <1331743934-23577-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Boojin Kim <boojin.kim@samsung.com>,
	Kyoungil Kim <ki0351.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Commit 054ebc (spi: Compatibility with direction which is used in samsung
DMA operation) does not build as one hunk adds a brace to the first branch
of an if statement without adding at least the correspoding close. Remove
the unwanted brace.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c40d118..3180100 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -264,7 +264,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	struct s3c64xx_spi_driver_data *sdd;
 	struct samsung_dma_prep_info info;
 
-	if (dma->direction == DMA_DEV_TO_MEM) {
+	if (dma->direction == DMA_DEV_TO_MEM)
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
 	else
-- 
1.7.9.1
