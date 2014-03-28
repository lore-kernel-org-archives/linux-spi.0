From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Remove unneeded include of linux/workqueue.h
Date: Fri, 28 Mar 2014 11:05:55 +0800
Message-ID: <1395975955.445.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
I have compile tested all these drivers with this patch.
Axel
 drivers/spi/spi-ath79.c         | 1 -
 drivers/spi/spi-bcm63xx-hsspi.c | 1 -
 drivers/spi/spi-bcm63xx.c       | 1 -
 drivers/spi/spi-falcon.c        | 1 -
 drivers/spi/spi-nuc900.c        | 1 -
 drivers/spi/spi-omap-uwire.c    | 1 -
 drivers/spi/spi-pxa2xx.c        | 1 -
 drivers/spi/spi-s3c24xx.c       | 1 -
 drivers/spi/spi-s3c64xx.c       | 1 -
 drivers/spi/spi-sh-sci.c        | 1 -
 drivers/spi/spi-sun4i.c         | 1 -
 drivers/spi/spi-sun6i.c         | 1 -
 12 files changed, 12 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 3898b0b..058db0f 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 5a211e9..86f5a98 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -18,7 +18,6 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
 
 #define HSSPI_GLOBAL_CTRL_REG			0x0
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 0250fa7..8510400 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -29,7 +29,6 @@
 #include <linux/spi/spi.h>
 #include <linux/completion.h>
 #include <linux/err.h>
-#include <linux/workqueue.h>
 #include <linux/pm_runtime.h>
 
 #include <bcm63xx_dev_spi.h>
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 09965f0..ba441ad 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
-#include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index a062a89..7b09dce 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 95cc694..7dccee1 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 41185d0..d0fc8e0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -27,7 +27,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
-#include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index bed2338..1f3ef97 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -10,7 +10,6 @@
 */
 
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f19cd97..153b4be 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -19,7 +19,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 8b44b71..1f56ef6 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index d266a87..85204c9 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/workqueue.h>
 
 #include <linux/spi/spi.h>
 
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index b3e3498..bd24093 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -20,7 +20,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-#include <linux/workqueue.h>
 
 #include <linux/spi/spi.h>
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
