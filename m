From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-mxs: Register the irq with the device name
Date: Mon, 10 Nov 2014 17:25:24 -0200
Message-ID: <1415647524-10962-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Instead of registering the irq name with the driver name, it's better to pass
the device name so that we have a more explicit indication as to what spi
instance the irq is related:

$ cat /proc/interrupts 
           CPU0       
...
 27:          0         -  98  80014000.ssp

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 11de319..67af5f0 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -511,7 +511,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	init_completion(&spi->c);
 
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
-			       DRIVER_NAME, ssp);
+			       dev_name(&pdev->dev), ssp);
 	if (ret)
 		goto out_master_free;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
