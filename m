From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: BUG: fix wrong use of PAGE_MASK
Date: Thu, 10 Sep 2015 09:32:14 +0000
Message-ID: <1441877535-2218-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert-X6yZ70khizulP80pJB477g@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

There is a bug in the alignment checking of transfers,
that results in DMA not being used for un-aligned
transfers that do not cross page-boundries, which is valid.

This is due to a missconception of the meaning PAGE_MASK
when implementing that check originally - (PAGE_SIZE - 1) 
should have been used instead.

Also fixes a copy/paste error.

Reported-by: <robert-X6yZ70khizulP80pJB477g@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 59705ab..ed74786 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -386,14 +386,14 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	/* otherwise we only allow transfers within the same page
 	 * to avoid wasting time on dma_mapping when it is not practical
 	 */
-	if (((size_t)tfr->tx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
+	if (((size_t)tfr->tx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
 			      "Unaligned spi tx-transfer bridging page\n");
 		return false;
 	}
-	if (((size_t)tfr->rx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
+	if (((size_t)tfr->rx_buf & (PAGE_SIZE - 1)) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
-			      "Unaligned spi tx-transfer bridging page\n");
+			      "Unaligned spi rx-transfer bridging page\n");
 		return false;
 	}
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
