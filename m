From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/2] spi: rockchip: header file cleanup
Date: Thu, 10 Mar 2016 14:51:48 +0800
Message-ID: <1457592708-27320-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove some of unused header files and reoder
it into alphabetical order.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/spi/spi-rockchip.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7bdbeef..7a4a131 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -13,20 +13,14 @@
  *
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/scatterlist.h>
-#include <linux/of.h>
 #include <linux/pm_runtime.h>
-#include <linux/io.h>
-#include <linux/dmaengine.h>
+#include <linux/scatterlist.h>
 
 #define DRIVER_NAME "rockchip-spi"
 
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
