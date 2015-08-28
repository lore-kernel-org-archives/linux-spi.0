From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: add runtime PM" to the spi tree
Date: Fri, 28 Aug 2015 18:46:27 +0100
Message-ID: <E1ZVNjP-0007Op-RT@finisterre>
References: <55DE11D3.400@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55DE11D3.400-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: add runtime PM

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

>From e9abb4db8d108624c293f06dce06b2978e626a13 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 26 Aug 2015 21:21:55 +0200
Subject: [PATCH] spi: fsl-espi: add runtime PM

Add runtime PM and use autosuspend instead of suspending the
SPI controller after each transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 71 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index fe54e57..db82c87 100644
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
 
@@ -725,14 +731,27 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 
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
@@ -797,6 +816,13 @@ err:
 	return ret;
 }
 
+static int of_fsl_espi_remove(struct platform_device *dev)
+{
+	pm_runtime_disable(&dev->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int of_fsl_espi_suspend(struct device *dev)
 {
@@ -809,7 +835,11 @@ static int of_fsl_espi_suspend(struct device *dev)
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
@@ -819,7 +849,7 @@ static int of_fsl_espi_resume(struct device *dev)
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
 	u32 regval;
-	int i;
+	int i, ret;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	reg_base = mpc8xxx_spi->reg_base;
@@ -839,11 +869,17 @@ static int of_fsl_espi_resume(struct device *dev)
 
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
 
@@ -860,6 +896,7 @@ static struct platform_driver fsl_espi_driver = {
 		.pm = &espi_pm,
 	},
 	.probe		= of_fsl_espi_probe,
+	.remove		= of_fsl_espi_remove,
 };
 module_platform_driver(fsl_espi_driver);
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
