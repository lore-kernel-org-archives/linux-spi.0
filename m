From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: atmel: add support for changing message transfer speed
Date: Thu,  7 Nov 2013 10:34:06 +0100
Message-ID: <1383816846-10561-1-git-send-email-richard.genoud@gmail.com>
Cc: Wenyou Yang <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The only speed available was max_speed (the maximum speed declared for a
device).
This patch adds the support for spi_tranfer->speed_hz parameter.
We can now set a different speed for each spi message.

Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c |   92 ++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 656ed36e729e..d0dd564cd7b3 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -694,6 +694,54 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 	*plen = len;
 }
 
+static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
+				    struct spi_device *spi,
+				    struct spi_transfer *xfer)
+{
+	u32			scbr, csr;
+	unsigned long		bus_hz;
+
+	/* v1 chips start out at half the peripheral bus speed. */
+	bus_hz = clk_get_rate(as->clk);
+	if (!atmel_spi_is_v2(as))
+		bus_hz /= 2;
+
+	/*
+	 * Calculate the lowest divider that satisfies the
+	 * constraint, assuming div32/fdiv/mbz == 0.
+	 */
+	if (xfer->speed_hz)
+		scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
+	else
+		/*
+		 * This can happend if max_speed is null.
+		 * In this case, we set the lowest possible speed
+		 */
+		scbr = 0xff;
+
+	/*
+	 * If the resulting divider doesn't fit into the
+	 * register bitfield, we can't satisfy the constraint.
+	 */
+	if (scbr >= (1 << SPI_SCBR_SIZE)) {
+		dev_err(&spi->dev,
+			"setup: %d Hz too slow, scbr %u; min %ld Hz\n",
+			xfer->speed_hz, scbr, bus_hz/255);
+		return -EINVAL;
+	}
+	if (scbr == 0) {
+		dev_err(&spi->dev,
+			"setup: %d Hz too high, scbr %u; max %ld Hz\n",
+			xfer->speed_hz, scbr, bus_hz);
+		return -EINVAL;
+	}
+	csr = spi_readl(as, CSR0 + 4 * spi->chip_select);
+	csr = SPI_BFINS(SCBR, scbr, csr);
+	spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
+
+	return 0;
+}
+
 /*
  * Submit next transfer for PDC.
  * lock is held, spi irq is blocked
@@ -731,6 +779,8 @@ static void atmel_spi_pdc_next_xfer(struct spi_master *master,
 		spi_writel(as, RCR, len);
 		spi_writel(as, TCR, len);
 
+		atmel_spi_set_xfer_speed(as, msg->spi, xfer);
+
 		dev_dbg(&msg->spi->dev,
 			"  start xfer %p: len %u tx %p/%08llx rx %p/%08llx\n",
 			xfer, xfer->len, xfer->tx_buf,
@@ -823,6 +873,7 @@ static void atmel_spi_dma_next_xfer(struct spi_master *master,
 
 		as->current_transfer = xfer;
 		len = xfer->len;
+		atmel_spi_set_xfer_speed(as, msg->spi, xfer);
 	}
 
 	if (atmel_spi_use_dma(as, xfer)) {
@@ -1264,9 +1315,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
 	struct atmel_spi_device	*asd;
-	u32			scbr, csr;
+	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
-	unsigned long		bus_hz;
 	unsigned int		npcs_pin;
 	int			ret;
 
@@ -1290,33 +1340,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	/* v1 chips start out at half the peripheral bus speed. */
-	bus_hz = clk_get_rate(as->clk);
-	if (!atmel_spi_is_v2(as))
-		bus_hz /= 2;
-
-	if (spi->max_speed_hz) {
-		/*
-		 * Calculate the lowest divider that satisfies the
-		 * constraint, assuming div32/fdiv/mbz == 0.
-		 */
-		scbr = DIV_ROUND_UP(bus_hz, spi->max_speed_hz);
-
-		/*
-		 * If the resulting divider doesn't fit into the
-		 * register bitfield, we can't satisfy the constraint.
-		 */
-		if (scbr >= (1 << SPI_SCBR_SIZE)) {
-			dev_dbg(&spi->dev,
-				"setup: %d Hz too slow, scbr %u; min %ld Hz\n",
-				spi->max_speed_hz, scbr, bus_hz/255);
-			return -EINVAL;
-		}
-	} else
-		/* speed zero means "as slow as possible" */
-		scbr = 0xff;
-
-	csr = SPI_BF(SCBR, scbr) | SPI_BF(BITS, bits - 8);
+	csr = SPI_BF(BITS, bits - 8);
 	if (spi->mode & SPI_CPOL)
 		csr |= SPI_BIT(CPOL);
 	if (!(spi->mode & SPI_CPHA))
@@ -1363,8 +1387,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 	asd->csr = csr;
 
 	dev_dbg(&spi->dev,
-		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
-		bus_hz / scbr, bits, spi->mode, spi->chip_select, csr);
+		"setup: bpw %u mode 0x%x -> csr%d %08x\n",
+		bits, spi->mode, spi->chip_select, csr);
 
 	if (!atmel_spi_is_v2(as))
 		spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
@@ -1414,12 +1438,6 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 			}
 		}
 
-		/* FIXME implement these protocol options!! */
-		if (xfer->speed_hz < spi->max_speed_hz) {
-			dev_dbg(&spi->dev, "can't change speed in transfer\n");
-			return -ENOPROTOOPT;
-		}
-
 		/*
 		 * DMA map early, for performance (empties dcache ASAP) and
 		 * better fault reporting.
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
