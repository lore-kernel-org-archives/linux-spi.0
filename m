From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: clps711x: Add MODULE_ALIAS to support module
 auto-loading
Date: Tue, 14 Jan 2014 17:01:54 +0800
Message-ID: <1389690114.22958.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index dafb243..374ba4a 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -257,3 +257,4 @@ module_platform_driver(clps711x_spi_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>");
 MODULE_DESCRIPTION("CLPS711X SPI bus driver");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
