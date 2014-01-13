From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] ACPI: fix create_modalias() return value handling
Date: Mon, 13 Jan 2014 21:48:09 +0800
Message-ID: <1389620889-3818-1-git-send-email-rui.zhang@intel.com>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently, create_modalias() handles the output truncated case in
an improper way (return -EINVAL).
Plus, acpi_device_uevent() and acpi_device_modalias_show() do
improper check for the create_modalias() return value as well.

This patch fixes create_modalias() to
return -EINVAL if there is an output error,
return -ENOMEM if the output is truncated,
and also fixes both acpi_device_uevent() and acpi_device_modalias_show()
to do proper return value check.

Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/scan.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fd39459..c925321 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -85,6 +85,9 @@ int acpi_scan_add_handler_with_hotplug(struct acpi_scan_handler *handler,
  * Creates hid/cid(s) string needed for modalias and uevent
  * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
  * char *modalias: "acpi:IBM0001:ACPI0001"
+ * Return: 0: no _HID and no _CID
+ *         -EINVAL: output error
+ *         -ENOMEM: output is truncated
 */
 static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 			   int size)
@@ -101,8 +104,10 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 
 	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
 		count = snprintf(&modalias[len], size, "%s:", id->id);
-		if (count < 0 || count >= size)
-			return -EINVAL;
+		if (count < 0)
+			return EINVAL;
+		if (count >= size)
+			return -ENOMEM;
 		len += count;
 		size -= count;
 	}
@@ -116,10 +121,9 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	int len;
 
-	/* Device has no HID and no CID or string is >1024 */
 	len = create_modalias(acpi_dev, buf, 1024);
 	if (len <= 0)
-		return 0;
+		return len;
 	buf[len++] = '\n';
 	return len;
 }
@@ -782,8 +786,8 @@ static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return -ENOMEM;
 	len = create_modalias(acpi_dev, &env->buf[env->buflen - 1],
 			      sizeof(env->buf) - env->buflen);
-	if (len >= (sizeof(env->buf) - env->buflen))
-		return -ENOMEM;
+	if (len <= 0)
+		return len;
 	env->buflen += len;
 	return 0;
 }
-- 
1.7.9.5
