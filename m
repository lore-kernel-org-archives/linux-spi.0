From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH] SPI: make falcon-spi bool
Date: Tue,  3 Jan 2017 18:04:27 +0100
Message-ID: <20170103170427.26120-1-hauke@hauke-m.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Falcon spi accesses some ebu functions which are not exported and can
not be accessed when build as module. Make this module bool instead.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1abba53c2334..c8356437c512 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -263,7 +263,7 @@ config SPI_EP93XX
 	  mode.
 
 config SPI_FALCON
-	tristate "Falcon SPI controller support"
+	bool "Falcon SPI controller support"
 	depends on SOC_FALCON
 	help
 	  The external bus unit (EBU) found on the FALC-ON SoC has SPI
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
