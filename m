From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: sh-msiof: Use dev_warn_once() instead of open-coding
Date: Thu, 30 Nov 2017 14:38:50 +0100
Message-ID: <1512049130-20170-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the helper introduced by commit e135303bd5bebcd2 ("device: Add
dev_<level>_once variants") instead of open-coding the same
functionality.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fcd261f98b9fd921..81a9144f5442cdb4 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -912,9 +912,8 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 
 		ret = sh_msiof_dma_once(p, tx_buf, rx_buf, l);
 		if (ret == -EAGAIN) {
-			pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
-				     dev_driver_string(&p->pdev->dev),
-				     dev_name(&p->pdev->dev));
+			dev_warn_once(&p->pdev->dev,
+				"DMA not available, falling back to PIO\n");
 			break;
 		}
 		if (ret)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
