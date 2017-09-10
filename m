From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] spi: uapi: spidev: add missing ioctl header
Date: Sun, 10 Sep 2017 20:29:45 +0300
Message-ID: <98661f29960910754e7a21c1cbebae7aff4d4dbe.1505064585.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The SPI_IOC_MESSAGE() macro references _IOC_SIZEBITS. Add linux/ioctl.h
to make sure this macro is defined. This fixes the following build
failure of lcdproc with the musl libc:

In file included from .../sysroot/usr/include/sys/ioctl.h:7:0,
                 from hd44780-spi.c:31:
hd44780-spi.c: In function 'spi_transfer':
hd44780-spi.c:89:24: error: '_IOC_SIZEBITS' undeclared (first use in this function)
  status = ioctl(p->fd, SPI_IOC_MESSAGE(1), &xfer);
                        ^

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 include/uapi/linux/spi/spidev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index dd5f21e75805..856de39d0b89 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -23,6 +23,7 @@
 #define SPIDEV_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
 
 /* User space versions of kernel symbols for SPI clocking modes,
  * matching <linux/spi/spi.h>
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
