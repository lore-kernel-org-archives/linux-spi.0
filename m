From: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] spi: Remove unused definitions
Date: Wed,  6 Aug 2014 13:53:17 -0400
Message-ID: <1407347597-2168-1-git-send-email-xerofoiffy@gmail.com>
To: Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove unused definition which cause the following warnings

drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
include/linux/fs.h:193:0: note: this is the location of the previous definition
drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
include/linux/fs.h:192:0: note: this is the location of the previous definition

Signed-off-by: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 5e91858..fb52276 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -70,10 +70,6 @@
 #define SPI_STATUS_WE                   (1UL << 1)
 #define SPI_STATUS_RD                   (1UL << 0)
 
-#define WRITE 0
-#define READ  1
-
-
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
