From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH 5/6] spi: bcm2835: add polling mode for transfers below 30us
Date: Sun, 29 Mar 2015 16:03:27 +0200
Message-ID: <808DC596-35BB-4A08-8CF4-DFAB6294636E@martin.sperl.org>
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

In cases of short transfer times the CPU is spending lots of time
in the interrupt handler and scheduler to reschedule the worker thread.

Measurements show that we have times where it takes 29.32us to between
the last clock change and the time that the worker-thread is running again
returning from wait_for_completion_timeout().

During this time the interrupt-handler is running calling complete()
and then also the scheduler is rescheduling the worker thread.

This time can vary depending on how much of the code is still in
CPU-caches, when there is a burst of spi transfers the subsequent delays
are in the order of 25us, so the value of 30us seems reasonable.

With polling the whole transfer of 4 bytes at 10MHz finishes after 6.16us
(CS down to up) with the real transfer (clock running) taking 3.56us.
So the efficiency has much improved and also freeing CPU cycles, reducing
interrupts and context switches.

Because of the above 30us seems to be a reasonable limit for polling.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Tested-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

Applies against topic/bcm2835 and only after patch 3.

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 601fc5e..1d731b8 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,8 @@
 #define BCM2835_SPI_CS_CS_10		0x00000002
 #define BCM2835_SPI_CS_CS_01		0x00000001
 
-#define BCM2835_SPI_TIMEOUT_MS	30000
+#define BCM2835_SPI_TIMEOUT_MS		30000
+#define BCM2835_SPI_POLLING_LIMIT_US	30
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -163,6 +164,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
+	unsigned long spi_used_hz, xfer_time_us, timeout;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);
 
 	/* set clock */
@@ -181,6 +183,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
+	spi_used_hz = (cdiv) ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
 	/* handle all the modes */
@@ -204,6 +207,37 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;
 
+	/* check if we shall run in polling mode */
+	xfer_time_us = tfr->len * 9 * 1000000 / spi_used_hz;
+	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US) {
+		/* enable HW block */
+		bcm2835_wr(bs, BCM2835_SPI_CS,
+			   cs | BCM2835_SPI_CS_TA);
+		/* set timeout to 4x the expected time, or 2 jiffies */
+		timeout = jiffies +
+			max(4 * xfer_time_us * HZ / 1000000, 2uL);
+		/* loop until finished the transfer */
+		while (bs->rx_len) {
+			/* read from fifo as much as possible */
+			bcm2835_rd_fifo(bs);
+			/* fill in tx fifo as much as possible */
+			bcm2835_wr_fifo(bs);
+			/* if we still expect some data after the read,
+			 * check for a possible timeout
+			 */
+			if ((bs->rx_len) && (time_after(jiffies, timeout))) {
+				/* Transfer complete - reset SPI HW */
+				bcm2835_spi_reset_hw(master);
+				/* and return timeout */
+				return -ETIMEDOUT;
+			}
+		}
+		/* Transfer complete - reset SPI HW */
+		bcm2835_spi_reset_hw(master);
+		/* and return without waiting for completion */
+		return 0;
+	}
+
 	/* fill in fifo if we have gpio-cs
 	 * note that there have been rare events where the native-CS
 	 * flapped for <1us which may change the behaviour
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
