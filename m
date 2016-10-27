From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 03/09] spi: fsl-espi: Rename len in struct mpc8xxx_spi to
 rx_len and make it unsigned
Date: Thu, 27 Oct 2016 21:26:08 +0200
Message-ID: <611500a3-d254-f04c-ce20-6905a649bcda@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Now that we introduced element tx_len in struct mpc8xxx_spi let's
rename element len to rx_len as it actually is the number of bytes to
receive. In addition make it unsigned.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 22 +++++++++++-----------
 drivers/spi/spi-fsl-lib.h  |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 95c1fbf..5a7449f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -284,7 +284,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int ret;
 
-	mpc8xxx_spi->len = t->len;
+	mpc8xxx_spi->rx_len = t->len;
 	mpc8xxx_spi->tx_len = t->len;
 
 	mpc8xxx_spi->tx = t->tx_buf;
@@ -445,28 +445,28 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		int ret;
 
 		/* Spin until RX is done */
-		if (SPIE_RXCNT(events) < min(4, mspi->len)) {
+		if (SPIE_RXCNT(events) < min(4U, mspi->rx_len)) {
 			ret = spin_event_timeout(
 				!(SPIE_RXCNT(events =
 				fsl_espi_read_reg(mspi, ESPI_SPIE)) <
-						min(4, mspi->len)),
+						min(4U, mspi->rx_len)),
 						10000, 0); /* 10 msec */
 			if (!ret)
 				dev_err(mspi->dev,
 					 "tired waiting for SPIE_RXCNT\n");
 		}
 
-		if (mspi->len >= 4) {
+		if (mspi->rx_len >= 4) {
 			rx_data = fsl_espi_read_reg(mspi, ESPI_SPIRF);
-		} else if (mspi->len <= 0) {
+		} else if (!mspi->rx_len) {
 			dev_err(mspi->dev,
 				"unexpected RX(SPIE_RNE) interrupt occurred,\n"
 				"(local rxlen %d bytes, reg rxlen %d bytes)\n",
-				min(4, mspi->len), SPIE_RXCNT(events));
+				min(4U, mspi->rx_len), SPIE_RXCNT(events));
 			rx_nr_bytes = 0;
 		} else {
-			rx_nr_bytes = mspi->len;
-			tmp = mspi->len;
+			rx_nr_bytes = mspi->rx_len;
+			tmp = mspi->rx_len;
 			rx_data = 0;
 			while (tmp--) {
 				rx_data_8 = fsl_espi_read_reg8(mspi,
@@ -474,10 +474,10 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 				rx_data |= (rx_data_8 << (tmp * 8));
 			}
 
-			rx_data <<= (4 - mspi->len) * 8;
+			rx_data <<= (4 - mspi->rx_len) * 8;
 		}
 
-		mspi->len -= rx_nr_bytes;
+		mspi->rx_len -= rx_nr_bytes;
 
 		if (rx_nr_bytes && mspi->rx) {
 			*(u32 *)mspi->rx = rx_data;
@@ -488,7 +488,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (mspi->tx_len)
 		fsl_espi_fill_tx_fifo(mspi, events);
 
-	if (!mspi->tx_len && !mspi->len)
+	if (!mspi->tx_len && !mspi->rx_len)
 		complete(&mspi->done);
 }
 
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 24d8bc8..35a7a17 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -29,7 +29,7 @@ struct mpc8xxx_spi {
 	const void *tx;
 	void *rx;
 #if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
-	int len;
+	unsigned int rx_len;
 	unsigned int tx_len;
 	u8 *local_buf;
 	spinlock_t lock;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
