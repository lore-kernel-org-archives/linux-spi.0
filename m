From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 4/7] spi: spi-ep93xx: absorb the interrupt enable/disable helpers
Date: Fri,  4 Aug 2017 12:00:20 +1200
Message-ID: <20170804000023.15624-5-chris.packham@alliedtelesis.co.nz>
References: <20170804000023.15624-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        hsweeten@visionengravers.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804000023.15624-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: H Hartley Sweeten <hsweeten@visionengravers.com>

These are each only called once. Just absorb them into the callers.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
[chris: use u32 instead of unsigned int]
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-ep93xx.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index ce6ec164f2f2..041842e0d028 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -111,24 +111,6 @@ struct ep93xx_spi {
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
-static void ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
-{
-	u32 val;
-
-	val = readl(espi->mmio + SSPCR1);
-	val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
-	writel(val, espi->mmio + SSPCR1);
-}
-
-static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
-{
-	u32 val;
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
+		u32 val;
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
+	u32 val;
 
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
