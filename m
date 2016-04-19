From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: disallow building on MMP
Date: Tue, 19 Apr 2016 15:18:20 +0200
Message-ID: <1461071933-3273163-1-git-send-email-arnd@arndb.de>
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

After MMP has become part of a multiplatform build, we can end up with
a randconfig build failure in the pxa2xx spi driver:

drivers/spi/built-in.o: In function `pxa2xx_spi_remove':
:(.text+0x1845c): undefined reference to `pxa_ssp_free'
drivers/spi/built-in.o: In function `pxa2xx_spi_probe':
:(.text+0x19844): undefined reference to `pxa_ssp_request'

What happens here is that we can enable SPI_PXA2XX when some other
platform in the same build supports PCI. This normally works because the
pxa_ssp_request/pxa_ssp_free functions are stubbed out when CONFIG_PXA_SSP
is disabled. However, we can have PXA_SSP=m when that driver is used by
the SND_SOC_TTC_DKB audio driver.

This changes the Kconfig logic to just disallow the pxa2xx SPI
driver on anything but x86 and pxa.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e33be3775a3c..ad8d8714d5b0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -469,7 +469,7 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on (ARCH_PXA || PCI || ACPI)
+	depends on ARCH_PXA || (X86 && (PCI || ACPI))
 	select PXA_SSP if ARCH_PXA
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
