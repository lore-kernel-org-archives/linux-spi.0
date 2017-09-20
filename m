From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Kconfig: Remove old comments now that SPI slave is supported
Date: Wed, 20 Sep 2017 01:17:17 -0300
Message-ID: <1505881037-16661-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

Since commit 6c364062bfed ("spi: core: Add support for registering SPI
slave controllers") SPI slave is also supported, so remove the old
comments that say SPI slave is unsupported.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2..948a74b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1,10 +1,6 @@
 #
 # SPI driver configuration
 #
-# NOTE:  the reason this doesn't show SPI slave support is mostly that
-# nobody's needed a slave side API yet.  The master-role API is not
-# fully appropriate there, so it'd need some thought to do well.
-#
 menuconfig SPI
 	bool "SPI support"
 	depends on HAS_IOMEM
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
