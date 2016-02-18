From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] spi: sh-spi, sh-msiof, rspi: Use ARCH_RENESAS
Date: Thu, 18 Feb 2016 10:47:52 +0900
Message-ID: <1455760072-27456-1-git-send-email-horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/spi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 533fe2da0027..6cd36a16c366 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -477,7 +477,7 @@ config SPI_RB4XX
 
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
@@ -527,7 +527,7 @@ config SPI_SC18IS602
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
 	depends on HAVE_CLK && HAS_DMA
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
@@ -546,7 +546,7 @@ config SPI_SH_SCI
 
 config SPI_SH_HSPI
 	tristate "SuperH HSPI controller"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for SuperH HSPI blocks.
 
-- 
2.1.4
