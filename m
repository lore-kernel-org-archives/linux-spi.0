From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 2/2] spi: Use stable dev_name for ACPI enumerated SPI slaves
Date: Fri, 25 Oct 2013 15:19:00 +0300
Message-ID: <1382703540-3769-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382703540-3769-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current spi bus_num.chip_select "spix.y" based device naming scheme may not
be stable enough to be used in name based matching, for instance within
ALSA SoC subsystem.

This can be problem in PC kind of platforms if there are changes in SPI bus
configuration, amount of busses or probe order.

This patch addresses the problem by using the ACPI device name with
"spi-" prefix for ACPI enumerated SPI slave. For them device name
"spix.y" becomes "spi-INTABCD:ij".

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
"may not be" and "This can be problem" since I don't know how likely is to
have changes in SPI bus configuration in PC kind of devices. I assume yes as
this is already problem with I2C devices.
---
 drivers/spi/spi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8d05acc..2ca997f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -345,6 +345,23 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
+void spi_dev_set_name(struct spi_device *spi)
+{
+#if IS_ENABLED(CONFIG_ACPI)
+	if (ACPI_HANDLE(&spi->dev)) {
+		struct acpi_device *adev;
+		if (!acpi_bus_get_device(ACPI_HANDLE(&spi->dev), &adev)) {
+			dev_set_name(&spi->dev, "spi-%s",
+				     dev_name(&adev->dev));
+			return;
+		}
+	}
+#endif
+
+	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
+		     spi->chip_select);
+}
+
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -371,9 +388,7 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	/* Set the bus ID string */
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
-			spi->chip_select);
-
+	spi_dev_set_name(spi);
 
 	/* We need to make sure there's no other device with this
 	 * chipselect **BEFORE** we call setup(), else we'll trash
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
