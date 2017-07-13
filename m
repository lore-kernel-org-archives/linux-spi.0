From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 5/6] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <5e1e3da2efb3bb8dea5b49d29585b90cf76891be.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499983092.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI and I2C slaves are enumerated by their respective parents rather
than the ACPI core.  They are recognized by presence of _CRS resources,
which however are missing on Macs.  Check for presence of device
properties instead.

Cc: Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reported-and-tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
Changes v2 -> v3:
- Use fwnode_property_present() instead of device_property_present(),
  the latter doesn't work as the fwnode pointer of the struct device
  embedded in a struct acpi_device is always NULL. (Ronald)

 drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 59ebbd5f7b83..e84e5eb23222 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1452,6 +1452,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
 	struct list_head resource_list;
 	bool is_spi_i2c_slave = false;
 
+	/* Macs use device properties in lieu of _CRS resources */
+	if (is_apple_system &&
+	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
+	     fwnode_property_present(&device->fwnode, "i2cAddress")))
+		return true;
+
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
 			       &is_spi_i2c_slave);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
