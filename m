From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv3 1/3] ACPI: Provide struct acpi_device stub for !CONFIG_ACPI builds
Date: Thu, 14 Nov 2013 11:00:59 +0200
Message-ID: <1384419661-28293-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384419661-28293-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We have a few cases where we want to access struct device dev field in
struct acpi_device from generic code that is build also without CONFIG_ACPI.

Provide here a minimal struct acpi_device stub that allows to build such a
code without adding new #ifdef CONFIG_ACPI churn. This should not increase
section sizes if code is protected by ACPI_COMPANION() runtime checks as
those will be optimized out by later compiler stages in case CONFIG_ACPI is
not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Rafael, instead of this we could also have an accessor but adev->dev looked
better in actual code and size vmlinux didn't change for x86_64_defconfig
with CONFIG_ACPI is not set nor for omap2plus_defconfig.
---
 include/linux/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0da49ed..df444e1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -414,6 +414,10 @@ static inline bool acpi_driver_match_device(struct device *dev,
 
 #else	/* !CONFIG_ACPI */
 
+struct acpi_device {
+	struct device dev;
+};
+
 #define acpi_disabled 1
 
 #define ACPI_COMPANION(dev)		(NULL)
-- 
1.8.4.2
