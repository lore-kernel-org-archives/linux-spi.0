From: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: [TROLL PATCH] spi: add option to create spidev nodes for unclaimed chip selects
Date: Thu, 21 Jan 2016 16:36:09 +0000
Message-ID: <1453394169-11458-1-git-send-email-mans@mansr.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This adds an option to create spidev nodes for any chip selects not
bound to a driver via DT/ACPI.  It probably doesn't play nicely with
modules.

Signed-off-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig |  4 ++++
 drivers/spi/spi.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8b9c2a38d1cc..4977fc2fbb30 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -689,6 +689,10 @@ config SPI_SPIDEV
 	  Note that this application programming interface is EXPERIMENTAL
 	  and hence SUBJECT TO CHANGE WITHOUT NOTICE while it stabilizes.
 
+config SPI_SPIDEV_AUTO
+	bool "Create spidev nodes for unclaimed chip selects"
+	depends on SPI_SPIDEV
+
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dee1cb87d24f..8c0294387e6d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1654,6 +1654,34 @@ static void acpi_register_spi_devices(struct spi_master *master)
 static inline void acpi_register_spi_devices(struct spi_master *master) {}
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_SPI_SPIDEV_AUTO
+static void spidev_register_spi_devices(struct spi_master *master)
+{
+	struct spi_device *spi;
+	int err;
+	int i;
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		spi = spi_alloc_device(master);
+		if (!spi)
+			return;
+
+		strlcpy(spi->modalias, "spidev", sizeof(spi->modalias));
+		spi->chip_select = i;
+
+		err = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
+
+		if (!err)
+			err = spi_add_device(spi);
+
+		if (err)
+			spi_dev_put(spi);
+	}
+}
+#else
+static void spidev_register_spi_devices(struct spi_master *master) { }
+#endif
+
 static void spi_master_release(struct device *dev)
 {
 	struct spi_master *master;
@@ -1849,6 +1877,7 @@ int spi_register_master(struct spi_master *master)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(master);
 	acpi_register_spi_devices(master);
+	spidev_register_spi_devices(master);
 done:
 	return status;
 }
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
