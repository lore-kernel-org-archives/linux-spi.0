From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 3/3] spi: bcm2835: moved to the spi_transfer transformation to avoid HW restrictions
Date: Mon, 30 Nov 2015 13:04:54 +0000
Message-ID: <1448888695-2260-4-git-send-email-kernel@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448888695-2260-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Moved to the new spi_transfer transformation methods to work arround
the HW restrictions in place arround DMA and alignment or max_length.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   53 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cf04960..67516f7 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -365,38 +365,6 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	if (tfr->len < BCM2835_SPI_DMA_MIN_LENGTH)
 		return false;

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
 	/* return OK */
 	return true;
 }
@@ -598,8 +566,28 @@ static int bcm2835_spi_prepare_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
+	int ret;
+
+	/* apply some spi_transfer transformations */
+
+	/* align transfers on words length - avoiding
+	 * that the scatter/gather list produces transfers
+	 * that are not a multiple of 4
+	 */
+	ret = spi_split_transfers_first_page_len_not_aligned(
+		master, msg, true, 4);
+	if (ret)
+		return ret;
+
+	/* limit the max transfer size to 15 * PAGE_SIZE
+	 * the bcm2835 HW limit is actually 65535, but to avoid
+	 * another set of alignment issues we limit ourselves
+	 */
+	ret = spi_split_transfers_maxsize(master, msg, 15 * PAGE_SIZE);
+	if (ret)
+		return ret;

+	/* setting up clock and data polarity prior to asserting GPIO-cs */
 	cs &= ~(BCM2835_SPI_CS_CPOL | BCM2835_SPI_CS_CPHA);

 	if (spi->mode & SPI_CPOL)
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
