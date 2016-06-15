From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Wed, 15 Jun 2016 21:30:28 +0300
Message-ID: <13cb5b7766b1b25a2bb61ce0053a38f6f440907b.1466014238.git.leonard.crestez@intel.com>
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

When using devicetree i2c_board_info.type is set to the compatible
string with the vendor prefix removed. For I2C devices described via
ACPI the i2c_board_info.type string is set to the ACPI device name. When
using ACPI and DT ids this string ends up something like "PRP0001:00".

If the of_compatible property is present try to use that instead. This
makes it easier to instantiate i2c drivers through ACPI with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/i2c/i2c-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index af11b65..5ab1fb9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -188,8 +188,14 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 
 	acpi_dev_free_resource_list(&resource_list);
 
+	if (adev->data.of_compatible) {
+		ret = acpi_of_modalias(adev, info.type, sizeof(info.type));
+		if (ret)
+			return -EINVAL;
+	} else
+		strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
+
 	adev->power.flags.ignore_parent = true;
-	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
 	if (!i2c_new_device(adapter, &info)) {
 		adev->power.flags.ignore_parent = false;
 		dev_err(&adapter->dev,
-- 
2.5.5
