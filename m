From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v6 1/3] ACPI / bus: Export acpi_of_modalias equiv of of_modalias_node
Date: Sun,  5 Feb 2017 16:30:12 +0000
Message-ID: <1486312214-20770-2-git-send-email-dan@emutex.com>
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

When using devicetree stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this try to replicate it when using
ACPI with DT ids.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/acpi/bus.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb..80cb5eb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -677,6 +677,48 @@ static bool acpi_of_match_device(struct acpi_device *adev,
 	return false;
 }
 
+static bool acpi_of_modalias(struct acpi_device *adev,
+			     char *modalias, size_t len)
+{
+	const union acpi_object *of_compatible;
+	const union acpi_object *obj;
+	const char *str, *chr;
+
+	of_compatible = adev->data.of_compatible;
+	if (!of_compatible)
+		return false;
+
+	if (of_compatible->type == ACPI_TYPE_PACKAGE)
+		obj = of_compatible->package.elements;
+	else /* Must be ACPI_TYPE_STRING. */
+		obj = of_compatible;
+
+	str = obj->string.pointer;
+	chr = strchr(str, ',');
+	strlcpy(modalias, chr ? chr + 1 : str, len);
+
+	return true;
+}
+
+/**
+ * acpi_set_modalias - Set modalias using "compatible" property or supplied ID
+ * @adev:	ACPI device object to match
+ * @default_id:	ID string to use as default if no compatible string found
+ * @modalias:   Pointer to buffer that modalias value will be copied into
+ * @len:	Length of modalias buffer
+ *
+ * This is a counterpart of of_modalias_node() for struct acpi_device objects.
+ * If there is a compatible string for @adev, it will be copied to @modalias
+ * with the vendor prefix stripped; otherwise, @default_id will be used.
+ */
+void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
+		       char *modalias, size_t len)
+{
+	if (!acpi_of_modalias(adev, modalias, len))
+		strlcpy(modalias, default_id, len);
+}
+EXPORT_SYMBOL_GPL(acpi_set_modalias);
+
 static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 				    struct acpi_hardware_id *hwid)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4242c31..ef0ae8a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -522,6 +522,8 @@ void acpi_bus_trim(struct acpi_device *start);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
+		       char *modalias, size_t len);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
-- 
2.7.4
