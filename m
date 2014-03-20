From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: fsl-lib: Fix memory leak of pinfo
Date: Thu, 20 Mar 2014 17:20:17 +0800
Message-ID: <1395307217.9142.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

of_mpc8xxx_spi_probe() allocates memory for pinfo but the memory is not freed
anywhere. of_mpc8xxx_spi_probe() is called in .probe() and pinfo should be
freed in .remove(), so convert kzalloc to devm_kzalloc to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-fsl-lib.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 0b75f26..e5d45fc 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -200,7 +200,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	const void *prop;
 	int ret = -ENOMEM;
 
-	pinfo = kzalloc(sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
@@ -215,15 +215,13 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	pdata->sysclk = get_brgfreq();
 	if (pdata->sysclk == -1) {
 		pdata->sysclk = fsl_get_sys_freq();
-		if (pdata->sysclk == -1) {
-			ret = -ENODEV;
-			goto err;
-		}
+		if (pdata->sysclk == -1)
+			return -ENODEV;
 	}
 #else
 	ret = of_property_read_u32(np, "clock-frequency", &pdata->sysclk);
 	if (ret)
-		goto err;
+		return ret;
 #endif
 
 	prop = of_get_property(np, "mode", NULL);
@@ -237,8 +235,4 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 		pdata->flags = SPI_CPM_MODE | SPI_CPM1;
 
 	return 0;
-
-err:
-	kfree(pinfo);
-	return ret;
 }
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
