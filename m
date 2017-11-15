From: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [RFC PATCH 2/2] spi: atmel: Fix DMA transfers data corruption
Date: Wed, 15 Nov 2017 18:35:32 +0200
Message-ID: <1510763732-10151-3-git-send-email-radu.pirea@microchip.com>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510763732-10151-1-git-send-email-radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If the cache model is VIVT, DMA data transfers may not be valid and to
ensure the validity of the data cache must be flushed and invalidated.

Signed-off-by: Radu Pirea <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 4e5e51f..cda6d0f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -21,6 +21,8 @@
 #include <linux/slab.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <linux/of.h>
+#include <asm/cacheflush.h>
+#include <asm/cachetype.h>
 
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -742,6 +744,18 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 				       xfer->bits_per_word))
 		goto err_exit;
 
+#ifdef CONFIG_SOC_SAM_V4_V5
+	/*
+	 * On Atmel SoCs based on ARM9 cores, the data cache follows the VIVT
+	 * model, hence the cache aliases issue can occur when buffers are
+	 * allocated from DMA-unsafe areas, by vmalloc() for instance, where
+	 * cache coherency is not taken into account or at least not handled
+	 * completely (cache lines of aliases are not flushed and invalidated).
+	 * This is not a theorical issue: it was reproduced when trying to mount
+	 * a UBI file-system on a at91sam9g35ek board.
+	 */
+	flush_kernel_vmap_range((void *)xfer->rx_buf, xfer->len);
+#endif
 	/* Send both scatterlists */
 	rxdesc = dmaengine_prep_slave_sg(rxchan,
 					 xfer->rx_sg.sgl, xfer->rx_sg.nents,
@@ -750,6 +764,9 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	if (!rxdesc)
 		goto err_dma;
 
+#ifdef CONFIG_SOC_SAM_V4_V5
+	flush_kernel_vmap_range((void *)xfer->tx_buf, xfer->len);
+#endif
 	txdesc = dmaengine_prep_slave_sg(txchan,
 					 xfer->tx_sg.sgl, xfer->tx_sg.nents,
 					 DMA_TO_DEVICE,
@@ -779,6 +796,9 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_master *master,
 	rxchan->device->device_issue_pending(rxchan);
 	txchan->device->device_issue_pending(txchan);
 
+#ifdef CONFIG_SOC_SAM_V4_V5
+	invalidate_kernel_vmap_range((void *)xfer->rx_buf, xfer->len);
+#endif
 	/* take back lock */
 	atmel_spi_lock(as);
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
