From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 3/3] acpi spi: Initialize modalias from of_compatible
Date: Wed, 13 Jul 2016 14:53:42 +0300
Message-ID: <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <cover.1468409668.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1468409668.git.leonard.crestez@intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using devicetree spi_device.modalias is set to the compatible
string with the vendor prefix removed. For SPI devices described via
ACPI the i2c_board_info.type string is initialized by acpi_device_hid.
When using ACPI and DT ids this string ends up something like "PRP0001".

Change acpi_register_spi_device to use the of_compatible property if
present. This makes it easier to instantiate spi drivers through ACPI
with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/spi/spi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7589c8a..49fdf6e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1679,13 +1679,22 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
 		return AE_OK;
 	}
 
+	if (adev->data.of_compatible) {
+		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
+		if (ret) {
+			spi_dev_put(spi);
+			return AE_NOT_FOUND;
+		}
+	} else {
+		strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
+	}
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
