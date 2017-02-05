From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v6 2/3] i2c: acpi: Initialize info.type from of_compatible
Date: Sun,  5 Feb 2017 16:30:13 +0000
Message-ID: <1486312214-20770-3-git-send-email-dan@emutex.com>
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

When using devicetree i2c_board_info.type is set to the compatible
string with the vendor prefix removed. For I2C devices described via
ACPI the i2c_board_info.type string is set to the ACPI device name. When
using ACPI and DT ids this string ends up something like "PRP0001:00".

If the of_compatible property is present try to use that instead. This
makes it easier to instantiate i2c drivers through ACPI with DT ids.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 583e950..1e52395 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -221,7 +221,8 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
+	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
+			  sizeof(info->type));
 
 	return 0;
 }
-- 
2.7.4
