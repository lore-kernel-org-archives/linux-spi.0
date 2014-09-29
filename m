From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi: fsl: Sort include headers alphabetically
Date: Mon, 29 Sep 2014 10:57:06 +0800
Message-ID: <1411959426-3060-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sort all the include headers alphabetically for the freescale
spi drivers. If the inlcude headers sorted out of order, maybe
the best logical choice is to append new ones after the exist
ones, while this may create a lot of potential for duplicates
and conflicts for each diffenent changes will add new headers
in the same location.

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-cpm.c  | 14 +++++++-------
 drivers/spi/spi-fsl-dspi.c | 18 +++++++++---------
 drivers/spi/spi-fsl-espi.c | 12 ++++++------
 drivers/spi/spi-fsl-lib.c  |  6 +++---
 drivers/spi/spi-fsl-spi.c  | 22 +++++++++++-----------
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 54b0637..c5dd20b 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -15,17 +15,17 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/fsl_devices.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_address.h>
 #include <asm/cpm.h>
 #include <asm/qe.h>
+#include <linux/dma-mapping.h>
+#include <linux/fsl_devices.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
 
-#include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
+#include "spi-fsl-lib.h"
 #include "spi-fsl-spi.h"
 
 /* CPM1 and CPM2 are mutually exclusive. */
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 1cdef8e..4482160 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -13,22 +13,22 @@
  *
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/pm_runtime.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 
 #define DRIVER_NAME "fsl-dspi"
 
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 429e111..a7f94b6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -8,19 +8,19 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/spi/spi.h>
-#include <linux/platform_device.h>
+#include <linux/err.h>
 #include <linux/fsl_devices.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/interrupt.h>
-#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <sysdev/fsl_soc.h>
 
 #include "spi-fsl-lib.h"
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e0b773f..5ddb5b0 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -16,10 +16,10 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/fsl_devices.h>
 #include <linux/dma-mapping.h>
+#include <linux/fsl_devices.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/of_platform.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 590f31b..ed79288 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -19,25 +19,25 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
-#include <linux/platform_device.h>
-#include <linux/fsl_devices.h>
 #include <linux/dma-mapping.h>
+#include <linux/fsl_devices.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/types.h>
 
 #include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
