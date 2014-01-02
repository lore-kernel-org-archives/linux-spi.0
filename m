From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: s3c64xx: Remove duplicate code to clear
 S3C64XX_SPI_SLAVE_SEL register
Date: Thu, 02 Jan 2014 20:19:02 +0800
Message-ID: <1388665142.538.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 4c4b0a1..b4ea930 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -927,9 +927,6 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	/* Start the signals */
 	writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
-	/* Start the signals */
-	writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
-
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
 	status = wait_for_xfer(sdd, xfer, use_dma);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
