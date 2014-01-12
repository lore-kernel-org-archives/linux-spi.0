From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] spi: rspi: Remove dependency on DMAE for SHMOBILE
Date: Sun, 12 Jan 2014 11:32:44 +0100
Message-ID: <1389522765-1829-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On ARM-based SHMOBILE, the rspi driver builds and works fine without the
DMA controller driver, hence relax the dependencies.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index eb1f1ef5fa2e..4f6fbfd71135 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -370,7 +370,7 @@ config SPI_PXA2XX_PCI
 
 config SPI_RSPI
 	tristate "Renesas RSPI controller"
-	depends on (SUPERH || ARCH_SHMOBILE) && SH_DMAE_BASE
+	depends on (SUPERH && SH_DMAE_BASE) || ARCH_SHMOBILE
 	help
 	  SPI driver for Renesas RSPI blocks.
 
-- 
1.7.9.5

