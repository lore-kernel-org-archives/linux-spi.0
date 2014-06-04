From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 1/4] spi: clps711x: Remove unnecessary platform_set_drvdata()
Date: Wed,  4 Jun 2014 18:17:06 +0400
Message-ID: <1401891429-14271-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Drop call to platform_set_drvdata() as driver data is not used
anywhere in the driver.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 4cd62f6..ce538da 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -184,8 +184,6 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	}
 	master->max_speed_hz = clk_get_rate(hw->spi_clk);
 
-	platform_set_drvdata(pdev, master);
-
 	hw->syscon = syscon_regmap_lookup_by_pdevname("syscon.3");
 	if (IS_ERR(hw->syscon)) {
 		ret = PTR_ERR(hw->syscon);
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
