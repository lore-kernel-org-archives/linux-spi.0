From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: pl022: Fix incorrect dma_unmap_sg
Date: Thu, 9 Oct 2014 11:44:54 -0700
Message-ID: <1412880294-9860-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When mapped RX DMA entries are unmapped in an error condition when DMA
is firstly configured in the driver, the number of TX DMA entries was
passed in, which is incorrect

Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f35f723..fc2dd84 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1106,7 +1106,7 @@ err_rxdesc:
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 err_tx_sgmap:
 	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
+		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 err_rx_sgmap:
 	sg_free_table(&pl022->sgt_tx);
 err_alloc_tx_sg:
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
