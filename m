From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 09/09] spi: fsl-espi: add support for dual read mode
Date: Thu, 27 Oct 2016 21:29:30 +0200
Message-ID: <76530bca-7f84-2e97-9276-9b9c4dd229f6@gmail.com>
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

This patch adds support for dual output read mode.

It was successfully tested on a P1014-based device
with a S25FL128S spi nor flash.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
- extended commit message
---
 drivers/spi/spi-fsl-espi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e32dc30..5753b1e 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -205,10 +205,11 @@ static int fsl_espi_check_message(struct spi_message *m)
 }
 
 static void fsl_espi_check_rxskip_mode(struct spi_message *m,
-				       struct mpc8xxx_spi *mspi)
+				       struct mpc8xxx_spi *mspi,
+				       struct spi_transfer *tr)
 {
 	struct spi_transfer *t;
-	unsigned int i = 0, rxskip_len = 0;
+	unsigned int i = 0, rxskip_len = 0, rx_nbits = SPI_NBITS_SINGLE;
 
 	mspi->rxskip = 0;
 
@@ -222,6 +223,9 @@ static void fsl_espi_check_rxskip_mode(struct spi_message *m,
 	 * low-level transfer implementation.
 	 * This constraint doesn't affect SPI NOR reads as typical use case
 	 * for rxskip mode as the read command has only few bytes.
+	 *
+	 * Store rx_nbits of the read transfer for later assessment
+	 * whether single or dual mode is requested.
 	 */
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (i == 0) {
@@ -232,12 +236,15 @@ static void fsl_espi_check_rxskip_mode(struct spi_message *m,
 		} else if (i == 1) {
 			if (t->tx_buf || !t->rx_buf)
 				return;
+			rx_nbits = t->rx_nbits;
 		}
 		i++;
 	}
 
-	if (i == 2)
+	if (i == 2) {
 		mspi->rxskip = rxskip_len;
+		tr->rx_nbits = rx_nbits;
+	}
 }
 
 static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
@@ -340,6 +347,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		mpc8xxx_spi->tx_len = mpc8xxx_spi->rxskip;
 		mpc8xxx_spi->rx_len = t->len - mpc8xxx_spi->rxskip;
 		mpc8xxx_spi->rx = t->rx_buf + mpc8xxx_spi->rxskip;
+		if (t->rx_nbits == SPI_NBITS_DUAL)
+			spcom |= SPCOM_DO;
 	}
 
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, spcom);
@@ -374,7 +383,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	struct spi_device *spi = m->spi;
 	int ret;
 
-	fsl_espi_check_rxskip_mode(m, mspi);
+	fsl_espi_check_rxskip_mode(m, mspi, trans);
 	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
@@ -588,6 +597,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	mpc8xxx_spi_probe(dev, mem, irq);
 
+	master->mode_bits |= SPI_RX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
