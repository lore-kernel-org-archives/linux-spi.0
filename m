From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 3/3] acpi spi: Initialize modalias from of_compatible
Date: Wed, 15 Jun 2016 21:30:29 +0300
Message-ID: <40e5cbb0aa638c619fc7fe9f1dbfaa50e888c2ac.1466014238.git.leonard.crestez@intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466014238.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1466014238.git.leonard.crestez@intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/spi/spi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45..eef5ac2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1680,11 +1680,19 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 		return AE_OK;
 	}
 
+	if (adev->data.of_compatible) {
+		ret = acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias));
+		if (ret) {
+			spi_dev_put(spi);
+			return AE_NOT_FOUND;
+		}
+	} else
+		strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
+
 	if (spi->irq < 0)
 		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
 
 	adev->power.flags.ignore_parent = true;
-	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
 	if (spi_add_device(spi)) {
 		adev->power.flags.ignore_parent = false;
 		dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
-- 
2.5.5
