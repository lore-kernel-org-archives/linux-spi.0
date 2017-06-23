From: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 7/8] spi: stm32: enhance DMA error management
Date: Fri, 23 Jun 2017 14:55:49 +0200
Message-ID: <1498222550-19092-8-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch reworks DMA error management. In case the DMA callback is
called while EOT (End Of Transfer) flag is not set, that means that DMA
encountered an error. This error will result in an auto-suspend of SPI
flow, which could also result in an overrun. So, in DMA mode, SUSP and
OVR flags are a condition to stop the current transfer.

Signed-off-by: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-stm32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 209afda..63af9d9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -514,6 +514,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If communication is suspended while using DMA, it means
+		 * that something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_MODF) {
@@ -525,6 +531,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
+		/*
+		 * If overrun is detected while using DMA, it means that
+		 * something went wrong, so stop the current transfer
+		 */
+		if (spi->cur_usedma)
+			end = true;
 	}
 
 	if (sr & SPI_SR_EOT) {
@@ -645,12 +657,10 @@ static void stm32_spi_dma_cb(void *data)
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	if (!(sr & SPI_SR_EOT)) {
-		dev_warn(spi->dev, "DMA callback (sr=0x%08x)\n", sr);
+	if (!(sr & SPI_SR_EOT))
+		dev_warn(spi->dev, "DMA error (sr=0x%08x)\n", sr);
 
-		spi_finalize_current_transfer(spi->master);
-		stm32_spi_disable(spi);
-	}
+	/* Now wait for EOT, or SUSP or OVR in case of error */
 }
 
 /**
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
