From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Sort headers" to the spi tree
Date: Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Message-ID: <20191018180709.DC1D52743273@ypsilon.sirena.org.uk>
References: <20191018105429.82782-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191018105429.82782-2-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: pxa2xx: Sort headers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 5ce2570513bc012020e1faaa20333a6955845f06 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:26 +0300
Subject: [PATCH] spi: pxa2xx: Sort headers

Sort the headers in alphabetic order in order to ease the maintenance
for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 59d1406a9c96..670734b3d56a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -4,27 +4,27 @@
  * Copyright (C) 2013, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
-#include <linux/init.h>
-#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/ioport.h>
-#include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/pm_runtime.h>
-#include <linux/acpi.h>
-#include <linux/of_device.h>
 
 #include "spi-pxa2xx.h"
 
-- 
2.20.1
