From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: spi-imx: Propagate the real error code on platform_get_irq() failure
Date: Fri, 14 Feb 2014 01:19:22 -0200
Message-ID: <1392347962-9835-2-git-send-email-festevam@gmail.com>
References: <1392347962-9835-1-git-send-email-festevam@gmail.com>
Cc: marex-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392347962-9835-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

No need to return a 'fake' return value on platform_get_irq() failure.

Just return the error code itself instead.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 2ccfde6..3577939 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -879,7 +879,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->irq = platform_get_irq(pdev, 0);
 	if (spi_imx->irq < 0) {
-		ret = -EINVAL;
+		ret = spi_imx->irq;
 		goto out_master_put;
 	}
 
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
