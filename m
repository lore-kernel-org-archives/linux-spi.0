From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "regulator: da9210: Add optional interrupt support" to the spi tree
Date: Tue, 07 Jul 2015 14:58:45 +0100
Message-ID: <E1ZCTOX-0005m5-Lk@finisterre>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   regulator: da9210: Add optional interrupt support

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

>From 760d5ff86497c1109e074341c6099a6430551dd6 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date: Wed, 24 Jun 2015 14:14:21 +0200
Subject: [PATCH] regulator: da9210: Add optional interrupt support

Add optional interrupt support to the da9210 regulator driver, to handle
over-current, under- and over-voltage, and over-temperature events.

Only the interrupt sources for which we handle events are unmasked, to
avoid interrupts we cannot handle.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/regulator/da9210.txt       |  4 ++
 drivers/regulator/da9210-regulator.c               | 75 ++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/da9210.txt b/Documentation/devicetree/bindings/regulator/da9210.txt
index 3297c53..7aa9b1f 100644
--- a/Documentation/devicetree/bindings/regulator/da9210.txt
+++ b/Documentation/devicetree/bindings/regulator/da9210.txt
@@ -5,6 +5,10 @@ Required properties:
 - compatible:	must be "dlg,da9210"
 - reg:		the i2c slave address of the regulator. It should be 0x68.
 
+Optional properties:
+
+- interrupts:	a reference to the DA9210 interrupt, if available.
+
 Any standard regulator properties can be used to configure the single da9210
 DCDC.
 
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index f0489cb..8e39f74 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -22,6 +22,8 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -120,6 +122,55 @@ static int da9210_get_current_limit(struct regulator_dev *rdev)
 	return da9210_buck_limits[sel];
 }
 
+static irqreturn_t da9210_irq_handler(int irq, void *data)
+{
+	struct da9210 *chip = data;
+	unsigned int val, handled = 0;
+	int error, ret = IRQ_NONE;
+
+	error = regmap_read(chip->regmap, DA9210_REG_EVENT_B, &val);
+	if (error < 0)
+		goto error_i2c;
+
+	if (val & DA9210_E_OVCURR) {
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_OVER_CURRENT,
+					      NULL);
+		handled |= DA9210_E_OVCURR;
+	}
+	if (val & DA9210_E_NPWRGOOD) {
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_UNDER_VOLTAGE,
+					      NULL);
+		handled |= DA9210_E_NPWRGOOD;
+	}
+	if (val & (DA9210_E_TEMP_WARN | DA9210_E_TEMP_CRIT)) {
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_OVER_TEMP, NULL);
+		handled |= val & (DA9210_E_TEMP_WARN | DA9210_E_TEMP_CRIT);
+	}
+	if (val & DA9210_E_VMAX) {
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_REGULATION_OUT,
+					      NULL);
+		handled |= DA9210_E_VMAX;
+	}
+	if (handled) {
+		/* Clear handled events */
+		error = regmap_write(chip->regmap, DA9210_REG_EVENT_B, handled);
+		if (error < 0)
+			goto error_i2c;
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+
+error_i2c:
+	dev_err(regmap_get_device(chip->regmap), "I2C error : %d\n", error);
+	return ret;
+}
+
 /*
  * I2C driver interface functions
  */
@@ -168,6 +219,30 @@ static int da9210_i2c_probe(struct i2c_client *i2c,
 	}
 
 	chip->rdev = rdev;
+	if (i2c->irq) {
+		error = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+						  da9210_irq_handler,
+						  IRQF_TRIGGER_LOW |
+						  IRQF_ONESHOT | IRQF_SHARED,
+						  "da9210", chip);
+		if (error) {
+			dev_err(&i2c->dev, "Failed to request IRQ%u: %d\n",
+				i2c->irq, error);
+			return error;
+		}
+
+		error = regmap_update_bits(chip->regmap, DA9210_REG_MASK_B,
+					 DA9210_M_OVCURR | DA9210_M_NPWRGOOD |
+					 DA9210_M_TEMP_WARN |
+					 DA9210_M_TEMP_CRIT | DA9210_M_VMAX, 0);
+		if (error < 0) {
+			dev_err(&i2c->dev, "Failed to update mask reg: %d\n",
+				error);
+			return error;
+		}
+	} else {
+		dev_warn(&i2c->dev, "No IRQ configured\n");
+	}
 
 	i2c_set_clientdata(i2c, chip);
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
