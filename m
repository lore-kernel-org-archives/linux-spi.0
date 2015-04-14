From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: remove timeout code from polling function
Date: Tue, 14 Apr 2015 16:39:44 +0000
Message-ID: <1429029590-21799-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The way that the timeout code is written in the polling function
the timeout does also trigger when interrupted/rescheduled while
inside the polling loop.

This removes the code until we have a "better" solution that can also
handle external delays and uses something more exact than jiffies.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   12 ------------
 1 file changed, 12 deletions(-)

This fixes a regression due to the introduction of this polling mode.
See email with detailed observations on the issue.

This patch is an implementation of one of those mentioned options to
fix the issue.

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index f63864a..af29467 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -164,28 +164,16 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 unsigned long xfer_time_us)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	unsigned long timeout = jiffies +
-		max(4 * xfer_time_us * HZ / 1000000, 2uL);
 
 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
 
-	/* set timeout to 4x the expected time, or 2 jiffies */
 	/* loop until finished the transfer */
 	while (bs->rx_len) {
 		/* read from fifo as much as possible */
 		bcm2835_rd_fifo(bs);
 		/* fill in tx fifo as much as possible */
 		bcm2835_wr_fifo(bs);
-		/* if we still expect some data after the read,
-		 * check for a possible timeout
-		 */
-		if (bs->rx_len && time_after(jiffies, timeout)) {
-			/* Transfer complete - reset SPI HW */
-			bcm2835_spi_reset_hw(master);
-			/* and return timeout */
-			return -ETIMEDOUT;
-		}
 	}
 
 	/* Transfer complete - reset SPI HW */
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
