From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH] drivers: spi: fix compiler warning in spi-s3c64xx
Date: Mon, 23 Feb 2015 12:30:46 +0000
Message-ID: <1424694646-26002-1-git-send-email-andre.przywara@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	arnd@arndb.de
To: Kukjin Kim <kgene@kernel.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The Exynos 7 arm64 support now allows the S3C64xx SPI driver to be
compiled into an ARM64 kernel, so the cast from the [rt]x_dmach int
variable to a void* in this driver now triggers a warning.
Add a long cast to silence the compiler.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this is only compile-tested for arm and arm64. Could someone with
the hardware please confirm that it still works?

Cheers,
Andre.

 drivers/spi/spi-s3c64xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9231c34..b1c6731 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -324,7 +324,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 
 		/* Acquire DMA channels */
 		sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   (void *)sdd->rx_dma.dmach, dev, "rx");
+				   (void *)(long)sdd->rx_dma.dmach, dev, "rx");
 		if (!sdd->rx_dma.ch) {
 			dev_err(dev, "Failed to get RX DMA channel\n");
 			ret = -EBUSY;
@@ -333,7 +333,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 		spi->dma_rx = sdd->rx_dma.ch;
 
 		sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
-				   (void *)sdd->tx_dma.dmach, dev, "tx");
+				   (void *)(long)sdd->tx_dma.dmach, dev, "tx");
 		if (!sdd->tx_dma.ch) {
 			dev_err(dev, "Failed to get TX DMA channel\n");
 			ret = -EBUSY;
-- 
1.7.9.5
