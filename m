From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: bcm53xx: Fix module dependency
Date: Fri, 26 Sep 2014 14:18:31 +0800
Message-ID: <1411712311.23531.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: =?gb2312?Q?Rafa=810=920_Mi=810=920ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

config SPI_BCM53XX needs to depend on BCMA_POSSIBLE and select BCMA.
This fixes below build error:
ERROR: "bcma_driver_unregister" [drivers/spi/spi-bcm53xx.ko] undefined!
ERROR: "__bcma_driver_register" [drivers/spi/spi-bcm53xx.ko] undefined!

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index dc10453..84e7c9e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -116,6 +116,8 @@ config SPI_AU1550
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
 	depends on ARCH_BCM_5301X
+	depends on BCMA_POSSIBLE
+	select BCMA
 	help
           Enable support for the SPI controller on Broadcom BCM53xx ARM SoCs.
 
-- 
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
