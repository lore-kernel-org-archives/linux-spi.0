From: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Subject: [PATCH 3/3] spi: qup: Remove .owner field for driver
Date: Thu,  9 Oct 2014 13:12:08 +0530
Message-ID: <1412840528-31508-1-git-send-email-kiran.padwal@smartplayin.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superfluous .owner field for drivers which
use the module_platform_driver API, as this is overridden in
platform_driver_register anyway."

Signed-off-by: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
---
 drivers/spi/spi-qup.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 97471e1..30511bd 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -758,7 +758,6 @@ static const struct dev_pm_ops spi_qup_dev_pm_ops = {
 static struct platform_driver spi_qup_driver = {
 	.driver = {
 		.name		= "spi_qup",
-		.owner		= THIS_MODULE,
 		.pm		= &spi_qup_dev_pm_ops,
 		.of_match_table = spi_qup_dt_match,
 	},
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
