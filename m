From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Wed, 26 Feb 2014 16:31:19 +0100
Message-ID: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If during registering SPI master due to SPI device probing a SPI transfer
is issued the DMA buffers are not allocated yet.

This fixes the following oops:
pch_spi 0000:02:0c.1: enabling device (0000 -> 0002)
pch_spi 0000:02:0c.1: master is unqueued, this is deprecated
BUG: unable to handle kernel NULL pointer dereference at   (null)
IP: [<c125aa05>] pch_spi_handle_dma+0x15c/0x6f4
[...]

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index c2a3435..f73fb77 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1457,6 +1457,11 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 
 	pch_spi_set_master_mode(master);
 
+	if (use_dma) {
+		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
+		pch_alloc_dma_buf(board_dat, data);
+	}
+
 	ret = spi_register_master(master);
 	if (ret != 0) {
 		dev_err(&plat_dev->dev,
@@ -1464,14 +1469,10 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 		goto err_spi_register_master;
 	}
 
-	if (use_dma) {
-		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
-		pch_alloc_dma_buf(board_dat, data);
-	}
-
 	return 0;
 
 err_spi_register_master:
+	pch_free_dma_buf(board_dat, data);
 	free_irq(board_dat->pdev->irq, data);
 err_request_irq:
 	pch_spi_free_resources(board_dat, data);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
