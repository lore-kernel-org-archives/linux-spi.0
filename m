From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 3/4] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Wed, 28 Jun 2017 19:20:19 +0200
Message-ID: <9f06a7ce1cc6dd4cb33004c7d37adc1a5c0f80e2.1498636759.git.lukas@wunner.de>
References: <cover.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1498636759.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI and I2C slaves are enumerated by their respective parents rather
than the ACPI core.  They are recognized by presence of _CRS resources,
which however are missing on Macs.  Check for presence of device
properties instead.

Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reported-and-tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
Changes v1 -> v2:
- Newly inserted patch in v2 to fix an enumeration issue. (Ronald)

 drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d4ff2cd1f738..c565e74bd2dd 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1444,6 +1444,12 @@ static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
 	struct list_head resource_list;
 	bool is_spi_i2c_slave = false;
 
+	/* Macs use device properties in lieu of _CRS resources */
+	if (IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.") &&
+	    (device_property_present(&device->dev, "spiSclkPeriod") ||
+	     device_property_present(&device->dev, "i2cAddress")))
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
