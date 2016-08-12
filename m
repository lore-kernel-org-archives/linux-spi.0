From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] tools: spidev_test: fix build with musl libc
Date: Fri, 12 Aug 2016 16:04:33 +0300
Message-ID: <9c96a08dcf783de3008800ea497775fcaa52147b.1471007073.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spidev.h uses _IOC_SIZEBITS directly. musl libc does not provide this macro
unless linux/ioctl.h is included explicitly. Fixes build failures like:

In file included from .../host/usr/arm-buildroot-linux-musleabihf/sysroot/usr/include/sys/ioctl.h:7:0,
                 from .../build/spidev_test-v3.15/spidev_test.c:20:
.../build/spidev_test-v3.15/spidev_test.c: In function ‘transfer’:
.../build/spidev_test-v3.15/spidev_test.c:75:18: error: ‘_IOC_SIZEBITS’ undeclared (first use in this function)
  ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
                  ^

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 tools/spi/spidev_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8a73d8185316..1eaa4de6605b 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -19,6 +19,7 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <linux/ioctl.h>
 #include <sys/stat.h>
 #include <linux/types.h>
 #include <linux/spi/spidev.h>
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
