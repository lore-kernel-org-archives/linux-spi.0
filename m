From: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2] spi: deal with a compile warning
Date: Thu, 26 Jun 2014 11:26:43 +0800
Message-ID: <1403753203-13473-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

ret is unused when CONFIG_FSL_SOC defined,
so return ret instead of -ENOMEM when the
kzalloc fails to avoid it.

Signed-off-by: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
Changes for v2:
	-return ret instead of -ENOMEM when the kzalloc fails 

 drivers/spi/spi-fsl-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e5d45fc..d40378f 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -202,7 +202,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 
 	pinfo = devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
-		return -ENOMEM;
+		return ret;
 
 	pdata = &pinfo->pdata;
 	dev->platform_data = pdata;
-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
