From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] spi: Remove support for legacy PM
Date: Sun,  8 Mar 2015 14:56:38 +0100
Message-ID: <1425822998-30487-2-git-send-email-lars@metafoo.de>
References: <1425822998-30487-1-git-send-email-lars@metafoo.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425822998-30487-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

All SPI drivers have been converted from legacy suspend/resume callbacks to
dev_pm_ops. So we can finally remove support for legacy PM from the SPI
core.

Since there aren't any special bus specific things to do during
suspend/resume and since the PM core will automatically fallback directly to
using the device's PM ops if no bus PM ops are specified there is no need to
have any special SPI bus PM ops.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi.c       | 114 ------------------------------------------------
 include/linux/spi/spi.h |   4 --
 2 files changed, 118 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c64a3e5..7a2b7a7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -129,125 +129,11 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int spi_legacy_suspend(struct device *dev, pm_message_t message)
-{
-	int			value = 0;
-	struct spi_driver	*drv = to_spi_driver(dev->driver);
-
-	/* suspend will stop irqs and dma; no more i/o */
-	if (drv) {
-		if (drv->suspend)
-			value = drv->suspend(to_spi_device(dev), message);
-		else
-			dev_dbg(dev, "... can't suspend\n");
-	}
-	return value;
-}
-
-static int spi_legacy_resume(struct device *dev)
-{
-	int			value = 0;
-	struct spi_driver	*drv = to_spi_driver(dev->driver);
-
-	/* resume may restart the i/o queue */
-	if (drv) {
-		if (drv->resume)
-			value = drv->resume(to_spi_device(dev));
-		else
-			dev_dbg(dev, "... can't resume\n");
-	}
-	return value;
-}
-
-static int spi_pm_suspend(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_suspend(dev);
-	else
-		return spi_legacy_suspend(dev, PMSG_SUSPEND);
-}
-
-static int spi_pm_resume(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_resume(dev);
-	else
-		return spi_legacy_resume(dev);
-}
-
-static int spi_pm_freeze(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_freeze(dev);
-	else
-		return spi_legacy_suspend(dev, PMSG_FREEZE);
-}
-
-static int spi_pm_thaw(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_thaw(dev);
-	else
-		return spi_legacy_resume(dev);
-}
-
-static int spi_pm_poweroff(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_poweroff(dev);
-	else
-		return spi_legacy_suspend(dev, PMSG_HIBERNATE);
-}
-
-static int spi_pm_restore(struct device *dev)
-{
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
-
-	if (pm)
-		return pm_generic_restore(dev);
-	else
-		return spi_legacy_resume(dev);
-}
-#else
-#define spi_pm_suspend	NULL
-#define spi_pm_resume	NULL
-#define spi_pm_freeze	NULL
-#define spi_pm_thaw	NULL
-#define spi_pm_poweroff	NULL
-#define spi_pm_restore	NULL
-#endif
-
-static const struct dev_pm_ops spi_pm = {
-	.suspend = spi_pm_suspend,
-	.resume = spi_pm_resume,
-	.freeze = spi_pm_freeze,
-	.thaw = spi_pm_thaw,
-	.poweroff = spi_pm_poweroff,
-	.restore = spi_pm_restore,
-	SET_RUNTIME_PM_OPS(
-		pm_generic_runtime_suspend,
-		pm_generic_runtime_resume,
-		NULL
-	)
-};
-
 struct bus_type spi_bus_type = {
 	.name		= "spi",
 	.dev_groups	= spi_dev_groups,
 	.match		= spi_match_device,
 	.uevent		= spi_uevent,
-	.pm		= &spi_pm,
 };
 EXPORT_SYMBOL_GPL(spi_bus_type);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ed9489d..9f6b481 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -162,8 +162,6 @@ struct spi_transfer;
  * @remove: Unbinds this driver from the spi device
  * @shutdown: Standard shutdown callback used during system state
  *	transitions such as powerdown/halt and kexec
- * @suspend: Standard suspend callback used during system state transitions
- * @resume: Standard resume callback used during system state transitions
  * @driver: SPI device drivers should initialize the name and owner
  *	field of this structure.
  *
@@ -184,8 +182,6 @@ struct spi_driver {
 	int			(*probe)(struct spi_device *spi);
 	int			(*remove)(struct spi_device *spi);
 	void			(*shutdown)(struct spi_device *spi);
-	int			(*suspend)(struct spi_device *spi, pm_message_t mesg);
-	int			(*resume)(struct spi_device *spi);
 	struct device_driver	driver;
 };
 
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
