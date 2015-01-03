From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: sirf: drop redundant sirf,marco-spi compatible string
Date: Sat,  3 Jan 2015 17:04:44 +0800
Message-ID: <1420275884-10942-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

"sirf,marco-spi" is redundant as all SPI controllers in CSR SiRFSoC are
compatible with prima2-spi.
at the same time, the whole marco project was dropped and its replacement
atlas7 is also compatible with prima2 in SPI.

Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index d075191..f5715c9 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -818,7 +818,6 @@ static SIMPLE_DEV_PM_OPS(spi_sirfsoc_pm_ops, spi_sirfsoc_suspend,
 
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", },
-	{ .compatible = "sirf,marco-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_sirfsoc_of_match);
-- 
2.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
