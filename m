From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: uapi: spidev: add missing ioctl header" to the spi tree
Date: Wed, 13 Sep 2017 17:49:39 +0100 (BST)
Message-ID: <20170913164939.209A1440013@finisterre.ee.mobilebroadband>
References: <98661f29960910754e7a21c1cbebae7aff4d4dbe.1505064585.git.baruch@tkos.co.il>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <98661f29960910754e7a21c1cbebae7aff4d4dbe.1505064585.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: uapi: spidev: add missing ioctl header

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

>From a2b4a79b88b24c49d98d45a06a014ffd22ada1a4 Mon Sep 17 00:00:00 2001
From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Date: Sun, 10 Sep 2017 20:29:45 +0300
Subject: [PATCH] spi: uapi: spidev: add missing ioctl header

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
