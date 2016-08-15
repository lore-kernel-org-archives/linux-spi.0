From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: fix build with musl libc" to the spi tree
Date: Mon, 15 Aug 2016 15:11:45 +0100
Message-ID: <E1bZIcD-0006wp-MT@debutante>
References: <9c96a08dcf783de3008800ea497775fcaa52147b.1471007073.git.baruch@tkos.co.il>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9c96a08dcf783de3008800ea497775fcaa52147b.1471007073.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: fix build with musl libc

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8736f8022e532a3c1d8873aac78e1113c6ffc3b9 Mon Sep 17 00:00:00 2001
From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Date: Fri, 12 Aug 2016 16:04:33 +0300
Subject: [PATCH] spi: spidev_test: fix build with musl libc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

spidev.h uses _IOC_SIZEBITS directly. musl libc does not provide this macro
unless linux/ioctl.h is included explicitly. Fixes build failures like:

In file included from .../host/usr/arm-buildroot-linux-musleabihf/sysroot/usr/include/sys/ioctl.h:7:0,
                 from .../build/spidev_test-v3.15/spidev_test.c:20:
.../build/spidev_test-v3.15/spidev_test.c: In function ‘transfer’:
.../build/spidev_test-v3.15/spidev_test.c:75:18: error: ‘_IOC_SIZEBITS’ undeclared (first use in this function)
  ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
                  ^

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
