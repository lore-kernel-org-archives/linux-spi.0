From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] spi-topcliff-pch: Fix Kconfig dependencies
Date: Fri, 16 May 2014 16:47:18 +0200
Message-ID: <20140516164718.5ea30de0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi-topcliff-pch driver is for a companion chip to the Intel Atom
E600 series processors. These are 32-bit x86 processors so the driver
is only needed on X86_32. Add COMPILE_TEST as an alternative, so that
the driver can still be build-tested elsewhere.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc5.orig/drivers/spi/Kconfig	2014-04-14 09:42:30.897098903 +0200
+++ linux-3.15-rc5/drivers/spi/Kconfig	2014-05-16 16:38:44.332233218 +0200
@@ -505,7 +505,7 @@ config SPI_TEGRA20_SLINK
 
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  SPI driver for the Topcliff PCH (Platform Controller Hub) SPI bus
 	  used in some x86 embedded processors.


-- 
Jean Delvare
SUSE L3 Support
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
