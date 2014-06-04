From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/4] spi: falcon: Remove unnecessary platform_set_drvdata()
Date: Wed,  4 Jun 2014 18:17:07 +0400
Message-ID: <1401891429-14271-2-git-send-email-shc_work@mail.ru>
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
 drivers/spi/spi-falcon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index ba441ad..f73b300 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -425,8 +425,6 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = falcon_sflash_unprepare_xfer;
 	master->dev.of_node = pdev->dev.of_node;
 
-	platform_set_drvdata(pdev, priv);
-
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret)
 		spi_master_put(master);
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
