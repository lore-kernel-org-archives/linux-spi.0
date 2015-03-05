From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [RESENT PATCH] spi: xilinx: Use standard num-cs binding
Date: Thu,  5 Mar 2015 14:10:30 +0100
Message-ID: <1777fd49a103237c7ac0ebca434b33509e1b843f.1425561027.git.michal.simek@xilinx.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use standard num-cs binding property and setup
"xlnx,num-ss-bits" as deprecated.

Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---

 drivers/spi/spi-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 133f53a9c1d4..69313407b690 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -374,8 +374,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		num_cs = pdata->num_chipselect;
 		bits_per_word = pdata->bits_per_word;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
+		if (of_property_read_u32(pdev->dev.of_node, "num-cs",
+					 &num_cs)) {
+			if (!of_property_read_u32(pdev->dev.of_node,
+						  "xlnx,num-ss-bits",
+						  &num_cs)) {
+				dev_err(&pdev->dev,
+					"property name 'xlnx,num-ss-bits' is deprecated.\n");
+			}
+		}
 	}
 
 	if (!num_cs) {
-- 
1.8.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
