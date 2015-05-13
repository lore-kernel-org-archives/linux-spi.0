From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Add option to bind spidev to all chipselects
Date: 13 May 2015 09:34:41 -0000
Message-ID: <20150513093441.80359.qmail@dec59.ruk.cuni.cz>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431462804-30467-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Bypass the check if CS is in use for spidev devices if CONFIG_SPIDEV_SHADOW is
set.  Rename spidev devices to avoid sysfs conflict.

This allows dynamically loading SPI device overlays or communicating
with SPI devices configured by a kernel driver from userspace.

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig     | 13 +++++++++
 drivers/spi/spi.c       | 74 ++++++++++++++++++++++++++++++++++---------------
 include/linux/spi/spi.h |  1 +
 3 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 198f96b..b477828 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -651,6 +651,19 @@ config SPI_SPIDEV
 	  Note that this application programming interface is EXPERIMENTAL
 	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
 
+config SPIDEV_SHADOW
+	depends on SPI_SPIDEV
+	bool "Allow spidev access to configured SPI devices (DANGEROUS)"
+	help
+	  This creates a spidev device node for every chipselect.
+
+	  It is possible to access even SPI devices which are in use by a
+	  kernel driver. This allows invoking features not in use by the kernel
+	  or checking device state from userspace when the kernel driver fails.
+
+	  Sending out-of-order messages to the device or reconfiguring the
+	  device might cause driver failure. DANGEROUS
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e6ca46e..b48a0dc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -254,16 +254,23 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
-static void spi_dev_set_name(struct spi_device *spi)
+static void spi_dev_set_name(struct spi_device *spi, const char * alias)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
 
 	if (adev) {
-		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
+		if (alias)
+			dev_set_name(&spi->dev, "%s-%s", alias, acpi_dev_name(adev));
+		else
+			dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
 		return;
 	}
 
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
+	if (alias)
+		dev_set_name(&spi->dev, "%s%u.%u", alias, spi->master->bus_num,
+		     spi->chip_select);
+	else
+		dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
 		     spi->chip_select);
 }
 
@@ -272,22 +279,25 @@ static int spi_dev_check(struct device *dev, void *data)
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_device *new_spi = data;
 
-	if (spi->master == new_spi->master &&
-	    spi->chip_select == new_spi->chip_select)
+	if (spi->master == new_spi->master
+	    && spi->chip_select == new_spi->chip_select
+#ifdef CONFIG_SPIDEV_SHADOW
+	    && !spi->shadow && !new_spi->shadow
+#endif
+	    )
 		return -EBUSY;
 	return 0;
 }
 
 /**
- * spi_add_device - Add spi_device allocated with spi_alloc_device
+ * spi_add_device_alias - Add spi_device allocated with spi_alloc_device
+ * possibly even when device for the CS exists.
  * @spi: spi_device to register
+ * @alias: string used as device name prefix or NULL
  *
- * Companion function to spi_alloc_device.  Devices allocated with
- * spi_alloc_device can be added onto the spi bus with this function.
- *
- * Returns 0 on success; negative errno on failure
+ * See spi_add_device
  */
-int spi_add_device(struct spi_device *spi)
+static inline int spi_add_device_alias(struct spi_device *spi, const char * alias)
 {
 	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_master *master = spi->master;
@@ -303,7 +313,8 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	/* Set the bus ID string */
-	spi_dev_set_name(spi);
+	spi_dev_set_name(spi, alias);
+	spi->shadow = !!alias;
 
 	/* We need to make sure there's no other device with this
 	 * chipselect **BEFORE** we call setup(), else we'll trash
@@ -321,15 +332,17 @@ int spi_add_device(struct spi_device *spi)
 	if (master->cs_gpios)
 		spi->cs_gpio = master->cs_gpios[spi->chip_select];
 
-	/* Drivers may modify this initial i/o setup, but will
-	 * normally rely on the device being setup.  Devices
-	 * using SPI_CS_HIGH can't coexist well otherwise...
-	 */
-	status = spi_setup(spi);
-	if (status < 0) {
-		dev_err(dev, "can't setup %s, status %d\n",
-				dev_name(&spi->dev), status);
-		goto done;
+	if (!alias) {
+			/* Drivers may modify this initial i/o setup, but will
+			 * normally rely on the device being setup.  Devices
+			 * using SPI_CS_HIGH can't coexist well otherwise...
+			 */
+			status = spi_setup(spi);
+			if (status < 0) {
+					dev_err(dev, "can't setup %s, status %d\n",
+						dev_name(&spi->dev), status);
+					goto done;
+			}
 	}
 
 	/* Device may be bound to an active driver when this returns */
@@ -344,6 +357,20 @@ done:
 	mutex_unlock(&spi_add_lock);
 	return status;
 }
+
+/**
+ * spi_add_device - Add spi_device allocated with spi_alloc_device
+ * @spi: spi_device to register
+ *
+ * Companion function to spi_alloc_device.  Devices allocated with
+ * spi_alloc_device can be added onto the spi bus with this function.
+ *
+ * Returns 0 on success; negative errno on failure
+ */
+int spi_add_device(struct spi_device *spi)
+{
+	return spi_add_device_alias(spi, NULL);
+}
 EXPORT_SYMBOL_GPL(spi_add_device);
 
 /**
@@ -1400,6 +1427,7 @@ static void spidev_register_devices(struct spi_master *master)
 		spi->chip_select = i;
 		strlcpy(spi->modalias, "spidev", sizeof(spi->modalias));
 
+#ifndef CONFIG_SPIDEV_SHADOW
 		/*
 		 * This is far from perfect since an addition might be
 		 * done between here and the call to spi_add_device,
@@ -1418,8 +1446,8 @@ static void spidev_register_devices(struct spi_master *master)
 			spi_dev_put(spi);
 			continue;
 		}
-
-		if (spi_add_device(spi)) {
+#endif /* CONFIG_SPIDEV_SHADOW */
+		if (spi_add_device_alias(spi, "spidev")) {
 			dev_err(&master->dev, "Couldn't add spidev device\n");
 			spi_dev_put(spi);
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..8368714 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -97,6 +97,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	int			shadow; /* ignore when determining if CS is in use */
 
 	/*
 	 * likely need more hooks for more protocol options affecting how
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
