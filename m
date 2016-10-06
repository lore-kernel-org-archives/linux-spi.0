From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: fix handling of word sizes other than 8 bit" to the spi tree
Date: Thu, 06 Oct 2016 18:03:30 +0200
Message-ID: <E1bsB8s-0001rb-NN@finisterre>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: fix handling of word sizes other than 8 bit

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

>From 6e6c6637bd982c941bad2502c11ef8d132ae20b8 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 2 Oct 2016 14:22:57 +0200
Subject: [PATCH] spi: fsl-espi: fix handling of word sizes other than 8 bit

The code in fsl_espi_tx_buf_lsb and parts of fsl_espi_setup_transfer
look very weird and don't reflect the ESPI spec.
ESPI stores values with <= 8 bit word size right justified as 8 bit
value and values with > 8 bit word size right justified as 16 bit
value. Therefore no such shifting is needed.
Only case MSB-first with 8 bit word size is correctly handled,
and most likely nobody ever used this driver with a different config.

On ESPI only the case LSB-first with word size > 8 bit needs a
special handling. In this case a little endian 16 bit value has
to be written to the TX FIFO what requires a byte swap as the
host system is big endian.
The same applies to reading from the RX FIFO.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 84 ++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 65bb70d3bfc4..eea5123abb38 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -112,6 +112,32 @@ static inline void fsl_espi_write_reg8(struct mpc8xxx_spi *mspi, int offset,
 	iowrite8(val, mspi->reg_base + offset);
 }
 
+static void fsl_espi_memcpy_swab(void *to, const void *from,
+				 struct spi_message *m,
+				 struct spi_transfer *t)
+{
+	unsigned int len = t->len;
+
+	if (!(m->spi->mode & SPI_LSB_FIRST) || t->bits_per_word <= 8) {
+		memcpy(to, from, len);
+		return;
+	}
+
+	/* In case of LSB-first and bits_per_word > 8 byte-swap all words */
+	while (len)
+		if (len >= 4) {
+			*(u32 *)to = swahb32p(from);
+			to += 4;
+			from += 4;
+			len -= 4;
+		} else {
+			*(u16 *)to = swab16p(from);
+			to += 2;
+			from += 2;
+			len -= 2;
+		}
+}
+
 static void fsl_espi_copy_to_buf(struct spi_message *m,
 				 struct mpc8xxx_spi *mspi)
 {
@@ -120,7 +146,7 @@ static void fsl_espi_copy_to_buf(struct spi_message *m,
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf)
-			memcpy(buf, t->tx_buf, t->len);
+			fsl_espi_memcpy_swab(buf, t->tx_buf, m, t);
 		else
 			memset(buf, 0, t->len);
 		buf += t->len;
@@ -135,7 +161,7 @@ static void fsl_espi_copy_from_buf(struct spi_message *m,
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
-			memcpy(t->rx_buf, buf, t->len);
+			fsl_espi_memcpy_swab(t->rx_buf, buf, m, t);
 		buf += t->len;
 	}
 }
@@ -194,27 +220,6 @@ static void fsl_espi_change_mode(struct spi_device *spi)
 	local_irq_restore(flags);
 }
 
-static u32 fsl_espi_tx_buf_lsb(struct mpc8xxx_spi *mpc8xxx_spi)
-{
-	u32 data;
-	u16 data_h;
-	u16 data_l;
-	const u32 *tx = mpc8xxx_spi->tx;
-
-	if (!tx)
-		return 0;
-
-	data = *tx++ << mpc8xxx_spi->tx_shift;
-	data_l = data & 0xffff;
-	data_h = (data >> 16) & 0xffff;
-	swab16s(&data_l);
-	swab16s(&data_h);
-	data = data_h | data_l;
-
-	mpc8xxx_spi->tx = tx;
-	return data;
-}
-
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -224,23 +229,6 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	u8 pm;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 
-	cs->rx_shift = 0;
-	cs->tx_shift = 0;
-	cs->get_rx = mpc8xxx_spi_rx_buf_u32;
-	cs->get_tx = mpc8xxx_spi_tx_buf_u32;
-	if (bits_per_word <= 8) {
-		cs->rx_shift = 8 - bits_per_word;
-	} else {
-		cs->rx_shift = 16 - bits_per_word;
-		if (spi->mode & SPI_LSB_FIRST)
-			cs->get_tx = fsl_espi_tx_buf_lsb;
-	}
-
-	mpc8xxx_spi->rx_shift = cs->rx_shift;
-	mpc8xxx_spi->tx_shift = cs->tx_shift;
-	mpc8xxx_spi->get_rx = cs->get_rx;
-	mpc8xxx_spi->get_tx = cs->get_tx;
-
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
 
@@ -271,7 +259,6 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	u32 word;
 	int ret;
 
 	mpc8xxx_spi->len = t->len;
@@ -290,8 +277,8 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_RNE);
 
 	/* transmit word */
-	word = mpc8xxx_spi->get_tx(mpc8xxx_spi);
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPITF, word);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPITF, *(u32 *)mpc8xxx_spi->tx);
+	mpc8xxx_spi->tx += 4;
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
@@ -468,8 +455,10 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		mspi->len -= rx_nr_bytes;
 
-		if (mspi->rx)
-			mspi->get_rx(rx_data, mspi);
+		if (mspi->rx) {
+			*(u32 *)mspi->rx = rx_data;
+			mspi->rx += 4;
+		}
 	}
 
 	if (!(events & SPIE_TNF)) {
@@ -487,9 +476,8 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 	mspi->count -= 1;
 	if (mspi->count) {
-		u32 word = mspi->get_tx(mspi);
-
-		fsl_espi_write_reg(mspi, ESPI_SPITF, word);
+		fsl_espi_write_reg(mspi, ESPI_SPITF, *(u32 *)mspi->tx);
+		mspi->tx += 4;
 	} else {
 		complete(&mspi->done);
 	}
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
