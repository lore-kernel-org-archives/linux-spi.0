From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv4 1/3] ACPI: Provide acpi_dev_name accessor for struct acpi_device device name
Date: Thu, 14 Nov 2013 14:03:51 +0200
Message-ID: <1384430633-23426-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384430633-23426-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

struct acpi_device fields are only available when CONFIG_ACPI is set. We may
find use for dev_name(&adev->dev) in generic code that is build also without
CONFIG_ACPI is set but currently this requires #ifdef CONFIG_ACPI churn.

Provide here an accessor that returns dev_name of embedded struct device dev
in struct acpi_device or NULL depending on CONFIG_ACPI setting.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/acpi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0da49ed..844e7ff 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -53,6 +53,11 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 #define ACPI_COMPANION_SET(dev, adev)	ACPI_COMPANION(dev) = (adev)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+static inline const char *acpi_dev_name(struct acpi_device *adev)
+{
+	return dev_name(&adev->dev);
+}
+
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,
 	ACPI_IRQ_MODEL_IOAPIC,
@@ -420,6 +425,11 @@ static inline bool acpi_driver_match_device(struct device *dev,
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 
+static inline const char *acpi_dev_name(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline void acpi_early_init(void) { }
 
 static inline int early_acpi_boot_init(void)
-- 
1.8.4.2
