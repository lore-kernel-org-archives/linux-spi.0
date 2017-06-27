From: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: [PATCHv2 8/9] spi: stm32: fix potential dereference null return value
Date: Tue, 27 Jun 2017 17:45:20 +0200
Message-ID: <1498578321-13980-9-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the usage of rx_dma_desc and tx_dma_desc pointers
returned by dmaengine_prep_slave_sg, which can be null.

Detected by CoverityScan, CID#1446587 ("Dereference null return value")

Reported-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-stm32.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index fdbc648..bee74e3 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -775,9 +775,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->rx_sg.nents,
 					rx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		rx_dma_desc->callback = stm32_spi_dma_cb;
-		rx_dma_desc->callback_param = spi;
 	}
 
 	tx_dma_desc = NULL;
@@ -790,11 +787,6 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					xfer->tx_sg.nents,
 					tx_dma_conf.direction,
 					DMA_PREP_INTERRUPT);
-
-		if (spi->cur_comm == SPI_SIMPLEX_TX) {
-			tx_dma_desc->callback = stm32_spi_dma_cb;
-			tx_dma_desc->callback_param = spi;
-		}
 	}
 
 	if ((spi->tx_buf && !tx_dma_desc) ||
@@ -802,6 +794,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
+		rx_dma_desc->callback = stm32_spi_dma_cb;
+		rx_dma_desc->callback_param = spi;
+
 		if (dma_submit_error(dmaengine_submit(rx_dma_desc))) {
 			dev_err(spi->dev, "Rx DMA submit failed\n");
 			goto dma_desc_error;
@@ -811,6 +806,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	if (tx_dma_desc) {
+		if (spi->cur_comm == SPI_SIMPLEX_TX) {
+			tx_dma_desc->callback = stm32_spi_dma_cb;
+			tx_dma_desc->callback_param = spi;
+		}
+
 		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
 			dev_err(spi->dev, "Tx DMA submit failed\n");
 			goto dma_submit_error;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
