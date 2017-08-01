From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v4 4/5] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Tue, 1 Aug 2017 14:10:41 +0200
Message-ID: <a113ce387bb9af7aaf804359561178d8f1499ef0.1501570421.git.lukas@wunner.de>
References: <cover.1501570421.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1501570421.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI and I2C slaves are enumerated by their respective parents rather
than the ACPI core.  They are recognized by presence of _CRS resources,
which however are missing on Macs.  Check for presence of device
properties instead.

Cc: Federico Lorenzi <florenzi@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-and-tested-by: Ronald Tschalär <ronald@innovation.ch>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 943536c9a2a8..71a067c412a1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -13,6 +13,7 @@
 #include <linux/dmi.h>
 #include <linux/nls.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_data/x86/apple.h>
 
 #include <asm/pgtable.h>
 
@@ -1452,6 +1453,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
 	struct list_head resource_list;
 	bool is_spi_i2c_slave = false;
 
+	/* Macs use device properties in lieu of _CRS resources */
+	if (x86_apple_machine &&
+	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
+	     fwnode_property_present(&device->fwnode, "i2cAddress")))
+		return true;
+
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
 			       &is_spi_i2c_slave);
-- 
2.11.0

