From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 7/7] spi: imx: defer spi initialization, if DMA engine is pending
Date: Sun,  1 Nov 2015 15:41:41 +0100
Message-ID: <1446388901-6073-8-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org,
	s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446388901-6073-1-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

If SPI device supports DMA mode, but DMA controller is not yet
available due to e.g. a delay in the corresponding kernel module
initialization, retry to initialize SPI driver later on instead of
falling back into PIO only mode.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6035ddd..d2ea731 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1354,9 +1354,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (is_imx51_ecspi(spi_imx) &&
-	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
-		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
+	if (is_imx51_ecspi(spi_imx)) {
+		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
+		if (ret == -EPROBE_DEFER)
+			goto out_clk_put;
+
+		if (ret < 0)
+			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
+				ret);
+	}
 
 	spi_imx->devtype_data->reset(spi_imx);
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
