From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/2] [RFC] spi: sh-msiof: Handle dmaengine_prep_slave_single() failures gracefully
Date: Wed,  9 Jul 2014 12:26:23 +0200
Message-ID: <1404901583-31366-2-git-send-email-geert+renesas@glider.be>
References: <1404901583-31366-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404901583-31366-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

As typically a shmobile SoC has less DMA channels than devices that can use
DMA, we may want to prioritize access to the DMA channels in the future.
This means that dmaengine_prep_slave_single() may start failing
arbitrarily.

Handle dmaengine_prep_slave_single() failures gracefully by falling back to
PIO. This requires moving DMA-specific configuration of the MSIOF device
after the call(s) to dmaengine_prep_slave_single().

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 4f0f1cbc92ef..2d7c45bbb6f3 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -636,12 +636,6 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	dma_cookie_t cookie;
 	int ret;
 
-	/* 1 stage FIFO watermarks for DMA */
-	sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
-
-	/* setup msiof transfer mode registers (32-bit words) */
-	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
-
 	if (tx) {
 		ier_bits |= IER_TDREQE | IER_TDMAE;
 		dma_sync_single_for_device(&p->pdev->dev, p->tx_dma_addr, len,
@@ -650,7 +644,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 					p->tx_dma_addr, len, DMA_TO_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			return -EIO;
+			return -EAGAIN;
 	}
 
 	if (rx) {
@@ -659,8 +653,15 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 					p->rx_dma_addr, len, DMA_FROM_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
-			return -EIO;
+			return -EAGAIN;
 	}
+
+	/* 1 stage FIFO watermarks for DMA */
+	sh_msiof_write(p, FCTR, FCTR_TFWM_1 | FCTR_RFWM_1);
+
+	/* setup msiof transfer mode registers (32-bit words) */
+	sh_msiof_spi_set_mode_regs(p, tx, rx, 32, len / 4);
+
 	sh_msiof_write(p, IER, ier_bits);
 
 	reinit_completion(&p->done);
@@ -822,6 +823,12 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 			copy32(p->tx_dma_page, tx_buf, l / 4);
 
 		ret = sh_msiof_dma_once(p, tx_buf, rx_buf, l);
+		if (ret == -EAGAIN) {
+			pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
+				     dev_driver_string(&p->pdev->dev),
+				     dev_name(&p->pdev->dev));
+			break;
+		}
 		if (ret)
 			return ret;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
