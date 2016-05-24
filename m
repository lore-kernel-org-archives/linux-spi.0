From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-ep93xx: Fix the PTR_ERR() argument
Date: Mon, 23 May 2016 23:24:21 -0300
Message-ID: <1464056661-7056-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

PTR_ERR should access the value just tested by IS_ERR.

The semantic patch that makes this change is available
in scripts/coccinelle/tests/odd_ptr_err.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index bb00be8..17a6387 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -567,7 +567,7 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
 	txd = ep93xx_spi_dma_prepare(espi, DMA_MEM_TO_DEV);
 	if (IS_ERR(txd)) {
 		ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
-		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(rxd));
+		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		msg->status = PTR_ERR(txd);
 		return;
 	}
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
