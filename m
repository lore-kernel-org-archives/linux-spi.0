From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 05/09] spi: fsl-espi: fix and improve reading from RX FIFO
Date: Thu, 27 Oct 2016 21:27:35 +0200
Message-ID: <6ae20ab9-4068-9be7-654d-12424de35716@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently the driver polls in the ISR for enough bytes in the RX FIFO.
An ISR should never do this.
Change it to read as much as possible whenever the ISR is called.
This also allows to significantly simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 67 ++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d550685..ca14575 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -223,6 +223,24 @@ static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 		}
 }
 
+static void fsl_espi_read_rx_fifo(struct mpc8xxx_spi *mspi, u32 events)
+{
+	u32 rx_fifo_avail = SPIE_RXCNT(events);
+
+	while (rx_fifo_avail >= min(4U, mspi->rx_len) && mspi->rx_len)
+		if (mspi->rx_len >= 4) {
+			*(u32 *)mspi->rx = fsl_espi_read_reg(mspi, ESPI_SPIRF);
+			mspi->rx += 4;
+			mspi->rx_len -= 4;
+			rx_fifo_avail -= 4;
+		} else {
+			*(u8 *)mspi->rx = fsl_espi_read_reg8(mspi, ESPI_SPIRF);
+			mspi->rx += 1;
+			mspi->rx_len -= 1;
+			rx_fifo_avail -= 1;
+		}
+}
+
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -418,53 +436,8 @@ static void fsl_espi_cleanup(struct spi_device *spi)
 
 static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
-	/* We need handle RX first */
-	if (events & SPIE_RNE) {
-		u32 rx_data, tmp;
-		u8 rx_data_8;
-		int rx_nr_bytes = 4;
-		int ret;
-
-		/* Spin until RX is done */
-		if (SPIE_RXCNT(events) < min(4U, mspi->rx_len)) {
-			ret = spin_event_timeout(
-				!(SPIE_RXCNT(events =
-				fsl_espi_read_reg(mspi, ESPI_SPIE)) <
-						min(4U, mspi->rx_len)),
-						10000, 0); /* 10 msec */
-			if (!ret)
-				dev_err(mspi->dev,
-					 "tired waiting for SPIE_RXCNT\n");
-		}
-
-		if (mspi->rx_len >= 4) {
-			rx_data = fsl_espi_read_reg(mspi, ESPI_SPIRF);
-		} else if (!mspi->rx_len) {
-			dev_err(mspi->dev,
-				"unexpected RX(SPIE_RNE) interrupt occurred,\n"
-				"(local rxlen %d bytes, reg rxlen %d bytes)\n",
-				min(4U, mspi->rx_len), SPIE_RXCNT(events));
-			rx_nr_bytes = 0;
-		} else {
-			rx_nr_bytes = mspi->rx_len;
-			tmp = mspi->rx_len;
-			rx_data = 0;
-			while (tmp--) {
-				rx_data_8 = fsl_espi_read_reg8(mspi,
-							       ESPI_SPIRF);
-				rx_data |= (rx_data_8 << (tmp * 8));
-			}
-
-			rx_data <<= (4 - mspi->rx_len) * 8;
-		}
-
-		mspi->rx_len -= rx_nr_bytes;
-
-		if (rx_nr_bytes && mspi->rx) {
-			*(u32 *)mspi->rx = rx_data;
-			mspi->rx += 4;
-		}
-	}
+	if (mspi->rx_len)
+		fsl_espi_read_rx_fifo(mspi, events);
 
 	if (mspi->tx_len)
 		fsl_espi_fill_tx_fifo(mspi, events);
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
