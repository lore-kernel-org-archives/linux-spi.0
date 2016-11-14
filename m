From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: introduce struct fsl_espi" to the spi tree
Date: Mon, 14 Nov 2016 13:54:22 +0000
Message-ID: <E1c6HiI-0003Ip-6f@finisterre>
References: <9f680ac2-08ab-a767-7097-a1b949cdc5a8@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9f680ac2-08ab-a767-7097-a1b949cdc5a8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: introduce struct fsl_espi

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

>From 35ab046b52f61c80fd43c3cc10d9ffac25a86b99 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 13 Nov 2016 14:40:51 +0100
Subject: [PATCH] spi: fsl-espi: introduce struct fsl_espi

Only few members of struct mpc8xxx_spi are relevant for fsl-espi.
Therefore replace it with a ESPI-specific struct fsl_espi.
Replace variable names mpc8xxx_spi and mspi with espi.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 270 ++++++++++++++++++++++++---------------------
 1 file changed, 143 insertions(+), 127 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7a903434c881..8539f0584a8a 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -93,30 +93,49 @@
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
+struct fsl_espi {
+	struct device *dev;
+	void __iomem *reg_base;
+
+	const void *tx;
+	void *rx;
+
+	unsigned int rx_len;
+	unsigned int tx_len;
+	unsigned int rxskip;
+
+	u8 *local_buf;
+	spinlock_t lock;
+
+	u32 spibrg;             /* SPIBRG input clock */
+
+	struct completion done;
+};
+
 struct fsl_espi_cs {
 	u32 hw_mode;
 };
 
-static inline u32 fsl_espi_read_reg(struct mpc8xxx_spi *mspi, int offset)
+static inline u32 fsl_espi_read_reg(struct fsl_espi *espi, int offset)
 {
-	return ioread32be(mspi->reg_base + offset);
+	return ioread32be(espi->reg_base + offset);
 }
 
-static inline u8 fsl_espi_read_reg8(struct mpc8xxx_spi *mspi, int offset)
+static inline u8 fsl_espi_read_reg8(struct fsl_espi *espi, int offset)
 {
-	return ioread8(mspi->reg_base + offset);
+	return ioread8(espi->reg_base + offset);
 }
 
-static inline void fsl_espi_write_reg(struct mpc8xxx_spi *mspi, int offset,
+static inline void fsl_espi_write_reg(struct fsl_espi *espi, int offset,
 				      u32 val)
 {
-	iowrite32be(val, mspi->reg_base + offset);
+	iowrite32be(val, espi->reg_base + offset);
 }
 
-static inline void fsl_espi_write_reg8(struct mpc8xxx_spi *mspi, int offset,
+static inline void fsl_espi_write_reg8(struct fsl_espi *espi, int offset,
 				       u8 val)
 {
-	iowrite8(val, mspi->reg_base + offset);
+	iowrite8(val, espi->reg_base + offset);
 }
 
 static void fsl_espi_memcpy_swab(void *to, const void *from,
@@ -146,26 +165,26 @@ static void fsl_espi_memcpy_swab(void *to, const void *from,
 }
 
 static void fsl_espi_copy_to_buf(struct spi_message *m,
-				 struct mpc8xxx_spi *mspi)
+				 struct fsl_espi *espi)
 {
 	struct spi_transfer *t;
-	u8 *buf = mspi->local_buf;
+	u8 *buf = espi->local_buf;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->tx_buf)
 			fsl_espi_memcpy_swab(buf, t->tx_buf, m, t);
 		/* In RXSKIP mode controller shifts out zeros internally */
-		else if (!mspi->rxskip)
+		else if (!espi->rxskip)
 			memset(buf, 0, t->len);
 		buf += t->len;
 	}
 }
 
 static void fsl_espi_copy_from_buf(struct spi_message *m,
-				   struct mpc8xxx_spi *mspi)
+				   struct fsl_espi *espi)
 {
 	struct spi_transfer *t;
-	u8 *buf = mspi->local_buf;
+	u8 *buf = espi->local_buf;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (t->rx_buf)
@@ -176,11 +195,11 @@ static void fsl_espi_copy_from_buf(struct spi_message *m,
 
 static int fsl_espi_check_message(struct spi_message *m)
 {
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
+	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
 	struct spi_transfer *t, *first;
 
 	if (m->frame_length > SPCOM_TRANLEN_MAX) {
-		dev_err(mspi->dev, "message too long, size is %u bytes\n",
+		dev_err(espi->dev, "message too long, size is %u bytes\n",
 			m->frame_length);
 		return -EMSGSIZE;
 	}
@@ -191,7 +210,7 @@ static int fsl_espi_check_message(struct spi_message *m)
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (first->bits_per_word != t->bits_per_word ||
 		    first->speed_hz != t->speed_hz) {
-			dev_err(mspi->dev, "bits_per_word/speed_hz should be the same for all transfers\n");
+			dev_err(espi->dev, "bits_per_word/speed_hz should be the same for all transfers\n");
 			return -EINVAL;
 		}
 	}
@@ -199,7 +218,7 @@ static int fsl_espi_check_message(struct spi_message *m)
 	/* ESPI supports MSB-first transfers for word size 8 / 16 only */
 	if (!(m->spi->mode & SPI_LSB_FIRST) && first->bits_per_word != 8 &&
 	    first->bits_per_word != 16) {
-		dev_err(mspi->dev,
+		dev_err(espi->dev,
 			"MSB-first transfer not supported for wordsize %u\n",
 			first->bits_per_word);
 		return -EINVAL;
@@ -239,41 +258,41 @@ static unsigned int fsl_espi_check_rxskip_mode(struct spi_message *m)
 	return i == 2 ? rxskip : 0;
 }
 
-static void fsl_espi_fill_tx_fifo(struct mpc8xxx_spi *mspi, u32 events)
+static void fsl_espi_fill_tx_fifo(struct fsl_espi *espi, u32 events)
 {
 	u32 tx_fifo_avail;
 
 	/* if events is zero transfer has not started and tx fifo is empty */
 	tx_fifo_avail = events ? SPIE_TXCNT(events) :  FSL_ESPI_FIFO_SIZE;
 
-	while (tx_fifo_avail >= min(4U, mspi->tx_len) && mspi->tx_len)
-		if (mspi->tx_len >= 4) {
-			fsl_espi_write_reg(mspi, ESPI_SPITF, *(u32 *)mspi->tx);
-			mspi->tx += 4;
-			mspi->tx_len -= 4;
+	while (tx_fifo_avail >= min(4U, espi->tx_len) && espi->tx_len)
+		if (espi->tx_len >= 4) {
+			fsl_espi_write_reg(espi, ESPI_SPITF, *(u32 *)espi->tx);
+			espi->tx += 4;
+			espi->tx_len -= 4;
 			tx_fifo_avail -= 4;
 		} else {
-			fsl_espi_write_reg8(mspi, ESPI_SPITF, *(u8 *)mspi->tx);
-			mspi->tx += 1;
-			mspi->tx_len -= 1;
+			fsl_espi_write_reg8(espi, ESPI_SPITF, *(u8 *)espi->tx);
+			espi->tx += 1;
+			espi->tx_len -= 1;
 			tx_fifo_avail -= 1;
 		}
 }
 
-static void fsl_espi_read_rx_fifo(struct mpc8xxx_spi *mspi, u32 events)
+static void fsl_espi_read_rx_fifo(struct fsl_espi *espi, u32 events)
 {
 	u32 rx_fifo_avail = SPIE_RXCNT(events);
 
-	while (rx_fifo_avail >= min(4U, mspi->rx_len) && mspi->rx_len)
-		if (mspi->rx_len >= 4) {
-			*(u32 *)mspi->rx = fsl_espi_read_reg(mspi, ESPI_SPIRF);
-			mspi->rx += 4;
-			mspi->rx_len -= 4;
+	while (rx_fifo_avail >= min(4U, espi->rx_len) && espi->rx_len)
+		if (espi->rx_len >= 4) {
+			*(u32 *)espi->rx = fsl_espi_read_reg(espi, ESPI_SPIRF);
+			espi->rx += 4;
+			espi->rx_len -= 4;
 			rx_fifo_avail -= 4;
 		} else {
-			*(u8 *)mspi->rx = fsl_espi_read_reg8(mspi, ESPI_SPIRF);
-			mspi->rx += 1;
-			mspi->rx_len -= 1;
+			*(u8 *)espi->rx = fsl_espi_read_reg8(espi, ESPI_SPIRF);
+			espi->rx += 1;
+			espi->rx_len -= 1;
 			rx_fifo_avail -= 1;
 		}
 }
@@ -281,7 +300,7 @@ static void fsl_espi_read_rx_fifo(struct mpc8xxx_spi *mspi, u32 events)
 static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
 	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
@@ -292,16 +311,16 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_LEN(bits_per_word - 1);
 
-	pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4) - 1;
+	pm = DIV_ROUND_UP(espi->spibrg, hz * 4) - 1;
 
 	if (pm > 15) {
 		cs->hw_mode |= CSMODE_DIV16;
-		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4) - 1;
+		pm = DIV_ROUND_UP(espi->spibrg, hz * 16 * 4) - 1;
 
 		WARN_ONCE(pm > 15,
 			  "%s: Requested speed is too low: %u Hz. Will use %u Hz instead.\n",
 			  dev_name(&spi->dev), hz,
-			  mpc8xxx_spi->spibrg / (4 * 16 * (15 + 1)));
+			  espi->spibrg / (4 * 16 * (15 + 1)));
 		if (pm > 15)
 			pm = 15;
 	}
@@ -310,77 +329,77 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 
 	/* don't write the mode register if the mode doesn't change */
 	if (cs->hw_mode != hw_mode_old)
-		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(spi->chip_select),
+		fsl_espi_write_reg(espi, ESPI_SPMODEx(spi->chip_select),
 				   cs->hw_mode);
 }
 
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
 	u32 mask, spcom;
 	int ret;
 
-	mpc8xxx_spi->rx_len = t->len;
-	mpc8xxx_spi->tx_len = t->len;
+	espi->rx_len = t->len;
+	espi->tx_len = t->len;
 
-	mpc8xxx_spi->tx = t->tx_buf;
-	mpc8xxx_spi->rx = t->rx_buf;
+	espi->tx = t->tx_buf;
+	espi->rx = t->rx_buf;
 
-	reinit_completion(&mpc8xxx_spi->done);
+	reinit_completion(&espi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
 	spcom = SPCOM_CS(spi->chip_select);
 	spcom |= SPCOM_TRANLEN(t->len - 1);
 
 	/* configure RXSKIP mode */
-	if (mpc8xxx_spi->rxskip) {
-		spcom |= SPCOM_RXSKIP(mpc8xxx_spi->rxskip);
-		mpc8xxx_spi->tx_len = mpc8xxx_spi->rxskip;
-		mpc8xxx_spi->rx_len = t->len - mpc8xxx_spi->rxskip;
-		mpc8xxx_spi->rx = t->rx_buf + mpc8xxx_spi->rxskip;
+	if (espi->rxskip) {
+		spcom |= SPCOM_RXSKIP(espi->rxskip);
+		espi->tx_len = espi->rxskip;
+		espi->rx_len = t->len - espi->rxskip;
+		espi->rx = t->rx_buf + espi->rxskip;
 		if (t->rx_nbits == SPI_NBITS_DUAL)
 			spcom |= SPCOM_DO;
 	}
 
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, spcom);
+	fsl_espi_write_reg(espi, ESPI_SPCOM, spcom);
 
 	/* enable interrupts */
 	mask = SPIM_DON;
-	if (mpc8xxx_spi->rx_len > FSL_ESPI_FIFO_SIZE)
+	if (espi->rx_len > FSL_ESPI_FIFO_SIZE)
 		mask |= SPIM_RXT;
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, mask);
+	fsl_espi_write_reg(espi, ESPI_SPIM, mask);
 
 	/* Prevent filling the fifo from getting interrupted */
-	spin_lock_irq(&mpc8xxx_spi->lock);
-	fsl_espi_fill_tx_fifo(mpc8xxx_spi, 0);
-	spin_unlock_irq(&mpc8xxx_spi->lock);
+	spin_lock_irq(&espi->lock);
+	fsl_espi_fill_tx_fifo(espi, 0);
+	spin_unlock_irq(&espi->lock);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
-	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
+	ret = wait_for_completion_timeout(&espi->done, 2 * HZ);
 	if (ret == 0)
-		dev_err(mpc8xxx_spi->dev,
+		dev_err(espi->dev,
 			"Transaction hanging up (left %u tx bytes, %u rx bytes)\n",
-			mpc8xxx_spi->tx_len, mpc8xxx_spi->rx_len);
+			espi->tx_len, espi->rx_len);
 
 	/* disable rx ints */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
+	fsl_espi_write_reg(espi, ESPI_SPIM, 0);
 
 	return ret == 0 ? -ETIMEDOUT : 0;
 }
 
 static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 {
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
+	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
 	struct spi_device *spi = m->spi;
 	int ret;
 
-	mspi->rxskip = fsl_espi_check_rxskip_mode(m);
-	if (trans->rx_nbits == SPI_NBITS_DUAL && !mspi->rxskip) {
-		dev_err(mspi->dev, "Dual output mode requires RXSKIP mode!\n");
+	espi->rxskip = fsl_espi_check_rxskip_mode(m);
+	if (trans->rx_nbits == SPI_NBITS_DUAL && !espi->rxskip) {
+		dev_err(espi->dev, "Dual output mode requires RXSKIP mode!\n");
 		return -EINVAL;
 	}
 
-	fsl_espi_copy_to_buf(m, mspi);
+	fsl_espi_copy_to_buf(m, espi);
 	fsl_espi_setup_transfer(spi, trans);
 
 	ret = fsl_espi_bufs(spi, trans);
@@ -389,7 +408,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 		udelay(trans->delay_usecs);
 
 	if (!ret)
-		fsl_espi_copy_from_buf(m, mspi);
+		fsl_espi_copy_from_buf(m, espi);
 
 	return ret;
 }
@@ -397,7 +416,7 @@ static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
+	struct fsl_espi *espi = spi_master_get_devdata(m->spi->master);
 	unsigned int delay_usecs = 0, rx_nbits = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
@@ -420,8 +439,8 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	trans.speed_hz = t->speed_hz;
 	trans.bits_per_word = t->bits_per_word;
 	trans.delay_usecs = delay_usecs;
-	trans.tx_buf = mspi->local_buf;
-	trans.rx_buf = mspi->local_buf;
+	trans.tx_buf = espi->local_buf;
+	trans.rx_buf = espi->local_buf;
 	trans.rx_nbits = rx_nbits;
 
 	if (trans.len)
@@ -439,7 +458,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 
 static int fsl_espi_setup(struct spi_device *spi)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi *espi;
 	u32 loop_mode;
 	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
@@ -453,12 +472,11 @@ static int fsl_espi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, cs);
 	}
 
-	mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	espi = spi_master_get_devdata(spi->master);
 
-	pm_runtime_get_sync(mpc8xxx_spi->dev);
+	pm_runtime_get_sync(espi->dev);
 
-	cs->hw_mode = fsl_espi_read_reg(mpc8xxx_spi,
-					   ESPI_SPMODEx(spi->chip_select));
+	cs->hw_mode = fsl_espi_read_reg(espi, ESPI_SPMODEx(spi->chip_select));
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_CP_BEGIN_EDGECLK | CSMODE_CI_INACTIVEHIGH
 			 | CSMODE_REV);
@@ -471,16 +489,16 @@ static int fsl_espi_setup(struct spi_device *spi)
 		cs->hw_mode |= CSMODE_REV;
 
 	/* Handle the loop mode */
-	loop_mode = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
+	loop_mode = fsl_espi_read_reg(espi, ESPI_SPMODE);
 	loop_mode &= ~SPMODE_LOOP;
 	if (spi->mode & SPI_LOOP)
 		loop_mode |= SPMODE_LOOP;
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, loop_mode);
+	fsl_espi_write_reg(espi, ESPI_SPMODE, loop_mode);
 
 	fsl_espi_setup_transfer(spi, NULL);
 
-	pm_runtime_mark_last_busy(mpc8xxx_spi->dev);
-	pm_runtime_put_autosuspend(mpc8xxx_spi->dev);
+	pm_runtime_mark_last_busy(espi->dev);
+	pm_runtime_put_autosuspend(espi->dev);
 
 	return 0;
 }
@@ -493,52 +511,52 @@ static void fsl_espi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
-static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
+static void fsl_espi_cpu_irq(struct fsl_espi *espi, u32 events)
 {
-	if (mspi->rx_len)
-		fsl_espi_read_rx_fifo(mspi, events);
+	if (espi->rx_len)
+		fsl_espi_read_rx_fifo(espi, events);
 
-	if (mspi->tx_len)
-		fsl_espi_fill_tx_fifo(mspi, events);
+	if (espi->tx_len)
+		fsl_espi_fill_tx_fifo(espi, events);
 
-	if (mspi->tx_len || mspi->rx_len)
+	if (espi->tx_len || espi->rx_len)
 		return;
 
 	/* we're done, but check for errors before returning */
-	events = fsl_espi_read_reg(mspi, ESPI_SPIE);
+	events = fsl_espi_read_reg(espi, ESPI_SPIE);
 
 	if (!(events & SPIE_DON))
-		dev_err(mspi->dev,
+		dev_err(espi->dev,
 			"Transfer done but SPIE_DON isn't set!\n");
 
 	if (SPIE_RXCNT(events) || SPIE_TXCNT(events) != FSL_ESPI_FIFO_SIZE)
-		dev_err(mspi->dev, "Transfer done but rx/tx fifo's aren't empty!\n");
+		dev_err(espi->dev, "Transfer done but rx/tx fifo's aren't empty!\n");
 
-	complete(&mspi->done);
+	complete(&espi->done);
 }
 
 static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 {
-	struct mpc8xxx_spi *mspi = context_data;
+	struct fsl_espi *espi = context_data;
 	u32 events;
 
-	spin_lock(&mspi->lock);
+	spin_lock(&espi->lock);
 
 	/* Get interrupt events(tx/rx) */
-	events = fsl_espi_read_reg(mspi, ESPI_SPIE);
+	events = fsl_espi_read_reg(espi, ESPI_SPIE);
 	if (!events) {
-		spin_unlock(&mspi->lock);
+		spin_unlock(&espi->lock);
 		return IRQ_NONE;
 	}
 
-	dev_vdbg(mspi->dev, "%s: events %x\n", __func__, events);
+	dev_vdbg(espi->dev, "%s: events %x\n", __func__, events);
 
-	fsl_espi_cpu_irq(mspi, events);
+	fsl_espi_cpu_irq(espi, events);
 
 	/* Clear the events */
-	fsl_espi_write_reg(mspi, ESPI_SPIE, events);
+	fsl_espi_write_reg(espi, ESPI_SPIE, events);
 
-	spin_unlock(&mspi->lock);
+	spin_unlock(&espi->lock);
 
 	return IRQ_HANDLED;
 }
@@ -547,12 +565,12 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 static int fsl_espi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct fsl_espi *espi = spi_master_get_devdata(master);
 	u32 regval;
 
-	regval = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
+	regval = fsl_espi_read_reg(espi, ESPI_SPMODE);
 	regval &= ~SPMODE_ENABLE;
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
+	fsl_espi_write_reg(espi, ESPI_SPMODE, regval);
 
 	return 0;
 }
@@ -560,12 +578,12 @@ static int fsl_espi_runtime_suspend(struct device *dev)
 static int fsl_espi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
+	struct fsl_espi *espi = spi_master_get_devdata(master);
 	u32 regval;
 
-	regval = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
+	regval = fsl_espi_read_reg(espi, ESPI_SPMODE);
 	regval |= SPMODE_ENABLE;
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
+	fsl_espi_write_reg(espi, ESPI_SPMODE, regval);
 
 	return 0;
 }
@@ -579,16 +597,16 @@ static size_t fsl_espi_max_message_size(struct spi_device *spi)
 static void fsl_espi_init_regs(struct device *dev, bool initial)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(master);
+	struct fsl_espi *espi = spi_master_get_devdata(master);
 	struct device_node *nc;
 	u32 csmode, cs, prop;
 	int ret;
 
 	/* SPI controller initializations */
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, 0);
-	fsl_espi_write_reg(mspi, ESPI_SPIM, 0);
-	fsl_espi_write_reg(mspi, ESPI_SPCOM, 0);
-	fsl_espi_write_reg(mspi, ESPI_SPIE, 0xffffffff);
+	fsl_espi_write_reg(espi, ESPI_SPMODE, 0);
+	fsl_espi_write_reg(espi, ESPI_SPIM, 0);
+	fsl_espi_write_reg(espi, ESPI_SPCOM, 0);
+	fsl_espi_write_reg(espi, ESPI_SPIE, 0xffffffff);
 
 	/* Init eSPI CS mode register */
 	for_each_available_child_of_node(master->dev.of_node, nc) {
@@ -613,24 +631,24 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
 			csmode |= CSMODE_AFT(prop);
 		}
 
-		fsl_espi_write_reg(mspi, ESPI_SPMODEx(cs), csmode);
+		fsl_espi_write_reg(espi, ESPI_SPMODEx(cs), csmode);
 
 		if (initial)
 			dev_info(dev, "cs=%u, init_csmode=0x%x\n", cs, csmode);
 	}
 
 	/* Enable SPI interface */
-	fsl_espi_write_reg(mspi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
+	fsl_espi_write_reg(espi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
 }
 
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
 			  unsigned int irq, unsigned int num_cs)
 {
 	struct spi_master *master;
-	struct mpc8xxx_spi *mpc8xxx_spi;
+	struct fsl_espi *espi;
 	int ret;
 
-	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
+	master = spi_alloc_master(dev, sizeof(struct fsl_espi));
 	if (!master)
 		return -ENOMEM;
 
@@ -647,35 +665,33 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	master->max_message_size = fsl_espi_max_message_size;
 	master->num_chipselect = num_cs;
 
-	mpc8xxx_spi = spi_master_get_devdata(master);
-	spin_lock_init(&mpc8xxx_spi->lock);
+	espi = spi_master_get_devdata(master);
+	spin_lock_init(&espi->lock);
 
-	mpc8xxx_spi->dev = dev;
-	mpc8xxx_spi->spibrg = fsl_get_sys_freq();
-	if (mpc8xxx_spi->spibrg == -1) {
+	espi->dev = dev;
+	espi->spibrg = fsl_get_sys_freq();
+	if (espi->spibrg == -1) {
 		dev_err(dev, "Can't get sys frequency!\n");
 		ret = -EINVAL;
 		goto err_probe;
 	}
 
-	init_completion(&mpc8xxx_spi->done);
+	init_completion(&espi->done);
 
-	mpc8xxx_spi->local_buf =
-		devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
-	if (!mpc8xxx_spi->local_buf) {
+	espi->local_buf = devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
+	if (!espi->local_buf) {
 		ret = -ENOMEM;
 		goto err_probe;
 	}
 
-	mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(mpc8xxx_spi->reg_base)) {
-		ret = PTR_ERR(mpc8xxx_spi->reg_base);
+	espi->reg_base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(espi->reg_base)) {
+		ret = PTR_ERR(espi->reg_base);
 		goto err_probe;
 	}
 
 	/* Register for SPI Interrupt */
-	ret = devm_request_irq(dev, irq, fsl_espi_irq, 0, "fsl_espi",
-			       mpc8xxx_spi);
+	ret = devm_request_irq(dev, irq, fsl_espi_irq, 0, "fsl_espi", espi);
 	if (ret)
 		goto err_probe;
 
@@ -691,7 +707,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	if (ret < 0)
 		goto err_pm;
 
-	dev_info(dev, "at 0x%p (irq = %u)\n", mpc8xxx_spi->reg_base, irq);
+	dev_info(dev, "at 0x%p (irq = %u)\n", espi->reg_base, irq);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
