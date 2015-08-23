From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] spi: fsl-espi: add runtime PM
Date: Sun, 23 Aug 2015 14:22:37 +0200
Message-ID: <55D9BB0D.7080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add runtime PM and use autosuspend instead of suspending the
SPI controller after each transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 65 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index fdd85be..5678cbd 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/pm_runtime.h>
 #include <sysdev/fsl_soc.h>
 
 #include "spi-fsl-lib.h"
@@ -85,6 +86,8 @@ struct fsl_espi_transfer {
 #define SPCOM_TRANLEN(x)	((x) << 0)
 #define	SPCOM_TRANLEN_MAX	0xFFFF	/* Max transaction length */
 
+#define AUTOSUSPEND_TIMEOUT 2000
+
 static void fsl_espi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
@@ -485,6 +488,8 @@ static int fsl_espi_setup(struct spi_device *spi)
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	reg_base = mpc8xxx_spi->reg_base;
 
+	pm_runtime_get_sync(mpc8xxx_spi->dev);
+
 	hw_mode = cs->hw_mode; /* Save original settings */
 	cs->hw_mode = mpc8xxx_spi_read_reg(
 			&reg_base->csmode[spi->chip_select]);
@@ -507,6 +512,10 @@ static int fsl_espi_setup(struct spi_device *spi)
 	mpc8xxx_spi_write_reg(&reg_base->mode, loop_mode);
 
 	retval = fsl_espi_setup_transfer(spi, NULL);
+
+	pm_runtime_mark_last_busy(mpc8xxx_spi->dev);
+	pm_runtime_put_autosuspend(mpc8xxx_spi->dev);
+
 	if (retval < 0) {
 		cs->hw_mode = hw_mode; /* Restore settings */
 		return retval;
@@ -604,15 +613,14 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	return ret;
 }
 
-static int fsl_espi_suspend(struct spi_master *master)
+#ifdef CONFIG_PM
+static int fsl_espi_runtime_suspend(struct device *dev)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
 	u32 regval;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
-	reg_base = mpc8xxx_spi->reg_base;
-
 	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
 	regval &= ~SPMODE_ENABLE;
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
@@ -620,21 +628,20 @@ static int fsl_espi_suspend(struct spi_master *master)
 	return 0;
 }
 
-static int fsl_espi_resume(struct spi_master *master)
+static int fsl_espi_runtime_resume(struct device *dev)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
 	u32 regval;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
-	reg_base = mpc8xxx_spi->reg_base;
-
 	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
 	regval |= SPMODE_ENABLE;
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
 	return 0;
 }
+#endif
 
 static struct spi_master * fsl_espi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
@@ -662,8 +669,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
-	master->prepare_transfer_hardware = fsl_espi_resume;
-	master->unprepare_transfer_hardware = fsl_espi_suspend;
+	master->auto_runtime_pm = true;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
@@ -726,14 +732,27 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
+	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	ret = devm_spi_register_master(dev, master);
 	if (ret < 0)
-		goto err_probe;
+		goto err_pm;
 
 	dev_info(dev, "at 0x%p (irq = %d)\n", reg_base, mpc8xxx_spi->irq);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return master;
 
+err_pm:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 err_probe:
 	spi_master_put(master);
 err:
@@ -800,6 +819,8 @@ err:
 
 static int of_fsl_espi_remove(struct platform_device *dev)
 {
+	pm_runtime_disable(&dev->dev);
+
 	return 0;
 }
 
@@ -815,7 +836,11 @@ static int of_fsl_espi_suspend(struct device *dev)
 		return ret;
 	}
 
-	return fsl_espi_suspend(master);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int of_fsl_espi_resume(struct device *dev)
@@ -825,7 +850,7 @@ static int of_fsl_espi_resume(struct device *dev)
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
 	u32 regval;
-	int i;
+	int i, ret;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	reg_base = mpc8xxx_spi->reg_base;
@@ -845,11 +870,17 @@ static int of_fsl_espi_resume(struct device *dev)
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
 	return spi_master_resume(master);
 }
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops espi_pm = {
+	SET_RUNTIME_PM_OPS(fsl_espi_runtime_suspend,
+			   fsl_espi_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(of_fsl_espi_suspend, of_fsl_espi_resume)
 };
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
