From: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 2/3] i2c: acpi: Initialize info.type from of_compatible
Date: Sat,  4 Feb 2017 08:00:27 +0000
Message-ID: <1486195228-10929-3-git-send-email-dan@emutex.com>
References: <1485523815-9629-1-git-send-email-dan@emutex.com>
 <1486195228-10929-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486195228-10929-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When using devicetree i2c_board_info.type is set to the compatible
string with the vendor prefix removed. For I2C devices described via
ACPI the i2c_board_info.type string is set to the ACPI device name. When
using ACPI and DT ids this string ends up something like "PRP0001:00".

If the of_compatible property is present try to use that instead. This
makes it easier to instantiate i2c drivers through ACPI with DT ids.

Signed-off-by: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 583e950..28d2181 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -221,7 +221,8 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
+	acpi_set_modalias(adev, dev_name(&adev->dev),
+			  info->type, sizeof(info->type));
 
 	return 0;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
