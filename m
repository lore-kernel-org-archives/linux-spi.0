From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 1/2] spi: Use PM ops instead of legacy suspend/resume
Date: Sun,  8 Mar 2015 14:56:37 +0100
Message-ID: <1425822998-30487-1-git-send-email-lars@metafoo.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

New drivers should use PM ops instead of the legacy suspend/resume
callbacks. Update the SPI device driver guide to reflect this.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 Documentation/spi/spi-summary | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index d29734b..d1824b3 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -342,12 +342,11 @@ SPI protocol drivers somewhat resemble platform device drivers:
 		.driver = {
 			.name		= "CHIP",
 			.owner		= THIS_MODULE,
+			.pm		= &CHIP_pm_ops,
 		},
 
 		.probe		= CHIP_probe,
 		.remove		= CHIP_remove,
-		.suspend	= CHIP_suspend,
-		.resume		= CHIP_resume,
 	};
 
 The driver core will automatically attempt to bind this driver to any SPI
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
