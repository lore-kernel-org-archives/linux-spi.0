From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 1/3] acpi: Export acpi_of_modalias equiv of of_modalias_node
Date: Wed, 15 Jun 2016 21:30:27 +0300
Message-ID: <2cc8100c0c0f79a56163429aaefc0fcfecc808f4.1466014238.git.leonard.crestez@intel.com>
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

When using devicetree stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this try to replicate it when using
ACPI with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/acpi/bus.c      | 36 ++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 262ca31..4208e0d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -606,6 +606,42 @@ static bool acpi_of_match_device(struct acpi_device *adev,
 	return false;
 }
 
+/**
+ * acpi_of_modalias - Like of_modalias_node for ACPI with DT ids
+ * @adev:	ACPI device object to match.
+ * @outstr:	Pointer to buffer for result
+ * @outlen:	Length of outstr value
+ *
+ * If we have a DT id set outstr to the first compatible string with the vendor
+ * prefix stripped, just like of_modalias_node does for devicetree.
+ *
+ * Returns 0 on success or negative errno on failure.
+ */
+int acpi_of_modalias(struct acpi_device *adev, char *outstr, int outlen)
+{
+	const union acpi_object *of_compatible;
+	const union acpi_object *obj;
+	const char *str, *chr;
+
+	of_compatible = adev->data.of_compatible;
+	if (!of_compatible)
+		return -ENODEV;
+
+	if (of_compatible->type == ACPI_TYPE_PACKAGE)
+		obj = of_compatible->package.elements;
+	else /* Must be ACPI_TYPE_STRING. */
+		obj = of_compatible;
+
+	str = obj->string.pointer;
+	chr = strchr(str, ',');
+	if (chr)
+		str = chr + 1;
+	strlcpy(outstr, str, outlen);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_of_modalias);
+
 static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 				    struct acpi_hardware_id *hwid)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 788c6c35..e6523de 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -515,6 +515,7 @@ void acpi_bus_trim(struct acpi_device *start);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+int acpi_of_modalias(struct acpi_device *adev, char *outstr, int outlen);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
-- 
2.5.5
