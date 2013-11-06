From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: Staticize spi_dev_set_name()
Date: Wed,  6 Nov 2013 21:11:25 +0200
Message-ID: <1383765085-31224-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

[Jarkko: I forgot to mark spi_dev_set_name() static in
"spi: Use stable dev_name for ACPI enumerated SPI slaves"]
Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3a6d157..d720d2b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -352,7 +352,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
-void spi_dev_set_name(struct spi_device *spi)
+static void spi_dev_set_name(struct spi_device *spi)
 {
 	if (ACPI_HANDLE(&spi->dev)) {
 		struct acpi_device *adev;
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
