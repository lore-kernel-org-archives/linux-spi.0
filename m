From: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Fix warning about redefinition
Date: Wed,  6 Aug 2014 12:55:28 -0400
Message-ID: <1407344128-9754-1-git-send-email-xerofoiffy@gmail.com>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following warnings about redefining READ and write

drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
include/linux/fs.h:193:0: note: this is the location of the previous definition
drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
include/linux/fs.h:192:0: note: this is the location of the previous definition

Signed-off-by: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 5e91858..eb8ae4e 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -70,6 +70,12 @@
 #define SPI_STATUS_WE                   (1UL << 1)
 #define SPI_STATUS_RD                   (1UL << 0)
 
+#ifdef WRITE
+#undef WRITE
+#endif
+#ifdef READ
+#undef READ
+#endif
 #define WRITE 0
 #define READ  1
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
