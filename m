From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] spi: spidev: Add ACPI probing support
Date: Mon,  4 Jul 2016 17:18:15 +0300
Message-ID: <1467641895-5341-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some IoT and maker software stacks are using spidev to perform raw access
to the SPI bus instead of relying existing drivers provided by the kernel.
They then implement their own "drivers" in userspace on top of the spidev
raw interface. This is far from being an ideal solution but we do not want
to prevent using mainline Linux in these devices.

Now, it turns out that Windows has similar SPI devices than spidev which
allow raw access on the SPI bus to userspace programs as described in the
link below:

  https://msdn.microsoft.com/windows/hardware/drivers/spb/spi-tests-in-mitt

These SPI test devices are also meant to be used during development and
testing.

In order to allow usage of spidev for development and testing in Linux, add
those same ACPI IDs to the spidev driver (which is Linux counterpart of the
Windows SPI test devices), but complain loudly so that users know it is not
good idea to use it in production systems. Instead they should be using
proper drivers for peripherals connected to the SPI bus.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Changes from v1:

  - Issue warning only for SPT000* ACPI IDs (when SPIDEV_ACPI_DUMMY is
    set).

 drivers/spi/spidev.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f30f591..2e05046f866b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -29,6 +29,7 @@
 #include <linux/compat.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/acpi.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -700,6 +701,43 @@ static const struct of_device_id spidev_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
 #endif
 
+#ifdef CONFIG_ACPI
+
+/* Dummy SPI devices not to be used in production systems */
+#define SPIDEV_ACPI_DUMMY	1
+
+static const struct acpi_device_id spidev_acpi_ids[] = {
+	/*
+	 * The ACPI SPT000* devices are only meant for development and
+	 * testing. Systems used in production should have a proper ACPI
+	 * description of the connected peripheral and they should also use
+	 * a proper driver instead of poking directly to the SPI bus.
+	 */
+	{ "SPT0001", SPIDEV_ACPI_DUMMY },
+	{ "SPT0002", SPIDEV_ACPI_DUMMY },
+	{ "SPT0003", SPIDEV_ACPI_DUMMY },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, spidev_acpi_ids);
+
+static void spidev_probe_acpi(struct spi_device *spi)
+{
+	const struct acpi_device_id *id;
+
+	if (!has_acpi_companion(&spi->dev))
+		return;
+
+	id = acpi_match_device(spidev_acpi_ids, &spi->dev);
+	if (WARN_ON(!id))
+		return;
+
+	if (id->driver_data == SPIDEV_ACPI_DUMMY)
+		dev_warn(&spi->dev, "do not use this driver in production systems!\n");
+}
+#else
+static inline void spidev_probe_acpi(struct spi_device *spi) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int spidev_probe(struct spi_device *spi)
@@ -719,6 +757,8 @@ static int spidev_probe(struct spi_device *spi)
 			!of_match_device(spidev_dt_ids, &spi->dev));
 	}
 
+	spidev_probe_acpi(spi);
+
 	/* Allocate driver data */
 	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
 	if (!spidev)
@@ -789,6 +829,7 @@ static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
 		.of_match_table = of_match_ptr(spidev_dt_ids),
+		.acpi_match_table = ACPI_PTR(spidev_acpi_ids),
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
