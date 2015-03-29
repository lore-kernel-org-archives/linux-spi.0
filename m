From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts to
Date: Sun, 29 Mar 2015 16:03:25 +0200
Message-ID: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 reduce interrupts/message

To reduce the number of interrupts/message we fill the FIFO before
enabling interrupts - for short messages this reduces the interrupt count
from 2 to 1 interrupt.

There have been rare cases where short (<200ns) chip-select switches with
native CS have been observed during such operation, this is why this
optimization is only enabled for GPIO-CS.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Applies against spi - topic/bcm2835

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 72d4525..adf157b 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -203,6 +203,22 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;
 
+	/* fill in fifo if we have gpio-cs
+	 * note that there have been rare events where the native-CS
+	 * flapped for <1us which may change the behaviour
+	 * with gpio-cs this does not happen, so it is implemented
+	 * only for this case
+	 */
+	if (gpio_is_valid(spi->cs_gpio)) {
+		/* enable HW block, but without interrupts enabled
+		 * this would triggern an immediate interrupt
+		 */
+		bcm2835_wr(bs, BCM2835_SPI_CS,
+			   cs | BCM2835_SPI_CS_TA);
+		/* fill in tx fifo as much as possible */
+		bcm2835_wr_fifo(bs);
+	}
+
 	/*
 	 * Enable the HW block. This will immediately trigger a DONE (TX
 	 * empty) interrupt, upon which we will fill the TX FIFO with the
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
