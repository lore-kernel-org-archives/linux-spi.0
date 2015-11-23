From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi/spi-xilinx: Use a cached copy of CR register
Date: Mon, 23 Nov 2015 11:11:20 +0530
Message-ID: <1448257280-15717-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	<anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Control register is written by the driver.
Use a cached copy of the register so that the reads
thereafter can use the variable instead of the register read.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-xilinx.c |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 3009121..73f4453 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -91,6 +91,7 @@ struct xilinx_spi {
 	u8 bytes_per_word;
 	int buffer_size;	/* buffer size in words */
 	u32 cs_inactive;	/* Level of the CS pins when inactive*/
+	u32 cr;			/* Control Register*/
 	unsigned int (*read_fn)(void __iomem *);
 	void (*write_fn)(u32, void __iomem *);
 };
@@ -180,15 +181,15 @@ static void xspi_init_hw(struct xilinx_spi *xspi)
 	xspi->write_fn(0xffff, regs_base + XSPI_SSR_OFFSET);
 	/* Disable the transmitter, enable Manual Slave Select Assertion,
 	 * put SPI controller into master mode, and enable it */
-	xspi->write_fn(XSPI_CR_MANUAL_SSELECT |	XSPI_CR_MASTER_MODE |
-		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET,
-		regs_base + XSPI_CR_OFFSET);
+	xspi->cr = XSPI_CR_MANUAL_SSELECT | XSPI_CR_MASTER_MODE |
+		XSPI_CR_ENABLE | XSPI_CR_TXFIFO_RESET |	XSPI_CR_RXFIFO_RESET;
+	xspi->write_fn(xspi->cr, regs_base + XSPI_CR_OFFSET);
+	xspi->cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 }
 
 static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 {
 	struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
-	u16 cr;
 	u32 cs;
 
 	if (is_on == BITBANG_CS_INACTIVE) {
@@ -198,16 +199,16 @@ static void xilinx_spi_chipselect(struct spi_device *spi, int is_on)
 	}
 
 	/* Set the SPI clock phase and polarity */
-	cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET)	& ~XSPI_CR_MODE_MASK;
+	xspi->cr &=  ~XSPI_CR_MODE_MASK;
 	if (spi->mode & SPI_CPHA)
-		cr |= XSPI_CR_CPHA;
+		xspi->cr |= XSPI_CR_CPHA;
 	if (spi->mode & SPI_CPOL)
-		cr |= XSPI_CR_CPOL;
+		xspi->cr |= XSPI_CR_CPOL;
 	if (spi->mode & SPI_LSB_FIRST)
-		cr |= XSPI_CR_LSB_FIRST;
+		xspi->cr |= XSPI_CR_LSB_FIRST;
 	if (spi->mode & SPI_LOOP)
-		cr |= XSPI_CR_LOOP;
-	xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+		xspi->cr |= XSPI_CR_LOOP;
+	xspi->write_fn(xspi->cr, xspi->regs + XSPI_CR_OFFSET);
 
 	/* We do not check spi->max_speed_hz here as the SPI clock
 	 * frequency is not software programmable (the IP block design
@@ -254,7 +255,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		u32 isr;
 		use_irq = true;
 		/* Inhibit irq to avoid spurious irqs on tx_empty*/
-		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
+		cr = xspi->cr;
+		xspi->cr = cr | XSPI_CR_TRANS_INHIBIT;
 		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
 		/* ACK old irqs (if any) */
@@ -283,7 +285,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 */
 
 		if (use_irq) {
-			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+			xspi->cr = cr;
+			xspi->write_fn(xspi->cr, xspi->regs + XSPI_CR_OFFSET);
 			wait_for_completion(&xspi->done);
 			/* A transmit has just completed. Process received data
 			 * and check for more data to transmit. Always inhibit
@@ -291,8 +294,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 			 * register/FIFO, or make sure it is stopped if we're
 			 * done.
 			 */
-			xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
-				       xspi->regs + XSPI_CR_OFFSET);
+			xspi->cr = xspi->cr | XSPI_CR_TRANS_INHIBIT;
+			xspi->write_fn(xspi->cr, xspi->regs + XSPI_CR_OFFSET);
 			sr = XSPI_SR_TX_EMPTY_MASK;
 		} else
 			sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
@@ -318,7 +321,8 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	if (use_irq) {
 		xspi->write_fn(0, xspi->regs + XIPIF_V123B_DGIER_OFFSET);
-		xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
+		xspi->cr = cr;
+		xspi->write_fn(xspi->cr, xspi->regs + XSPI_CR_OFFSET);
 	}
 
 	return t->len;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
