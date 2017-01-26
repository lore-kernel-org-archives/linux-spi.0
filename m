From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] spi: mediatek: Only do dma for 4-byte aligned buffers
Date: Fri, 27 Jan 2017 00:21:54 +0800
Message-ID: <20170126162154.124287-2-djkurtz@chromium.org>
References: <20170126162154.124287-1-djkurtz@chromium.org>
Cc: dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>,
        Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list),
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated list:ARM/Mediatek SoC
        support)
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170126162154.124287-1-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mediatek SPI DMA only works when tx and rx buffer addresses are 4-byte
aligned.

Unaligned DMA transactions appeared to work previously, since we the
spi core was incorrectly using the spi_master device for dma, which
had a 0 dma_mask, and therefore the swiotlb dma map operations were
falling back to using bounce buffers.  Since each DMA transaction would
use its own buffer, the mapped starting address of each transaction was
always aligned.  When doing real DMA, the mapped address will share the
alignment of the raw tx/rx buffer provided by the SPI user, which may or
may not be aligned.

If a buffer is not aligned, we cannot use DMA, and must use FIFO based
transaction instead.

So, this patch implements a scheme that allows using the FIFO for
arbitrary length transactions (larger than the 32-byte FIFO size) by
reloading the FIFO in the interrupt handler.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 899d7a8f0889..4b592fc25194 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -73,7 +73,7 @@
 #define MTK_SPI_IDLE 0
 #define MTK_SPI_PAUSED 1
 
-#define MTK_SPI_MAX_FIFO_SIZE 32
+#define MTK_SPI_MAX_FIFO_SIZE 32U
 #define MTK_SPI_PACKET_SIZE 1024
 
 struct mtk_spi_compatible {
@@ -333,7 +333,7 @@ static int mtk_spi_fifo_transfer(struct spi_master *master,
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	mdata->cur_transfer = xfer;
-	mdata->xfer_len = xfer->len;
+	mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, xfer->len);
 	mtk_spi_prepare_transfer(master, xfer);
 	mtk_spi_setup_packet(master);
 
@@ -410,7 +410,10 @@ static bool mtk_spi_can_dma(struct spi_master *master,
 			    struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
-	return xfer->len > MTK_SPI_MAX_FIFO_SIZE;
+	/* Buffers for DMA transactions must be 4-byte aligned */
+	return (xfer->len > MTK_SPI_MAX_FIFO_SIZE &&
+		(unsigned long)xfer->tx_buf % 4 == 0 &&
+		(unsigned long)xfer->rx_buf % 4 == 0);
 }
 
 static int mtk_spi_setup(struct spi_device *spi)
@@ -451,7 +454,33 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 					&reg_val, remainder);
 			}
 		}
-		spi_finalize_current_transfer(master);
+
+		trans->len -= mdata->xfer_len;
+		if (!trans->len) {
+			spi_finalize_current_transfer(master);
+			return IRQ_HANDLED;
+		}
+
+		if (trans->tx_buf)
+			trans->tx_buf += mdata->xfer_len;
+		if (trans->rx_buf)
+			trans->rx_buf += mdata->xfer_len;
+
+		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, trans->len);
+		mtk_spi_setup_packet(master);
+
+		cnt = trans->len / 4;
+		iowrite32_rep(mdata->base + SPI_TX_DATA_REG, trans->tx_buf, cnt);
+
+		remainder = trans->len % 4;
+		if (remainder > 0) {
+			reg_val = 0;
+			memcpy(&reg_val, trans->tx_buf + (cnt * 4), remainder);
+			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+		}
+
+		mtk_spi_enable_transfer(master);
+
 		return IRQ_HANDLED;
 	}
 
-- 
2.11.0.483.g087da7b7c-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
