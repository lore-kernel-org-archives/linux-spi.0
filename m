From: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/3] ACPI / bus: Export acpi_of_modalias equiv of of_modalias_node
Date: Mon, 23 Jan 2017 16:08:55 +0000
Message-ID: <1485187737-22414-2-git-send-email-dan@emutex.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>,
        Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485187737-22414-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

When using devicetree stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this try to replicate it when using
ACPI with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/bus.c      | 35 +++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 95855cb..8b9657f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -677,6 +677,41 @@ static bool acpi_of_match_device(struct acpi_device *adev,
 	return false;
 }
 
+/**
+ * acpi_of_modalias - Like of_modalias_node for ACPI with DT ids
+ * @adev:	ACPI device object to match.
+ * @outstr:	Pointer to buffer for result
+ * @outlen:	Length of outstr value
+ *
+ * This is a counterpart of of_modalias_node() for struct acpi_device
+ * objects. If there is a compatible string for @adev, copy it to the
+ * @outstr location with the vendor prefix stripped.
+ *
+ * Returns 0 on success or negative errno on failure.
+ */
+int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen)
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
+	strlcpy(outstr, chr ? chr + 1 : str, outlen);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_of_modalias);
+
 static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 				    struct acpi_hardware_id *hwid)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4242c31..351b4a4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -522,6 +522,7 @@ void acpi_bus_trim(struct acpi_device *start);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
 int acpi_match_device_ids(struct acpi_device *device,
 			  const struct acpi_device_id *ids);
+int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
