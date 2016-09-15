From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: bcm-qspi: don't include linux/mtd/cfi.h
Date: Thu, 15 Sep 2016 17:40:15 +0200
Message-ID: <20160915154033.3002634-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The header isn't actually needed here, but including it leads
to a build warning when CONFIG_MTD is disabled:

include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 8bbe8605e373..64e693de1486 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -25,7 +25,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mtd/cfi.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
