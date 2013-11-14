From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv4 3/3] spi: Use stable dev_name for ACPI enumerated SPI slaves
Date: Thu, 14 Nov 2013 14:03:53 +0200
Message-ID: <1384430633-23426-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384430633-23426-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Mark's ack added as diff between v3 and v4 is just:
-		dev_set_name(&spi->dev, "spi-%s", dev_name(&adev->dev));
+		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
---
 drivers/spi/spi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index af4f971..be619e0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -352,6 +352,19 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
+static void spi_dev_set_name(struct spi_device *spi)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+
+	if (adev) {
+		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
+		return;
+	}
+
+	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
+		     spi->chip_select);
+}
+
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -378,9 +391,7 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	/* Set the bus ID string */
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
-			spi->chip_select);
-
+	spi_dev_set_name(spi);
 
 	/* We need to make sure there's no other device with this
 	 * chipselect **BEFORE** we call setup(), else we'll trash
-- 
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
