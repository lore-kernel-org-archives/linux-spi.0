From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: Force the registration of the spidev devices
Date: Mon, 28 Apr 2014 10:22:54 -0700
Message-ID: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spidev device registration has always been a controversial subject since the
move to DT.

Obviously, a spidev node has nothing to do in the DT, and the position so far
has been to add the compatible of the devices to drive through spidev to the
list of the compatibles spidev can handle.

While this is nicer than the DT solution because of its accurate hardware
representation, it's still not perfect because you might not have access to the
DT, or you might be driving a completely generic device (such as a
microcontroller) that might be used for something else in a different
context/board.

Solve this by registering automatically spidev devices for all the unused chip
selects when a master registers itself against the spi core.

This also adds an i2cdev-like feeling, where you get all the spidev devices all
the time, without any modification.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4eb9bf02996c..e832a5e20e8d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1402,6 +1402,52 @@ static void acpi_register_spi_devices(struct spi_master *master)
 static inline void acpi_register_spi_devices(struct spi_master *master) {}
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_SPI_SPIDEV
+static void spidev_register_devices(struct spi_master *master)
+{
+	struct spi_device *spi;
+	int i, status;
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		spi = spi_alloc_device(master);
+		if (!spi) {
+			dev_err(&master->dev, "Couldn't allocate spidev device\n");
+			continue;
+		}
+
+		spi->chip_select = i;
+		strlcpy(spi->modalias, "spidev", sizeof(spi->modalias));
+
+		/*
+		 * This is far from perfect since an addition might be
+		 * done between here and the call to spi_add_device,
+		 * but we can't hold the lock and call spi_add_device
+		 * either, as it would trigger a deadlock.
+		 *
+		 * If such a race occurs, spi_add_device will still
+		 * catch it though, as it also checks for devices
+		 * being registered several times on the same chip
+		 * select.
+		*/
+		status = bus_for_each_dev(&spi_bus_type, NULL, spi,
+					  spi_dev_check);
+		if (status) {
+			dev_dbg(&master->dev, "Chipselect already in use.. Skipping.");
+			spi_dev_put(spi);
+			continue;
+		}
+
+		if (spi_add_device(spi)) {
+			dev_err(&master->dev, "Couldn't add spidev device\n");
+			spi_dev_put(spi);
+		}
+	}
+
+}
+#else
+static inline void spidev_register_devices(struct spi_master *master) {}
+#endif /* CONFIG_SPI_SPIDEV */
+
 static void spi_master_release(struct device *dev)
 {
 	struct spi_master *master;
@@ -1591,6 +1637,7 @@ int spi_register_master(struct spi_master *master)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(master);
 	acpi_register_spi_devices(master);
+	spidev_register_devices(master);
 done:
 	return status;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
