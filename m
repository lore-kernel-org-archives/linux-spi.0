From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw-mmio: convert to unified device property API" to the spi tree
Date: Mon, 19 Oct 2015 20:43:25 +0100
Message-ID: <E1ZoGL7-0002JO-6F@debutante>
References: <1444853545-59868-11-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-11-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw-mmio: convert to unified device property API

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

>From 9899995e98a4bc670a07e28ff91e3d0dbe08bea9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:25 +0300
Subject: [PATCH] spi: dw-mmio: convert to unified device property API

Convert the driver to use unfied device property API instead of OF one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 7edede6e024b..a6d7029a85ac 100644
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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
