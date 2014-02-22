From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] spi: imx: Use dev_name() for request_irq() to distinguish SPIs
Date: Sat, 22 Feb 2014 17:23:46 +0400
Message-ID: <1393075426-20882-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3577939..bcb603c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -884,7 +884,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, spi_imx->irq, spi_imx_isr, 0,
-			       DRIVER_NAME, spi_imx);
+			       dev_name(&pdev->dev), spi_imx);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", spi_imx->irq, ret);
 		goto out_master_put;
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
