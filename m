From: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Subject: [PATCH 1/1 v2] spi: fsl-dspi: Use pinctrl PM helpers
Date: Fri, 12 Jun 2015 18:55:22 +0200
Message-ID: <1434128122-773-1-git-send-email-mirza.krak@hostmobility.com>
Cc: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>

Add support for "sleep" state of pinctrl.

Signed-off-by: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
---

Changes V2:
- Added missing header

 drivers/spi/spi-fsl-dspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d1a39249704a..d6f362f37016 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -429,6 +430,8 @@ static int dspi_suspend(struct device *dev)
 	spi_master_suspend(master);
 	clk_disable_unprepare(dspi->clk);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -437,6 +440,8 @@ static int dspi_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct fsl_dspi *dspi = spi_master_get_devdata(master);
 
+	pinctrl_pm_select_default_state(dev);
+
 	clk_prepare_enable(dspi->clk);
 	spi_master_resume(master);
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
