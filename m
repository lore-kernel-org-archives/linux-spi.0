From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [RFC PATCH v2 03/12] spi: spi-ep93xx: absorb the interrupt enable/disable helpers
Date: Fri, 28 Jul 2017 10:03:13 +1200
Message-ID: <20170727220322.26654-4-chris.packham@alliedtelesis.co.nz>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>

These are each only called once. Just absorb them into the callers.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index dd179f3fbeeb..e8f454b55b69 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -111,24 +111,6 @@ struct ep93xx_spi {
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
-static void ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
-{
-	unsigned int val;
-
-	val = readl(espi->mmio + SSPCR1);
-	val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	writel(val, espi->mmio + SSPCR1);
-}
-
-static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
-{
-	unsigned int val;
-
-	val = readl(espi->mmio + SSPCR1);
-	val &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	writel(val, espi->mmio + SSPCR1);
-}
-
 /**
  * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
  * @espi: ep93xx SPI controller struct
@@ -282,7 +264,12 @@ static void ep93xx_spi_pio_transfer(struct ep93xx_spi *espi)
 	 * FIFO, enable interrupts, and wait for the transfer to complete.
 	 */
 	if (ep93xx_spi_read_write(espi)) {
-		ep93xx_spi_enable_interrupts(espi);
+		unsigned int val;
+
+		val = readl(espi->mmio + SSPCR1);
+		val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
+		writel(val, espi->mmio + SSPCR1);
+
 		wait_for_completion(&espi->wait);
 	}
 }
@@ -604,6 +591,7 @@ static int ep93xx_spi_transfer_one_message(struct spi_master *master,
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 {
 	struct ep93xx_spi *espi = dev_id;
+	unsigned int val;
 
 	/*
 	 * If we got ROR (receive overrun) interrupt we know that something is
@@ -635,8 +623,12 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	 * any case we disable interrupts and notify the worker to handle
 	 * any post-processing of the message.
 	 */
-	ep93xx_spi_disable_interrupts(espi);
+	val = readl(espi->mmio + SSPCR1);
+	val &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
+	writel(val, espi->mmio + SSPCR1);
+
 	complete(&espi->wait);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
