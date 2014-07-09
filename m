From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: rspi: Relax DMA dependency and increase build coverage
Date: Wed,  9 Jul 2014 23:27:07 +0200
Message-ID: <1404941228-9922-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

As of commit ab116a4df4942c78c189d9b0744dd940ab9e00b9 ("dmaengine:
shdma: fix a build failure on platforms with no DMA support"), the DMA
filter function shdma_chan_filter() is sufficiently abstracted to allow
building without DMA support. Hence drop the SH_DMAE_BASE dependency on
SUPERH.
Also increase build coverage by allowing the driver to be enabled if
COMPILE_TEST=y.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6be5e6e93e9..d46b4b9e73b2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -396,7 +396,7 @@ config SPI_ROCKCHIP
 
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
-	depends on (SUPERH && SH_DMAE_BASE) || ARCH_SHMOBILE
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
-- 
1.9.1
