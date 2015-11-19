From: pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Thu, 19 Nov 2015 16:18:28 +0100
Message-ID: <1447946308-2003-1-git-send-email-pascal.huerst@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This adds calls to pinctrl subsystem in order to switch pin states
on suspend/resume if you provide a "sleep" state in DT.

If no "sleep" state is provided in DT, these calls turn
to NOPs.

Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3d09e0b..2c099c5 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/omap-dma.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -1508,14 +1509,23 @@ static int omap2_mcspi_resume(struct device *dev)
 	}
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
-	return 0;
+
+	return pinctrl_pm_select_default_state(dev);
+}
+
+static int omap2_mcspi_suspend(struct device *dev)
+{
+	return pinctrl_pm_select_sleep_state(dev);
 }
+
 #else
+#define omap2_mcspi_suspend	NULL
 #define	omap2_mcspi_resume	NULL
 #endif

 static const struct dev_pm_ops omap2_mcspi_pm_ops = {
 	.resume = omap2_mcspi_resume,
+	.suspend = omap2_mcspi_suspend,
 	.runtime_resume	= omap_mcspi_runtime_resume,
 };

--
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
