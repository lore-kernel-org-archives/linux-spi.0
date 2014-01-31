From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 5/5] spi: dw-mmio: remove HAVE_CLK build dependecy
Date: Fri, 31 Jan 2014 12:07:48 +0200
Message-ID: <207f4522cbabac73422b54006ead761f25380013.1391162172.git.baruch@tkos.co.il>
References: <cover.1391162172.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1391162172.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
like this platform driver needs not depend on HAVE_CLK.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5072b71baf5e..bdfb74dbcf76 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -543,7 +543,7 @@ config SPI_DW_MID_DMA
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE && HAVE_CLK
+	depends on SPI_DESIGNWARE
 
 #
 # There are lots of SPI device types, with sensors and memory
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
