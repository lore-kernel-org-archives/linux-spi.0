From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 5/6] spi: davinci: do not use DMA if transfer length is less than 16
Date: Fri, 17 Feb 2017 11:38:23 +0100
Message-ID: <1487327904-28311-6-git-send-email-fisaksen@baylibre.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487327904-28311-1-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Higher bitrate and lower CPU load if using PIO in this case.

Signed-off-by: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b69a370..826bff1 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -110,6 +110,8 @@
 #define SPIDEF		0x4c
 #define SPIFMT0		0x50
 
+#define DMA_MIN_BYTES	16
+
 /* SPI Controller driver's private data. */
 struct davinci_spi {
 	struct spi_bitbang	bitbang;
@@ -483,7 +485,7 @@ static bool davinci_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
-	return __davinci_spi_can_dma(spi);
+	return __davinci_spi_can_dma(spi) && (xfer->len >= DMA_MIN_BYTES);
 }
 
 static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
@@ -622,10 +624,9 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	reinit_completion(&dspi->done);
 
-	if (spicfg->io_type == SPI_IO_TYPE_INTR)
-		set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
-
-	if (spicfg->io_type != SPI_IO_TYPE_DMA) {
+	if (!davinci_spi_can_dma(spi->master, spi, t)) {
+		if (spicfg->io_type != SPI_IO_TYPE_POLL)
+			set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
 		/* start the transfer */
 		dspi->wcount--;
 		tx_data = dspi->get_tx(dspi);
@@ -706,7 +707,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
+	if (davinci_spi_can_dma(spi->master, spi, t)) {
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 		if (is_vmalloc_addr(t->rx_buf))
 			/* VIVT cache: invalidate since addr. may be aliased */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
