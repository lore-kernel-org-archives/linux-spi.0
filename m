From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v4 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Fri, 27 Jan 2017 13:30:15 +0000
Message-ID: <1485523815-9629-4-git-send-email-dan@emutex.com>
References: <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485523815-9629-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan O'Donovan <dan@emutex.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485523815-9629-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

When using devicetree spi_device.modalias is set to the compatible
string with the vendor prefix removed. For SPI devices described via
ACPI the spi_device.modalias string is initialized by acpi_device_hid.
When using ACPI and DT ids this string ends up something like "PRP0001".

Change acpi_register_spi_device to use the of_compatible property if
present. This makes it easier to instantiate spi drivers through ACPI
with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e..9a8c880 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1722,13 +1722,20 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
 		return AE_OK;
 	}
 
+	/*
+	 * Populate modalias from compatible property if available,
+	 * otherwise use native ACPI information
+	 */
+	if (acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))
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
