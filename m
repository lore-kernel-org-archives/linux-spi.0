From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] OF: introduce OF style 'modalias' support for platform bus.
Date: Mon, 13 Jan 2014 21:48:36 +0800
Message-ID: <1389620916-3923-1-git-send-email-rui.zhang@intel.com>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix a problem that, the platform bus supports the OF style modalias
in .uevent() call, but not in its device' "modalias" sysfs attribute.

Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/base/platform.c   |    4 ++++
 drivers/of/device.c       |    3 +++
 include/linux/of_device.h |    6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2f4aea2..bc78848 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -679,6 +679,10 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	struct platform_device	*pdev = to_platform_device(dev);
 	int len;
 
+	len = of_device_get_modalias(dev, buf, PAGE_SIZE -1);
+	if (len != -ENODEV)
+		return len;
+
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
 	if (len != -ENODEV)
 		return len;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index f685e55..dafb973 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -85,6 +85,9 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 	int cplen, i;
 	ssize_t tsize, csize, repend;
 
+	if ((!dev) || (!dev->of_node))
+		return -ENODEV;
+
 	/* Name & Type */
 	csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
 			 dev->of_node->type);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 82ce324..8d7dd67 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -64,6 +64,12 @@ static inline int of_driver_match_device(struct device *dev,
 static inline void of_device_uevent(struct device *dev,
 			struct kobj_uevent_env *env) { }
 
+static inline int of_device_get_modalias(struct device *dev,
+				   char *str, ssize_t len)
+{
+	return -ENODEV;
+}
+
 static inline int of_device_uevent_modalias(struct device *dev,
 				   struct kobj_uevent_env *env)
 {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
