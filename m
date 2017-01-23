From: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Mon, 23 Jan 2017 16:08:57 +0000
Message-ID: <1485187737-22414-4-git-send-email-dan@emutex.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
        Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485187737-22414-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

When using devicetree spi_device.modalias is set to the compatible
string with the vendor prefix removed. For SPI devices described via
ACPI the spi_device.modalias string is initialized by acpi_device_hid.
When using ACPI and DT ids this string ends up something like "PRP0001".

Change acpi_register_spi_device to use the of_compatible property if
present. This makes it easier to instantiate spi drivers through ACPI
with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e..4b562e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1722,13 +1722,21 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
 		return AE_OK;
 	}
 
+	/*
+	 * Populate modalias from compatible property if available,
+	 * otherwise use native ACPI information
+	 */
+	if ((!adev->data.of_compatible) ||
+	    acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))
+		strlcpy(spi->modalias, acpi_device_hid(adev),
+			sizeof(spi->modalias));
+
 	if (spi->irq < 0)
 		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
 
 	acpi_device_set_enumerated(adev);
 
 	adev->power.flags.ignore_parent = true;
-	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
 	if (spi_add_device(spi)) {
 		adev->power.flags.ignore_parent = false;
 		dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
