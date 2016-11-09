From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: fsl-espi: add support for ESPI RXSKIP mode
Date: Wed, 9 Nov 2016 22:58:01 +0100
Message-ID: <0e96f53c-5e83-77bd-a57a-2e576ca20019@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds support for ESPI RXSKIP mode. This mode is optimized
for flash reads:
- sends a number of bytes and then reads a number of bytes
- shifts out zeros automatically when reading

Supporting RXSKIP mode is a prerequisite for supporting dual output
read mode.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 51 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-fsl-lib.h  |  1 +
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index edb524f..e147fa7 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -150,7 +150,8 @@ static void fsl_espi_copy_to_buf(struct spi_message *m,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf)
 			fsl_espi_memcpy_swab(buf, t->tx_buf, m, t);
-		else
+		/* In RXSKIP mode controller shifts out zeros internally */
+		else if (!mspi->rxskip)
 			memset(buf, 0, t->len);
 		buf += t->len;
 	}
@@ -203,6 +204,37 @@ static int fsl_espi_check_message(struct spi_message *m)
 	return 0;
 }
 
+static unsigned int fsl_espi_check_rxskip_mode(struct spi_message *m)
+{
+	struct spi_transfer *t;
+	unsigned int i = 0, rxskip = 0;
+
+	/*
+	 * prerequisites for ESPI rxskip mode:
+	 * - message has two transfers
+	 * - first transfer is a write and second is a read
+	 *
+	 * In addition the current low-level transfer mechanism requires
+	 * that the rxskip bytes fit into the TX FIFO. Else the transfer
+	 * would hang because after the first FSL_ESPI_FIFO_SIZE bytes
+	 * the TX FIFO isn't re-filled.
+	 */
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (i == 0) {
+			if (!t->tx_buf || t->rx_buf ||
+			    t->len > FSL_ESPI_FIFO_SIZE)
+				return 0;
+			rxskip = t->len;
+		} else if (i == 1) {
+			if (t->tx_buf || !t->rx_buf)
+				return 0;
+		}
+		i++;
+	}
+
+	return i == 2 ? rxskip : 0;
+}
+
 static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 {
 	u32 tx_fifo_avail;
@@ -281,7 +313,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	u32 mask;
+	u32 mask, spcom;
 	int ret;
 
 	mpc8xxx_spi->rx_len = t->len;
@@ -293,8 +325,18 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
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
@@ -326,6 +368,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 	struct spi_device *spi = m->spi;
 	int ret;
 
+	mspi->rxskip = fsl_espi_check_rxskip_mode(m);
 	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 35a7a17..3951322 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -31,6 +31,7 @@ struct mpc8xxx_spi {
 #if IS_ENABLED(CONFIG_SPI_FSL_ESPI)
 	unsigned int rx_len;
 	unsigned int tx_len;
+	unsigned int rxskip;
 	u8 *local_buf;
 	spinlock_t lock;
 #endif
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
