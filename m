From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] spi/spi_s3c64xx: Staticise non-exported functions
Date: Fri, 20 Aug 2010 17:17:08 +0100
Message-ID: <1282321028-32196-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: Jassi Brar <jassi.brar@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi_s3c64xx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index a0b63b7..7e627f7 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -447,8 +447,8 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 	writel(val, regs + S3C64XX_SPI_CLK_CFG);
 }
 
-void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
-				int size, enum s3c2410_dma_buffresult res)
+static void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
+				 int size, enum s3c2410_dma_buffresult res)
 {
 	struct s3c64xx_spi_driver_data *sdd = buf_id;
 	unsigned long flags;
@@ -467,8 +467,8 @@ void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
-				int size, enum s3c2410_dma_buffresult res)
+static void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
+				 int size, enum s3c2410_dma_buffresult res)
 {
 	struct s3c64xx_spi_driver_data *sdd = buf_id;
 	unsigned long flags;
-- 
1.7.1
