From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: fallback to interrupt for polling timeouts exceeding 2 jiffies
Date: Wed, 22 Apr 2015 07:33:03 +0000
Message-ID: <1429687984-7350-1-git-send-email-kernel@martin.sperl.org>
References: <E9247B42-11B6-4032-A6C1-1FCEA3EDA2A6@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E9247B42-11B6-4032-A6C1-1FCEA3EDA2A6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The polling mode of the driver is designed for transfers that run
less than 30us - it will only execute under those circumstances.
So it should run comfortably without getting interrupted by the
scheduler.

But there are situations where the raspberry pi is so overloaded
that it can take up to 80 jiffies until the polling thread gets
rescheduled - this has been observed especially under heavy
IO situations.

In such a situation we now fall back to the interrupt handler and
log the situation at debug level.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |   87 ++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

Applies against for-next

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 37875cf..830d99c 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -69,7 +69,7 @@
 #define BCM2835_SPI_CS_CS_01		0x00000001
 
 #define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_TIMEOUT_MS		30000
+#define BCM2835_SPI_POLLING_JIFFIES	2
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -157,42 +157,6 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
-					 struct spi_device *spi,
-					 struct spi_transfer *tfr,
-					 u32 cs,
-					 unsigned long xfer_time_us)
-{
-	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	/* set timeout to 1 second of maximum polling */
-	unsigned long timeout = jiffies + HZ;
-
-	/* enable HW block without interrupts */
-	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
-
-	/* loop until finished the transfer */
-	while (bs->rx_len) {
-		/* read from fifo as much as possible */
-		bcm2835_rd_fifo(bs);
-		/* fill in tx fifo as much as possible */
-		bcm2835_wr_fifo(bs);
-		/* if we still expect some data after the read,
-		 * check for a possible timeout
-		 */
-		if (bs->rx_len && time_after(jiffies, timeout)) {
-			/* Transfer complete - reset SPI HW */
-			bcm2835_spi_reset_hw(master);
-			/* and return timeout */
-			return -ETIMEDOUT;
-		}
-	}
-
-	/* Transfer complete - reset SPI HW */
-	bcm2835_spi_reset_hw(master);
-	/* and return without waiting for completion */
-	return 0;
-}
-
 static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 					struct spi_device *spi,
 					struct spi_transfer *tfr,
@@ -229,6 +193,55 @@ static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
 	return 1;
 }
 
+static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
+					 struct spi_device *spi,
+					 struct spi_transfer *tfr,
+					 u32 cs,
+					 unsigned long xfer_time_us)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	unsigned long timeout;
+
+	/* enable HW block without interrupts */
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
+
+	/* fill in the fifo before timeout calculations
+	 * if we are interrupted here, then the data is
+	 * getting transferred by the HW while we are interrupted
+	 */
+	bcm2835_wr_fifo(bs);
+
+	/* set the timeout */
+	timeout = jiffies + BCM2835_SPI_POLLING_JIFFIES;
+
+	/* loop until finished the transfer */
+	while (bs->rx_len) {
+		/* fill in tx fifo with remaining data */
+		bcm2835_wr_fifo(bs);
+
+		/* read from fifo as much as possible */
+		bcm2835_rd_fifo(bs);
+
+		/* if there is still data pending to read
+		 * then check the timeout
+		 */
+		if (bs->rx_len && time_after(jiffies, timeout)) {
+			dev_dbg_ratelimited(&spi->dev,
+					    "timeout period reached: jiffies: %lu remaining tx/rx: %d/%d - falling back to interrupt mode\n",
+					    jiffies - timeout,
+					    bs->tx_len, bs->rx_len);
+			/* fall back to interrupt mode */
+			return bcm2835_spi_transfer_one_irq(master, spi,
+							    tfr, cs);
+		}
+	}
+
+	/* Transfer complete - reset SPI HW */
+	bcm2835_spi_reset_hw(master);
+	/* and return without waiting for completion */
+	return 0;
+}
+
 static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *tfr)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
