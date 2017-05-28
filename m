From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: [PATCH v3 10/16] reset: Add a reset controller driver for the Lantiq XWAY based SoCs
Date: Sun, 28 May 2017 20:40:00 +0200
Message-ID: <20170528184006.31668-11-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170528184006.31668-1-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

The reset controllers (on xRX200 and newer SoCs have two of them) are
provided by the RCU module. This was initially implemented as a simple
reset controller. However, the RCU module provides more functionality
(ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
The old reset controller driver implementation from
arch/mips/lantiq/xway/reset.c did not honor this fact.

For some devices the request and the status bits are different.

Signed-off-by: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 .../devicetree/bindings/reset/lantiq,reset.txt     |  30 +++
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lantiq.c                       | 205 +++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
 create mode 100644 drivers/reset/reset-lantiq.c

diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.txt b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
new file mode 100644
index 000000000000..00cc3d4c68c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
@@ -0,0 +1,30 @@
+Lantiq XWAY SoC RCU reset controller binding
+============================================
+
+This binding describes a reset-controller found on the RCU module on Lantiq
+XWAY SoCs.
+
+
+-------------------------------------------------------------------------------
+Required properties:
+- compatible		: Should be one of
+				"lantiq,reset-danube"
+				"lantiq,reset-xrx200"
+- regmap		: A phandle to the RCU syscon
+- offset-set		: Offset of the reset set register
+- offset-status		: Offset of the reset status register
+- #reset-cells		: Specifies the number of cells needed to encode the
+			  reset line, should be 2.
+			  The first cell takes the reset set bit and the
+			  second cell takes the status bit.
+
+-------------------------------------------------------------------------------
+Example for the reset-controllers on the xRX200 SoCs:
+	reset0: reset-controller@0 {
+		compatible = "lantiq,reset-xrx200";
+
+		regmap = <&rcu0>;
+		offset-set = <0x10>;
+		offset-status = <0x14>;
+		#reset-cells = <2>;
+	};
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d21c07ccc94e..1742c2293bc3 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -41,6 +41,12 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_LANTIQ
+	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
+	default SOC_TYPE_XWAY
+	help
+	  This enables the reset controller driver for Lantiq / Intel XWAY SoCs.
+
 config RESET_LPC18XX
 	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
 	default ARCH_LPC18XX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 02a74db94339..112dba1db6b9 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
new file mode 100644
index 000000000000..798bf648f36d
--- /dev/null
+++ b/drivers/reset/reset-lantiq.c
@@ -0,0 +1,205 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 John Crispin <blogic-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
+ *  Copyright (C) 2013-2015 Lantiq Beteiligungs-GmbH & Co.KG
+ *  Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define LANTIQ_RCU_RESET_TIMEOUT	10000
+
+struct lantiq_rcu_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 reset_offset;
+	u32 status_offset;
+};
+
+static struct lantiq_rcu_reset_priv *to_lantiq_rcu_reset_priv(
+	struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct lantiq_rcu_reset_priv, rcdev);
+}
+
+static int lantiq_rcu_reset_status(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	unsigned int status = (id >> 8) & 0x1f;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, priv->status_offset, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(status));
+}
+
+static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
+				   unsigned long id, bool assert)
+{
+	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
+	int ret, retry = LANTIQ_RCU_RESET_TIMEOUT;
+	unsigned int set = id & 0x1f;
+	u32 val;
+
+	if (assert)
+		val = BIT(set);
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
+				 val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
+		return ret;
+	}
+
+	do {
+		ret = lantiq_rcu_reset_status(rcdev, id);
+		if (ret < 0)
+			return ret;
+		if (ret == assert)
+			break;
+		usleep_range(20, 40);
+	} while (--retry);
+	if (!retry) {
+		dev_err(priv->dev, "Failed to %s bit %u\n",
+			assert ? "assert" : "deassert", set);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int lantiq_rcu_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, true);
+}
+
+static int lantiq_rcu_reset_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return lantiq_rcu_reset_update(rcdev, id, false);
+}
+
+static int lantiq_rcu_reset_reset(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	int ret;
+
+	ret = lantiq_rcu_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return lantiq_rcu_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops lantiq_rcu_reset_ops = {
+	.assert = lantiq_rcu_reset_assert,
+	.deassert = lantiq_rcu_reset_deassert,
+	.status = lantiq_rcu_reset_status,
+	.reset	= lantiq_rcu_reset_reset,
+};
+
+static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
+			       struct lantiq_rcu_reset_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	ret = device_property_read_u32(dev, "offset-set", &priv->reset_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(dev, "offset-status",
+				       &priv->status_offset);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int lantiq_rcu_reset_xlate(struct reset_controller_dev *rcdev,
+				  const struct of_phandle_args *reset_spec)
+{
+	unsigned int status, set;
+
+	set = reset_spec->args[0];
+	status = reset_spec->args[1];
+
+	if (set >= rcdev->nr_resets || status >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return (status << 8) | set;
+}
+
+static int lantiq_rcu_reset_probe(struct platform_device *pdev)
+{
+	struct lantiq_rcu_reset_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	err = lantiq_rcu_reset_of_probe(pdev, priv);
+	if (err)
+		return err;
+
+	priv->rcdev.ops = &lantiq_rcu_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.nr_resets = 32;
+	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
+	priv->rcdev.of_reset_n_cells = 2;
+
+	return reset_controller_register(&priv->rcdev);
+}
+
+static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {
+	{ .compatible = "lantiq,reset-danube", },
+	{ .compatible = "lantiq,reset-xrx200", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lantiq_rcu_reset_dt_ids);
+
+static struct platform_driver lantiq_rcu_reset_driver = {
+	.probe	= lantiq_rcu_reset_probe,
+	.driver = {
+		.name		= "lantiq-reset",
+		.of_match_table	= lantiq_rcu_reset_dt_ids,
+	},
+};
+module_platform_driver(lantiq_rcu_reset_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>");
+MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
