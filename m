From: pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH] spi: omap2-mcspi: Add calls for pinctrl state select
Date: Wed, 13 May 2015 14:15:16 +0200
Message-ID: <1431519316-30989-1-git-send-email-pascal.huerst@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This adds calls to pinctrl subsystem in order to switch pin states
on suspend/resume if you provide a "sleep" state in DT.

If no "sleep" state is provided in DT, these calls turn
to NOPs, so we don't need error checking here.

Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 4df8942..424f8cd 100644
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
@@ -1502,14 +1503,27 @@ static int omap2_mcspi_resume(struct device *dev)
 	}
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+
+static int omap2_mcspi_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
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
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
