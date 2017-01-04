From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
Date: Wed, 4 Jan 2017 17:38:17 +0800
Message-ID: <1483522697-6691-2-git-send-email-pandy.gao@nxp.com>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483522697-6691-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When system enters VLLS mode, module power is turned off. As a result,
all registers are reset to HW default value. After exiting VLLS mode,
registers are still in default mode. As a result, the pinctrl settings
are incorrect, which will affect the module function.

The patch recovers the pinctrl setting when exit VLLS mode.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 8ec8f55..8557728 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -510,10 +510,32 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_lpspi_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int fsl_lpspi_resume(struct device *dev)
+{
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_lpspi_pm, fsl_lpspi_suspend, fsl_lpspi_resume);
+#define IMX_LPSPI_PM    (&imx_lpspi_pm)
+#else
+#define IMX_LPSPI_PM    NULL
+#endif
+
 static struct platform_driver fsl_lpspi_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = fsl_lpspi_dt_ids,
+		.pm = IMX_LPSPI_PM,
 	},
 	.probe = fsl_lpspi_probe,
 	.remove = fsl_lpspi_remove,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
