From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] spi: omap2: use SUPERH, not SH
Date: Sat, 08 Feb 2014 22:01:21 +0100
Message-ID: <1391893281.19595.3.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Commit 0079aae0f1e6 ("spi: omap2: Add build dependencies for
writel_relaxed()") added an optional Kconfig dependency on SH. That
Kconfig symbol doesn't exist. Apparently SUPERH was intended. Use that.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Basically untested.

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ba9310b..205dbfe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -307,7 +307,7 @@ config SPI_OMAP_UWIRE
 
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SH
+	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
-- 
1.8.5.3
