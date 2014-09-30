From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: bcm53xx: add BCMA dependency
Date: Tue, 30 Sep 2014 14:09:46 +0200
Message-ID: <3256402.M8e92DFkbg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The BCMA bus framework can be disabled on bcm53xx, which leads to a link
error when building the SPI driver:

drivers/built-in.o: In function `bcm53xxspi_module_init':
:(.init.text+0x76d4): undefined reference to `__bcma_driver_register'
drivers/built-in.o: In function `bcm53xxspi_module_exit':
:(.exit.text+0x10fe): undefined reference to `bcma_driver_unregister'

To avoid that, this adds an explicit dependency on BCMA. While we're
changing the dependencies, let's also add a COMPILE_TEST option, which
will of course not have any effect unless building on another machine
that has BCMA enabled.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: 0fc6a323e19 ("spi: bcm53xx: driver for SPI controller on Broadcom bcma SoC")

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bb7b5ec000d9..ababd27a4211 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -115,7 +115,8 @@ config SPI_AU1550
 
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
-	depends on ARCH_BCM_5301X
+	depends on ARCH_BCM_5301X || COMPILE_TEST
+	depends on BCMA
 	help
           Enable support for the SPI controller on Broadcom BCM53xx ARM SoCs.
 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
