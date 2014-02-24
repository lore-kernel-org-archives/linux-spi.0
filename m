From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: qup: Depend on ARM && COMPILE_TEST to avoid build error
Date: Mon, 24 Feb 2014 12:07:51 +0800
Message-ID: <1393214871.1099.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver uses writel_relaxed() which does not exist in x86, ppc, etc.
Make it depend on ARM && COMPILE_TEST to avoid below build error:

  CC [M]  drivers/spi/spi-qup.o
drivers/spi/spi-qup.c: In function 'spi_qup_set_state':
drivers/spi/spi-qup.c:180:3: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [drivers/spi/spi-qup.o] Error 1
make[1]: *** [drivers/spi] Error 2
make: *** [drivers] Error 2

Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e4e170f..db22cda 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -384,7 +384,7 @@ config SPI_RSPI
 
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
-	depends on ARCH_MSM_DT || COMPILE_TEST
+	depends on ARCH_MSM_DT || (ARM && COMPILE_TEST)
 	help
 	  Qualcomm Universal Peripheral (QUP) core is an AHB slave that
 	  provides a common data path (an output FIFO and an input FIFO)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
