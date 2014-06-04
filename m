From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 4/4] spi: sh-msiof: Remove unnecessary platform_set_drvdata()
Date: Wed,  4 Jun 2014 18:17:09 +0400
Message-ID: <1401891429-14271-4-git-send-email-shc_work@mail.ru>
References: <1401891429-14271-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401891429-14271-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Drop call to platform_set_drvdata() as driver data is not used
anywhere in the driver.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 45b0914..83c4370 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -680,8 +680,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	p = spi_master_get_devdata(master);
 
-	platform_set_drvdata(pdev, p);
-
 	of_id = of_match_device(sh_msiof_match, &pdev->dev);
 	if (of_id) {
 		p->chipdata = of_id->data;
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
