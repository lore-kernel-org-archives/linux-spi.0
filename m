From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] spi: qup: Enable driver compilation with COMPILE_TEST
Date: Sun, 23 Feb 2014 13:28:33 +0800
Message-ID: <1393133313.32087.1.camel@phoenix>
References: <1393133236.32087.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393133236.32087.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This helps increasing build testing coverage.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 65e420d..e4e170f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -384,7 +384,7 @@ config SPI_RSPI
 
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
-	depends on ARCH_MSM_DT
+	depends on ARCH_MSM_DT || COMPILE_TEST
 	help
 	  Qualcomm Universal Peripheral (QUP) core is an AHB slave that
 	  provides a common data path (an output FIFO and an input FIFO)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
