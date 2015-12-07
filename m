From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 5/5] spi: bcm2835: split long transfers
Date: Mon,  7 Dec 2015 15:21:48 +0000
Message-ID: <1449501708-2228-6-git-send-email-kernel@martin.sperl.org>
References: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449501708-2228-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Start to use spi_translate_message method when running in
DMA mode and (for now) split spi_transfers with len > 60kB
transparently into multiple transfers using the core method
spi_split_transfers_maxsize.

Eventually the bcm2835_translate_message may get moved into
SPI-core as shared code (when we find the common denominators
for different HW)

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cf04960..03c889d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -353,6 +353,14 @@ static int bcm2835_spi_transfer_one_dma(struct spi_master *master,
 	return 1;
 }

+static int bcm2835_translate_message(struct spi_master *master,
+				     struct spi_message *message)
+{
+	/* translate the message */
+	return spi_split_transfers_maxsize(master, message,
+					   master->max_dma_len);
+}
+
 static bool bcm2835_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *tfr)
@@ -365,19 +373,6 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
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
 	/* if we run rx/tx_buf with word aligned addresses then we are OK */
 	if ((((size_t)tfr->rx_buf & 3) == 0) &&
 	    (((size_t)tfr->tx_buf & 3) == 0))
@@ -461,7 +456,15 @@ static void bcm2835_dma_init(struct spi_master *master, struct device *dev)

 	/* all went well, so set can_dma */
 	master->can_dma = bcm2835_spi_can_dma;
-	master->max_dma_len = 65535; /* limitation by BCM2835_SPI_DLEN */
+
+	/* also set up transform message */
+	master->translate_message = bcm2835_translate_message;
+
+	/* the max_dma_size limited by BCM2835_SPI_DLEN is actually 65535,
+	 * but for al practical purposes we use 15 pages (60k)
+	 */
+	master->max_dma_len = 15 * PAGE_SIZE;
+	master->dma_alignment = 4; /* word alignment is recommended */
 	/* need to do TX AND RX DMA, so we need dummy buffers */
 	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
