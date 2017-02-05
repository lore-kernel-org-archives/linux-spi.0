From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v6 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Sun,  5 Feb 2017 16:30:14 +0000
Message-ID: <1486312214-20770-4-git-send-email-dan@emutex.com>
References: <1486195228-10929-1-git-send-email-dan@emutex.com>
 <1486312214-20770-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan O'Donovan <dan@emutex.com>
To: linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1486312214-20770-1-git-send-email-dan@emutex.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using devicetree spi_device.modalias is set to the compatible
string with the vendor prefix removed. For SPI devices described via
ACPI the spi_device.modalias string is initialized by acpi_device_hid.
When using ACPI and DT ids this string ends up something like "PRP0001".

Change acpi_register_spi_device to use the of_compatible property if
present. This makes it easier to instantiate spi drivers through ACPI
with DT ids.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e..ad7f638 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1722,13 +1722,15 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
 		return AE_OK;
 	}
 
+	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
+			  sizeof(spi->modalias));
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
