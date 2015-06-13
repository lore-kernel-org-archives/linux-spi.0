From: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] spi: spi-pxa2xx: Constify ACPI device ids
Date: Sat, 13 Jun 2015 14:22:14 +0200
Message-ID: <1434198134-8278-1-git-send-email-minipli@googlemail.com>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Constify the ACPI device ID array, it doesn't need to be writable at
runtime.

Signed-off-by: Mathias Krause <minipli-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
---
This patch should go on top of spi.git#topic/pxa

 drivers/spi/spi-pxa2xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f97cd42fbc22..7293d6d875c5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1265,7 +1265,7 @@ static void cleanup(struct spi_device *spi)
 
 #ifdef CONFIG_ACPI
 
-static struct acpi_device_id pxa2xx_spi_acpi_match[] = {
+static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "INT33C0", LPSS_LPT_SSP },
 	{ "INT33C1", LPSS_LPT_SSP },
 	{ "INT3430", LPSS_LPT_SSP },
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
