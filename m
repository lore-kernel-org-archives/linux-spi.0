From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: st-ssc4: Allow compile test build
Date: Fri, 29 Apr 2016 13:38:41 +0800
Message-ID: <1461908321.20684.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no build dependency for this driver, so enable COMPILE_TEST to get
better build coverage.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2a357f6..8b39be4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -581,7 +581,7 @@ config SPI_SIRF
 
 config SPI_ST_SSC4
 	tristate "STMicroelectronics SPI SSC-based driver"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	help
 	  STMicroelectronics SoCs support for SPI. If you say yes to
 	  this option, support will be included for the SSC driven SPI.
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
