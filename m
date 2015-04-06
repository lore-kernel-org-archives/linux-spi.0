From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Mon,  6 Apr 2015 17:16:30 +0000
Message-ID: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

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
So the efficiency has much improved and is also freeing CPU cycles,
reducing interrupts and context switches.

Because of the above 30us seems to be a reasonable limit for polling.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |  112 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 26 deletions(-)

Applies against: spi - for-next

Changelog:
[V1 -> V2]:
  * moved to separate handler functions for polling and interrupt driven
  * added some comments clarifying why we have 9 clocks/byte
  * fixed extra/redundant brackets

Tested with the following setup:
* native CS:
  * mcp2515
  * mmc_spi (patched to make it work on the RPI)
* gpio-CS:
  * mcp2515
  * enc28j60
* gpio-CS with spi-cs-pol:
  * fb_st7735r

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 08e5406..88b808b 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,8 @@
 #define BCM2835_SPI_CS_CS_10		0x00000002
 #define BCM2835_SPI_CS_CS_01		0x00000001

-#define BCM2835_SPI_TIMEOUT_MS	30000
+#define BCM2835_SPI_POLLING_LIMIT_US	30
+#define BCM2835_SPI_TIMEOUT_MS		30000
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)

@@ -156,12 +157,86 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

+static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
+					 struct spi_device *spi,
+					 struct spi_transfer *tfr,
+					 u32 cs,
+					 unsigned long xfer_time_us)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+	unsigned long timeout = jiffies +
+		max(4 * xfer_time_us * HZ / 1000000, 2uL);
+
+	/* enable HW block without interrupts */
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
+
+	/* set timeout to 4x the expected time, or 2 jiffies */
+	/* loop until finished the transfer */
+	while (bs->rx_len) {
+		/* read from fifo as much as possible */
+		bcm2835_rd_fifo(bs);
+		/* fill in tx fifo as much as possible */
+		bcm2835_wr_fifo(bs);
+		/* if we still expect some data after the read,
+		 * check for a possible timeout
+		 */
+		if (bs->rx_len && time_after(jiffies, timeout)) {
+			/* Transfer complete - reset SPI HW */
+			bcm2835_spi_reset_hw(master);
+			/* and return timeout */
+			return -ETIMEDOUT;
+		}
+	}
+
+	/* Transfer complete - reset SPI HW */
+	bcm2835_spi_reset_hw(master);
+	/* and return without waiting for completion */
+	return 0;
+}
+
+static int bcm2835_spi_transfer_one_irq(struct spi_master *master,
+					struct spi_device *spi,
+					struct spi_transfer *tfr,
+					u32 cs)
+{
+	struct bcm2835_spi *bs = spi_master_get_devdata(master);
+
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
+	/*
+	 * Enable the HW block. This will immediately trigger a DONE (TX
+	 * empty) interrupt, upon which we will fill the TX FIFO with the
+	 * first TX bytes. Pre-filling the TX FIFO here to avoid the
+	 * interrupt doesn't work:-(
+	 */
+	cs |= BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
+	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+
+	/* signal that we need to wait for completion */
+	return 1;
+}
+
 static int bcm2835_spi_transfer_one(struct spi_master *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
+	unsigned long spi_used_hz, xfer_time_us;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

 	/* set clock */
@@ -180,6 +255,7 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
+	spi_used_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);

 	/* handle all the modes */
@@ -203,33 +279,17 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;

-	/* fill in fifo if we have gpio-cs
-	 * note that there have been rare events where the native-CS
-	 * flapped for <1us which may change the behaviour
-	 * with gpio-cs this does not happen, so it is implemented
-	 * only for this case
-	 */
-	if (gpio_is_valid(spi->cs_gpio)) {
-		/* enable HW block, but without interrupts enabled
-		 * this would triggern an immediate interrupt
-		 */
-		bcm2835_wr(bs, BCM2835_SPI_CS,
-			   cs | BCM2835_SPI_CS_TA);
-		/* fill in tx fifo as much as possible */
-		bcm2835_wr_fifo(bs);
-	}
+	/* calculate the estimated time in us the transfer runs */
+	xfer_time_us = tfr->len
+		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
+		* 1000000 / spi_used_hz;

-	/*
-	 * Enable the HW block. This will immediately trigger a DONE (TX
-	 * empty) interrupt, upon which we will fill the TX FIFO with the
-	 * first TX bytes. Pre-filling the TX FIFO here to avoid the
-	 * interrupt doesn't work:-(
-	 */
-	cs |= BCM2835_SPI_CS_INTR | BCM2835_SPI_CS_INTD | BCM2835_SPI_CS_TA;
-	bcm2835_wr(bs, BCM2835_SPI_CS, cs);
+	/* for short requests run polling*/
+	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
+		return bcm2835_spi_transfer_one_poll(master, spi, tfr,
+						     cs, xfer_time_us);

-	/* signal that we need to wait for completion */
-	return 1;
+	return bcm2835_spi_transfer_one_irq(master, spi, tfr, cs);
 }

 static void bcm2835_spi_handle_err(struct spi_master *master,
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
