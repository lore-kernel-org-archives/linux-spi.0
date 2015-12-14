From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 8/8] spi: bcm2835: move to spi-core methods translate_message and can_dma
Date: Mon, 14 Dec 2015 15:20:25 +0000
Message-ID: <1450106426-2277-9-git-send-email-kernel@martin.sperl.org>
References: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106426-2277-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Remove all limitations in can_dma that inhibit the use of DMA

To meet the limitiations of the HW we are now using the standardized
version of spi_translate_message, that:
* splits long transfers (> 60k)
* aligns transfers (on 4 byte boundary)
* merges transfers (for optimizations)

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   58 +++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

Changelog:
  V1 -> V3: move to use spi-core methods where possible

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cf04960..75e4425 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -361,44 +361,8 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	if (!gpio_is_valid(spi->cs_gpio))
 		return false;

-	/* we start DMA efforts only on bigger transfers */
-	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
-		return false;
-
-	/* BCM2835_SPI_DLEN has defined a max transfer size as
-	 * 16 bit, so max is 65535
-	 * we can revisit this by using an alternative transfer
-	 * method - ideally this would get done without any more
-	 * interaction...
-	 */
-	if (tfr->len > 65535) {
-		dev_warn_once(&spi->dev,
-			      "transfer size of %d too big for dma-transfer\n",
-			      tfr->len);
-		return false;
-	}
-
-	/* if we run rx/tx_buf with word aligned addresses then we are OK */
-	if ((((size_t)tfr->rx_buf & 3) == 0) &&
-	    (((size_t)tfr->tx_buf & 3) == 0))
-		return true;
-
-	/* otherwise we only allow transfers within the same page
-	 * to avoid wasting time on dma_mapping when it is not practical
-	 */
-	if (((size_t)tfr->tx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
-		dev_warn_once(&spi->dev,
-			      "Unaligned spi tx-transfer bridging page\n");
-		return false;
-	}
-	if (((size_t)tfr->rx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
-		dev_warn_once(&spi->dev,
-			      "Unaligned spi rx-transfer bridging page\n");
-		return false;
-	}
-
-	/* return OK */
-	return true;
+	/* use the default implementation */
+	return spi_can_dma_min_dma_len(master, spi, tfr);
 }

 static void bcm2835_dma_release(struct spi_master *master)
@@ -461,7 +425,23 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)

 	/* all went well, so set can_dma */
 	master->can_dma = bcm2835_spi_can_dma;
-	master->max_dma_len = 65535; /* limitation by BCM2835_SPI_DLEN */
+
+	/* set up transform message using the default implementation
+	 * for size, alignment and merging transfers
+	 */
+	master->translate_message = spi_translate_message_size_align_merge;
+
+	/* the minimum length when we run DMA */
+	master->min_dma_len = BCM2835_SPI_DMA_MIN_LENGTH;
+
+	/* the max_dma_len limited by BCM2835_SPI_DLEN is actually 65535,
+	 * but for al practical purposes we use 15 pages (60k)
+	 */
+	master->max_dma_len = 15 * PAGE_SIZE;
+
+	/* dma alignment is 4 bytes */
+	master->dma_alignment = 4;
+
 	/* need to do TX AND RX DMA, so we need dummy buffers */
 	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
