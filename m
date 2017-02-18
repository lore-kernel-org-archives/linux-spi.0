From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH] spi: lantiq-ssc: activate under COMPILE_TEST
Date: Sat, 18 Feb 2017 17:06:48 +0100
Message-ID: <20170218160648.16251-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org, martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver should compile on all platforms, activate it under compile
test. The Lantiq specific parts are under ifdef and should be removed
when Lantiq platform supports common clock framework.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 59db5ac02d41..e00815cb5f5b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -418,7 +418,7 @@ config SPI_NUC900
 
 config SPI_LANTIQ_SSC
 	tristate "Lantiq SSC SPI controller"
-	depends on LANTIQ
+	depends on LANTIQ || COMPILE_TEST
 	help
 	  This driver supports the Lantiq SSC SPI controller in master
 	  mode. This controller is found on Intel (former Lantiq) SoCs like
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
