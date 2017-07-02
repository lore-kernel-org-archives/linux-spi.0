From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v7 04/16] watchdog: lantiq: access boot cause register through regmap
Date: Mon,  3 Jul 2017 00:40:39 +0200
Message-ID: <20170702224051.15109-5-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170702224051.15109-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch avoids accessing the function ltq_reset_cause() and directly
accesses the register given over the syscon interface. The syscon
interface will be implemented for the xway SoCs for the falcon SoCs the
ltq_reset_cause() function never worked, because a wrong offset was used.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Acked-by: Guenter Roeck <linux-cYGBoTPqujPR7s880joybQ@public.gmane.org>
---
 drivers/watchdog/lantiq_wdt.c | 75 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..af01dabdb43c 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -4,6 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
  *  Based on EP93xx wdt driver
  */
 
@@ -17,9 +18,20 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
+#define LTQ_XRX_RCU_RST_STAT		0x0014
+#define LTQ_XRX_RCU_RST_STAT_WDT	BIT(31)
+
+/* CPU0 Reset Source Register */
+#define LTQ_FALCON_SYS1_CPU0RS		0x0060
+/* reset cause mask */
+#define LTQ_FALCON_SYS1_CPU0RS_MASK	0x0007
+#define LTQ_FALCON_SYS1_CPU0RS_WDT	0x02
+
 /*
  * Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
@@ -186,16 +198,70 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+typedef int (*ltq_wdt_bootstatus_set)(struct platform_device *pdev);
+
+static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR(rcu_regmap))
+		return PTR_ERR(rcu_regmap);
+
+	err = regmap_read(rcu_regmap, LTQ_XRX_RCU_RST_STAT, &val);
+	if (err)
+		return err;
+
+	if (val & LTQ_XRX_RCU_RST_STAT_WDT)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+
+	return 0;
+}
+
+static int ltq_wdt_bootstatus_falcon(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "lantiq,rcu");
+	if (IS_ERR(rcu_regmap))
+		return PTR_ERR(rcu_regmap);
+
+	err = regmap_read(rcu_regmap, LTQ_FALCON_SYS1_CPU0RS, &val);
+	if (err)
+		return err;
+
+	if ((val & LTQ_FALCON_SYS1_CPU0RS_MASK) == LTQ_FALCON_SYS1_CPU0RS_WDT)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+
+	return 0;
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct clk *clk;
+	ltq_wdt_bootstatus_set ltq_wdt_bootstatus_set;
+	int ret;
 
 	ltq_wdt_membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ltq_wdt_membase))
 		return PTR_ERR(ltq_wdt_membase);
 
+	ltq_wdt_bootstatus_set = of_device_get_match_data(&pdev->dev);
+	if (ltq_wdt_bootstatus_set) {
+		ret = ltq_wdt_bootstatus_set(pdev);
+		if (ret)
+			return ret;
+	}
+
 	/* we do not need to enable the clock as it is always running */
 	clk = clk_get_io();
 	if (IS_ERR(clk)) {
@@ -205,10 +271,6 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
-
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
 }
@@ -222,7 +284,10 @@ ltq_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_wdt_match[] = {
-	{ .compatible = "lantiq,wdt" },
+	{ .compatible = "lantiq,wdt", .data = NULL},
+	{ .compatible = "lantiq,xrx100-wdt", .data = ltq_wdt_bootstatus_xrx },
+	{ .compatible = "lantiq,xrx200-wdt", .data = ltq_wdt_bootstatus_xrx },
+	{ .compatible = "lantiq,falcon-wdt", .data = ltq_wdt_bootstatus_falcon },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
