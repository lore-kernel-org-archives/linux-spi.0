From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: core: Fix devm_spi_register_master() function name in kerneldoc
Date: Thu,  4 May 2017 14:58:28 +0200
Message-ID: <1493902708-19181-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixes: 666d5b4c742ba666 ("spi: core: Add devm_spi_register_master()")
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 89254a55eb2e78c4..7bb733d91519bc24 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2021,7 +2021,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
 }
 
 /**
- * dev_spi_register_master - register managed SPI master controller
+ * devm_spi_register_master - register managed SPI master controller
  * @dev:    device managing SPI master
  * @master: initialized master, originally from spi_alloc_master()
  * Context: can sleep
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
