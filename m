From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: add support for ESPI RXSKIP mode" to the spi tree
Date: Fri, 11 Nov 2016 16:01:34 +0000
Message-ID: <E1c5EGk-0003pI-Mc@finisterre>
References: <0e96f53c-5e83-77bd-a57a-2e576ca20019@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0e96f53c-5e83-77bd-a57a-2e576ca20019-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: add support for ESPI RXSKIP mode

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aca75157d9beb7b171a178446ecdb4d047b9f934 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 9 Nov 2016 22:58:01 +0100
Subject: [PATCH] spi: fsl-espi: add support for ESPI RXSKIP mode

This patch adds support for ESPI RXSKIP mode. This mode is optimized
for flash reads:
- sends a number of bytes and then reads a number of bytes
- shifts out zeros automatically when reading

Supporting RXSKIP mode is a prerequisite for supporting dual output
read mode.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 51 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-fsl-lib.h  |  1 +
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index edb524f831a3..9ccbfbc75933 100644
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
index 35a7a1730d0c..3951322265d4 100644
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
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
