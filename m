From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v3 04/16] watchdog: lantiq: access boot cause register through regmap
Date: Sun, 28 May 2017 20:39:54 +0200
Message-ID: <20170528184006.31668-5-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170528184006.31668-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch avoids accessing the function ltq_reset_cause() and directly
accesses the register given over the syscon interface. The syscon
interface will be implemented for the xway SoCs for the falcon SoCs the
ltq_reset_cause() function never worked, because a wrong offset was used.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Acked-by: Guenter Roeck <linux-cYGBoTPqujPR7s880joybQ@public.gmane.org>
---
 drivers/watchdog/lantiq_wdt.c | 45 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..c9ad8100ec3c 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -4,6 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
  *  Based on EP93xx wdt driver
  */
 
@@ -17,6 +18,8 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
@@ -186,6 +189,40 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+static void ltq_set_wdt_bootstatus(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 status_reg_offset;
+	u32 status_reg_mask;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR_OR_NULL(rcu_regmap))
+		return;
+
+	err = device_property_read_u32(dev, "offset-status",
+				       &status_reg_offset);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = device_property_read_u32(dev, "mask-status", &status_reg_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = regmap_read(rcu_regmap, status_reg_offset, &val);
+	if (err)
+		return;
+
+	if (val & status_reg_mask)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
@@ -205,9 +242,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	ltq_set_wdt_bootstatus(pdev);
 
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
@@ -222,7 +257,9 @@ ltq_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_wdt_match[] = {
-	{ .compatible = "lantiq,wdt" },
+	{ .compatible = "lantiq,wdt"},
+	{ .compatible = "lantiq,wdt-xrx100"},
+	{ .compatible = "lantiq,wdt-falcon"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
