From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCHv2 2/3] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri,  1 Nov 2013 14:35:55 +0200
Message-ID: <1383309356-25430-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Current I2C adapter id - client address "x-00yy" based device naming scheme
is not always stable enough to be used in name based matching, for instance
within ALSA SoC subsystem.

This is problematic in PC kind of platforms where I2C adapter numbers can
change due variable amount of bus controllers, probe order, add-on cards or
just because of BIOS settings.

This patch addresses the problem by using the ACPI device name with
"i2c-" prefix for ACPI enumerated I2C slaves. For them device name
"x-00yz" becomes "i2c-INTABCD:ij" after this patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 75ba860..9126c2e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -48,6 +48,7 @@
 #include <linux/rwsem.h>
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
 #include "i2c-core.h"
@@ -618,6 +619,24 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
 
+static void i2c_dev_set_name(struct i2c_adapter *adap,
+			     struct i2c_client *client)
+{
+	if (ACPI_HANDLE(&client->dev)) {
+		struct acpi_device *adev;
+		if (!acpi_bus_get_device(ACPI_HANDLE(&client->dev), &adev)) {
+			dev_set_name(&client->dev, "i2c-%s",
+				     dev_name(&adev->dev));
+			return;
+		}
+	}
+
+	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
+	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
+		     client->addr | ((client->flags & I2C_CLIENT_TEN)
+				     ? 0xa000 : 0));
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -676,10 +695,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	ACPI_HANDLE_SET(&client->dev, info->acpi_node.handle);
 
-	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
-	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr | ((client->flags & I2C_CLIENT_TEN)
-				     ? 0xa000 : 0));
+	i2c_dev_set_name(adap, client);
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;
-- 
1.8.4.rc3

