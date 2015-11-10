From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Add missing kerneldoc description for parameter
Date: Tue, 10 Nov 2015 13:03:04 +0100
Message-ID: <1447156984-22000-1-git-send-email-thierry.reding@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Commit ca5d24854210 ("spi: Add THIS_MODULE to spi_driver in SPI core")
adds the new __spi_register_driver() function, but keeps the kerneldoc
for the spi_register_driver() function in place and forgets to add the
description for the new owner parameter.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e2415be209d5..20ef4693d48f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -376,6 +376,7 @@ static void spi_drv_shutdown(struct device *dev)
 
 /**
  * __spi_register_driver - register a SPI driver
+ * @owner: owner module of the driver to register
  * @sdrv: the driver to register
  * Context: can sleep
  *
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
