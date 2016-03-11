From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: rockchip: header file cleanup" to the spi tree
Date: Fri, 11 Mar 2016 14:25:30 +0700
Message-ID: <E1aeHRy-00032b-K2@finisterre>
References: <1457592708-27320-1-git-send-email-shawn.lin@rock-chips.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457592708-27320-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: rockchip: header file cleanup

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

>From ec5c5d8ac028cfec4c7c976d93bed1734f1a670a Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Thu, 10 Mar 2016 14:51:48 +0800
Subject: [PATCH] spi: rockchip: header file cleanup

Remove some of unused header files and reoder
it into alphabetical order.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 795fd191faa7..1b54f2f18021 100644
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
