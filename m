From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 3/4] spi: omap-100k: Remove unnecessary platform_set_drvdata()
Date: Wed,  4 Jun 2014 18:17:08 +0400
Message-ID: <1401891429-14271-3-git-send-email-shc_work@mail.ru>
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
 drivers/spi/spi-omap-100k.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index e7ffcde..5e91858 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -420,8 +420,6 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	master->min_speed_hz = OMAP1_SPI100K_MAX_FREQ/(1<<16);
 	master->max_speed_hz = OMAP1_SPI100K_MAX_FREQ;
 
-	platform_set_drvdata(pdev, master);
-
 	spi100k = spi_master_get_devdata(master);
 
 	/*
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
