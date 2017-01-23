From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 2/3] i2c: acpi: Initialize info.type from of_compatible
Date: Mon, 23 Jan 2017 16:08:56 +0000
Message-ID: <1485187737-22414-3-git-send-email-dan@emutex.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan O'Donovan <dan@emutex.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

When using devicetree i2c_board_info.type is set to the compatible
string with the vendor prefix removed. For I2C devices described via
ACPI the i2c_board_info.type string is set to the ACPI device name. When
using ACPI and DT ids this string ends up something like "PRP0001:00".

If the of_compatible property is present try to use that instead. This
makes it easier to instantiate i2c drivers through ACPI with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/i2c/i2c-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 583e950..a83dbc7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -221,7 +221,13 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
+	/*
+	 * Populate modalias from compatible property if available,
+	 * otherwise use native ACPI information
+	 */
+	if ((!adev->data.of_compatible) ||
+	    acpi_of_modalias(adev, info->type, sizeof(info->type)))
+		strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
 
 	return 0;
 }
-- 
2.7.4
