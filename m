From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Fwd: [RFC,
	PATCH] atmel_spi: Reduce memory bandwidth requirement
Date: Wed, 7 Nov 2007 11:56:22 -0800
Message-ID: <200711071156.22262.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

FYI -- this doesn't affect the issue noted (which happens
on reads, seemingly due to a too-busy bus) but otherwise it
seems like a reasonable notion and I've forwarded it to the
driver's maintainer.


----------  Forwarded Message  ----------

Subject: [RFC, PATCH] atmel_spi: Reduce memory bandwidth requirement
Date: Friday 02 November 2007
From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org

Reduce memory bandwidth requirement for spi write-only transfer. This should
fix fifo errors for write-only operations.

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

---

Hi all!

Hope this patch will fix 'fifo overrun with atmel_spi & JFFS2'.
As stated in the at91sam9260 and at91rm9200 datasheet, the OVRES error is only
set for when received data aren't read in time.
So, for write-only spi transfer, there is no need to read the data, and no need
to check this flag.

Tested on 2.6.23.1 + maxim.org.za patches on at91rm9200, but only on a
write-only (display) device.

Regards

Marc

--- drivers/spi/atmel_spi.c.orig	2007-11-02 08:04:21.000000000 +0100
+++ drivers/spi/atmel_spi.c	2007-11-02 08:37:14.000000000 +0100
@@ -150,11 +150,9 @@ static void atmel_spi_next_xfer(struct s
 	tx_dma = xfer->tx_dma + xfer->len - len;
 	rx_dma = xfer->rx_dma + xfer->len - len;
 
-	/* use scratch buffer only when rx or tx data is unspecified */
+	/* use scratch buffer only when tx data is unspecified */
 	if (!xfer->rx_buf) {
-		rx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
+		rx_dma = 0;
 	}
 	if (!xfer->tx_buf) {
 		tx_dma = as->buffer_dma;
@@ -188,16 +186,22 @@ static void atmel_spi_next_xfer(struct s
 	 */
 	spi_writel(as, TNCR, 0);
 	spi_writel(as, RNCR, 0);
-	spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
 
 	dev_dbg(&msg->spi->dev,
 		"  start xfer %p: len %u tx %p/%08x rx %p/%08x imr %03x\n",
 		xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
 		xfer->rx_buf, xfer->rx_dma, spi_readl(as, IMR));
 
-	spi_writel(as, TCR, len);
-	spi_writel(as, RCR, len);
-	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
+	if (xfer->rx_buf) {
+		spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
+		spi_writel(as, TCR, len);
+		spi_writel(as, RCR, len);
+		spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
+	} else {
+		spi_writel(as, IER, SPI_BIT(ENDTX));
+		spi_writel(as, TCR, len);
+		spi_writel(as, PTCR, SPI_BIT(TXTEN));
+	}
 }
 
 static void atmel_spi_next_message(struct spi_master *master)
@@ -372,7 +376,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 		spi_readl(as, SR);
 
 		atmel_spi_msg_done(master, as, msg, -EIO, 0);
-	} else if (pending & SPI_BIT(ENDRX)) {
+	} else if (pending & (SPI_BIT(ENDRX) | SPI_BIT(ENDTX))) {
 		ret = IRQ_HANDLED;
 
 		spi_writel(as, IDR, pending);

-------------------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
