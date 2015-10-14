From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 10/10] spi: dw-mmio: convert to unified device property API
Date: Wed, 14 Oct 2015 23:12:25 +0300
Message-ID: <1444853545-59868-11-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert the driver to use unfied device property API instead of OF one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 7edede6..a6d7029 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
+#include <linux/property.h>
 
 #include "spi-dw.h"
 
@@ -74,13 +75,11 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
-	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
-			     &dws->reg_io_width);
+	device_property_read_u32(&pdev->dev, "reg-io-width", &dws->reg_io_width);
 
 	num_cs = 4;
 
-	if (pdev->dev.of_node)
-		of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
+	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
 
 	dws->num_cs = num_cs;
 
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
