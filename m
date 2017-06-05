From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: davinci: Fix compilation warning.
Date: Mon,  5 Jun 2017 17:44:09 +0530
Message-ID: <b6b0d421633c6ea51cdaf3e582f8bebd2034251c.1496664791.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If CONFIG_OF is disable, it'll through compilation warning.

drivers/spi/spi-davinci.c: In function ‘spi_davinci_get_pdata’:
drivers/spi/spi-davinci.c:880:2: warning: return makes pointer from integer without a cast [enabled by default]
  return -ENODEV;

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 2b0805d..93a4009 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -877,7 +877,7 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	*spi_davinci_get_pdata(struct platform_device *pdev,
 		struct davinci_spi *dspi)
 {
-	return -ENODEV;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
