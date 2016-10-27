From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 08/09] spi: fsl-espi: add support for RXSKIP mode
Date: Thu, 27 Oct 2016 21:28:51 +0200
Message-ID: <10553bf5-a1a7-5a5d-482b-8831f3ba859c@gmail.com>
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

This patch adds support for ESPI RXSKIP mode. This mode is optimized
for flash reads:
- sends a number of bytes and then reads a number of bytes
- shifts out zeros automatically when reading
- optionally can be configured for dual read mode

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-fsl-lib.h  |  1 +
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 2f95b19..e32dc30 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -150,7 +150,8 @@ static void fsl_espi_copy_to_buf(struct spi_message *m,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf)
 			fsl_espi_memcpy_swab(buf, t->tx_buf, m, t);
-		else
+		/* In RXSKIP mode controller shifts zeros automatically */
+		else if (!mspi->rxskip)
 			memset(buf, 0, t->len);
 		buf += t->len;
 	}
@@ -203,6 +204,42 @@ static int fsl_espi_check_message(struct spi_message *m)
 	return 0;
 }
 
+static void fsl_espi_check_rxskip_mode(struct spi_message *m,
+				       struct mpc8xxx_spi *mspi)
+{
+	struct spi_transfer *t;
+	unsigned int i = 0, rxskip_len = 0;
+
+	mspi->rxskip = 0;
+
+	/*
+	 * prerequisites for rxskip mode:
+	 * - message has two transfers
+	 * - first transfer is a write and second is a read
+	 *
+	 * In addition enable rxskip mode only if length of write transfer
+	 * is <= FSL_ESPI_FIFO_SIZE. This allows to keep the current
+	 * low-level transfer implementation.
+	 * This constraint doesn't affect SPI NOR reads as typical use case
+	 * for rxskip mode as the read command has only few bytes.
+	 */
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (i == 0) {
+			if (!t->tx_buf || t->rx_buf ||
+			    t->len > FSL_ESPI_FIFO_SIZE)
+				return;
+			rxskip_len = t->len;
+		} else if (i == 1) {
+			if (t->tx_buf || !t->rx_buf)
+				return;
+		}
+		i++;
+	}
+
+	if (i == 2)
+		mspi->rxskip = rxskip_len;
+}
+
 static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 {
 	u32 tx_fifo_avail;
@@ -282,7 +319,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	u32 mask;
+	u32 mask, spcom;
 	int ret;
 
 	mpc8xxx_spi->rx_len = t->len;
@@ -294,8 +331,18 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	reinit_completion(&mpc8xxx_spi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM,
-		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
+	spcom = SPCOM_CS(spi->chip_select);
+	spcom |= SPCOM_TRANLEN(t->len - 1);
+
+	/* configure RXSKIP mode */
+	if (mpc8xxx_spi->rxskip) {
+		spcom |= SPCOM_RXSKIP(mpc8xxx_spi->rxskip);
+		mpc8xxx_spi->tx_len = mpc8xxx_spi->rxskip;
+		mpc8xxx_spi->rx_len = t->len - mpc8xxx_spi->rxskip;
+		mpc8xxx_spi->rx = t->rx_buf + mpc8xxx_spi->rxskip;
+	}
+
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, spcom);
 
 	/* enable interrupts */
 	mask = SPIM_DON;
@@ -327,6 +374,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	struct spi_device *spi = m->spi;
 	int ret;
 
+	fsl_espi_check_rxskip_mode(m, mspi);
 	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 35a7a17..8096fae 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -32,6 +32,7 @@ struct mpc8xxx_spi {
 	unsigned int rx_len;
 	unsigned int tx_len;
 	u8 *local_buf;
+	unsigned int rxskip;
 	spinlock_t lock;
 #endif
 
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
