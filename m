From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 5/5] spi: rspi: Document support for Renesas QSPI in Kconfig
Date: Tue, 21 Jan 2014 16:10:09 +0100
Message-ID: <1390317009-8292-5-git-send-email-geert@linux-m68k.org>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390317009-8292-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

As of commit 5ce0ba88650f2606244a761d92e2b725f4ab3583 ("spi: rcar: add
Renesas QSPI support on RSPI") the rspi driver handles Renesas QSPI, too,
but this was not reflected in the Kconfig help text.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 5072b71baf5e..3aafc2cd5db0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -376,10 +376,10 @@ config SPI_PXA2XX_PCI
 	def_tristate SPI_PXA2XX && PCI
 
 config SPI_RSPI
-	tristate "Renesas RSPI controller"
+	tristate "Renesas RSPI/QSPI controller"
 	depends on (SUPERH && SH_DMAE_BASE) || ARCH_SHMOBILE
 	help
-	  SPI driver for Renesas RSPI blocks.
+	  SPI driver for Renesas RSPI and QSPI blocks.
 
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
