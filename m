From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 1/3] ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI builds
Date: Fri,  1 Nov 2013 14:35:54 +0200
Message-ID: <1383309356-25430-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383309356-25430-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We may find use for struct acpi_device and acpi_bus_get_device() in generic
code without wanting to add #if IS_ENABLED(CONFIG_ACPI) churn there.

Code can use ACPI_HANDLE() test to let compiler optimize out code blocks
that are not used in !CONFIG_ACPI builds but structure definitions and
function stubs must be available.

This patch moves CONFIG_ACPI test so that struct acpi_device definition
is available for all builds that include acpi_bus.h and provides a stub for
acpi_bus_get_device().

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/acpi/acpi_bus.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 15100f6..232b37d3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -66,8 +66,6 @@ bool acpi_ata_match(acpi_handle handle);
 bool acpi_bay_match(acpi_handle handle);
 bool acpi_dock_match(acpi_handle handle);
 
-#ifdef CONFIG_ACPI
-
 #include <linux/proc_fs.h>
 
 #define ACPI_BUS_FILE_ROOT	"acpi"
@@ -315,6 +313,8 @@ struct acpi_device {
 	void (*remove)(struct acpi_device *);
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
+
 static inline void *acpi_driver_data(struct acpi_device *d)
 {
 	return d->driver_data;
@@ -532,6 +532,11 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
+static inline int acpi_bus_get_device(acpi_handle handle,
+				      struct acpi_device **device)
+{
+	return -ENODEV;
+}
 
 #endif				/* CONFIG_ACPI */
 
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
