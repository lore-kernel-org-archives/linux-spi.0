From: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Wed, 13 Jul 2016 14:53:41 +0300
Message-ID: <4b9ea75003d78406307cbb392150fb038b1b72f7.1468409668.git.leonard.crestez@intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1468409668.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1468409668.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
References: <cover.1468409668.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When using devicetree i2c_board_info.type is set to the compatible
string with the vendor prefix removed. For I2C devices described via
ACPI the i2c_board_info.type string is set to the ACPI device name. When
using ACPI and DT ids this string ends up something like "PRP0001:00".

If the of_compatible property is present try to use that instead. This
makes it easier to instantiate i2c drivers through ACPI with DT ids.

Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 74e5aea..62a1339 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -179,7 +179,13 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
+	if (adev->data.of_compatible) {
+		ret = acpi_of_modalias(adev, info->type, sizeof(info->type));
+		if (ret)
+			return -EINVAL;
+	} else {
+		strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
+	}
 
 	return 0;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
