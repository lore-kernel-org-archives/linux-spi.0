From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] OMAP: Add OMAP24XX Multichannel SPI
	controller driver
Date: Wed, 20 Jun 2007 16:30:03 -0700
Message-ID: <200706201630.04647.david-b@pacbell.net>
References: <5d5443650706182323k4cc99707v8ad8dc5cff24ca3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: "Trilok Soni" <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5d5443650706182323k4cc99707v8ad8dc5cff24ca3e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

That's pretty much the latest from omap-git, right?

If so, please try the appended patch, which includes various
bugfixes and cleanups I've had in my queue for a while.

- Dave


==============
More updates:

  Bugfixes:
    - Address "last RX-only PIO read" issue noted by Imre
    - Track number of bytes transferred, and return the total
    - Report short transfers as I/O errors
    - Use DMA automatically on larger transfers (vs virtually never)

  Cleanups:
    - Move code from PIO and DMA per-transfer code to work loop:
	    * device enable/disable
	    * RX_ONLY tx data init
	    * channel config updates
    - Move DMA mapping from work loop to pre-submit logic
    - Queue work before dropping the queue lock
    - Use "void __iomem *" for pio addresses, not "unsigned long"
    - Compute register bank base address just once
    - A few more whitespace tweaks

Those cleanups save more code space, mostly on the critical I/O path.

The DMA stuff is a bugfix, since the previous interpretation of the API
was contrary to spec and intention.  Needing a heuristic is annoying,
but seems inescapable.

---
 drivers/spi/omap2_mcspi.c |  232 +++++++++++++++++++++++++---------------------
 1 file changed, 131 insertions(+), 101 deletions(-)

--- h4.orig/drivers/spi/omap2_mcspi.c	2007-05-31 17:01:08.000000000 -0700
+++ h4/drivers/spi/omap2_mcspi.c	2007-05-31 22:58:39.000000000 -0700
@@ -38,6 +38,7 @@
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
 
+
 #define OMAP2_MCSPI_MAX_FREQ		48000000
 
 #define OMAP2_MCSPI_REVISION		0x00
@@ -102,6 +103,12 @@ struct omap2_mcspi_dma {
 	struct completion dma_rx_completion;
 };
 
+/* use PIO for small transfers, avoiding DMA setup/teardown overhead and
+ * cache operations; better heuristics consider wordsize and bitrate.
+ */
+#define DMA_MIN_BYTES			8
+
+
 struct omap2_mcspi {
 	struct work_struct	work;
 	spinlock_t		lock;
@@ -110,17 +117,17 @@ struct omap2_mcspi {
 	struct clk		*ick;
 	struct clk		*fck;
 	/* Virtual base address of the controller */
-	unsigned long		base;
+	void __iomem		*base;
 	/* SPI1 has 4 channels, while SPI2 has 2 */
 	struct omap2_mcspi_dma	*dma_channels;
 };
 
 struct omap2_mcspi_cs {
-	u8 transmit_mode;
-	int word_len;
+	void __iomem		*base;
+	int			word_len;
 };
 
-static struct workqueue_struct * omap2_mcspi_wq;
+static struct workqueue_struct *omap2_mcspi_wq;
 
 #define MOD_REG_BIT(val, mask, set) do { \
 	if (set) \
@@ -137,8 +144,7 @@ static inline void mcspi_write_reg(struc
 	__raw_writel(val, mcspi->base + idx);
 }
 
-static inline u32 mcspi_read_reg(struct spi_master *master,
-		int idx)
+static inline u32 mcspi_read_reg(struct spi_master *master, int idx)
 {
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
@@ -148,17 +154,16 @@ static inline u32 mcspi_read_reg(struct 
 static inline void mcspi_write_cs_reg(const struct spi_device *spi,
 		int idx, u32 val)
 {
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_cs	*cs = spi->controller_state;
 
-	__raw_writel(val, mcspi->base + spi->chip_select * 0x14 + idx);
+	__raw_writel(val, cs->base +  idx);
 }
 
-static inline u32 mcspi_read_cs_reg(const struct spi_device *spi,
-		int idx)
+static inline u32 mcspi_read_cs_reg(const struct spi_device *spi, int idx)
 {
-	struct omap2_mcspi *mcspi = spi_master_get_devdata(spi->master);
+	struct omap2_mcspi_cs	*cs = spi->controller_state;
 
-	return __raw_readl(mcspi->base + spi->chip_select * 0x14 + idx);
+	return __raw_readl(cs->base + idx);
 }
 
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
@@ -208,7 +213,7 @@ static void omap2_mcspi_set_master_mode(
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
 }
 
-static void
+static unsigned
 omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct omap2_mcspi	*mcspi;
@@ -219,7 +224,6 @@ omap2_mcspi_txrx_dma(struct spi_device *
 	int			word_len, data_type, element_count;
 	u8			* rx;
 	const u8		* tx;
-	u32			l;
 
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
@@ -228,17 +232,7 @@ omap2_mcspi_txrx_dma(struct spi_device *
 	c = count;
 	word_len = cs->word_len;
 
-	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
-	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
-	if (xfer->tx_buf == NULL)
-		l |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
-	else if (xfer->rx_buf == NULL)
-		l |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
-
-	omap2_mcspi_set_enable(spi, 1);
-
-	base = io_v2p(mcspi->base) + spi->chip_select * 0x14;
+	base = (unsigned long) io_v2p(cs->base);
 	tx_reg = base + OMAP2_MCSPI_TX0;
 	rx_reg = base + OMAP2_MCSPI_RX0;
 	rx = xfer->rx_buf;
@@ -250,26 +244,12 @@ omap2_mcspi_txrx_dma(struct spi_device *
 	} else if (word_len <= 16) {
 		data_type = OMAP_DMA_DATA_TYPE_S16;
 		element_count = count >> 1;
-	} else if (word_len <= 32) {
+	} else /* word_len <= 32 */ {
 		data_type = OMAP_DMA_DATA_TYPE_S32;
 		element_count = count >> 2;
-	} else
-		goto out;
-
-	/* RX_ONLY mode needs dummy data in TX reg */
-	if (tx == NULL)
-		__raw_writel(0, mcspi->base
-					+ spi->chip_select * 0x14
-					+ OMAP2_MCSPI_TX0);
+	}
 
 	if (tx != NULL) {
-		xfer->tx_dma = dma_map_single(&spi->dev, (void *) tx, count,
-				DMA_TO_DEVICE);
-		if (dma_mapping_error(xfer->tx_dma)) {
-			dev_err(&spi->dev, "dma TX %d bytes error\n", count);
-			return;
-		}
-
 		omap_set_dma_transfer_params(mcspi_dma->dma_tx_channel,
 				data_type, element_count, 1,
 				OMAP_DMA_SYNC_ELEMENT,
@@ -285,16 +265,6 @@ omap2_mcspi_txrx_dma(struct spi_device *
 	}
 
 	if (rx != NULL) {
-		xfer->rx_dma = dma_map_single(&spi->dev, rx, count,
-				DMA_FROM_DEVICE);
-		if (dma_mapping_error(xfer->rx_dma)) {
-			dev_err(&spi->dev, "dma RX %d bytes error\n", count);
-			if (tx != NULL)
-				dma_unmap_single(NULL, xfer->tx_dma,
-						count, DMA_TO_DEVICE);
-			goto out;
-		}
-
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
 				data_type, element_count, 1,
 				OMAP_DMA_SYNC_ELEMENT,
@@ -328,11 +298,10 @@ omap2_mcspi_txrx_dma(struct spi_device *
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
 	}
-out:
-	omap2_mcspi_set_enable(spi, 0);
+	return count;
 }
 
-static int mcspi_wait_for_reg_bit(unsigned long reg, unsigned long bit)
+static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
 	unsigned long timeout;
 
@@ -344,14 +313,17 @@ static int mcspi_wait_for_reg_bit(unsign
 	return 0;
 }
 
-static void
+static unsigned
 omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_cs	*cs = spi->controller_state;
 	unsigned int		count, c;
 	u32			l;
-	unsigned long		base, tx_reg, rx_reg, chstat_reg;
+	void __iomem		*base = cs->base;
+	void __iomem		*tx_reg;
+	void __iomem		*rx_reg;
+	void __iomem		*chstat_reg;
 	int			word_len;
 
 	mcspi = spi_master_get_devdata(spi->master);
@@ -361,29 +333,13 @@ omap2_mcspi_txrx_pio(struct spi_device *
 
 	l = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
 	l &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
-	if (xfer->tx_buf == NULL)
-		l |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
-	else if (xfer->rx_buf == NULL)
-		l |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
-	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
-
-	omap2_mcspi_set_enable(spi, 1);
 
 	/* We store the pre-calculated register addresses on stack to speed
 	 * up the transfer loop. */
-	base = mcspi->base + spi->chip_select * 0x14;
 	tx_reg		= base + OMAP2_MCSPI_TX0;
 	rx_reg		= base + OMAP2_MCSPI_RX0;
 	chstat_reg	= base + OMAP2_MCSPI_CHSTAT0;
 
-	/* RX_ONLY mode needs dummy data in TX reg.   If we were using
-	 * TURBO mode (double buffered) we'd need to disable the channel
-	 * before reading the penultimate word ... so TURBO wouldn't be an
-	 * option except for the last transfer, else if cs_change is set.
-	 */
-	if (xfer->tx_buf == NULL)
-		__raw_writel(0, tx_reg);
-
 	if (word_len <= 8) {
 		u8		*rx;
 		const u8	*tx;
@@ -391,7 +347,7 @@ omap2_mcspi_txrx_pio(struct spi_device *
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 
-		while (c--) {
+		do {
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -410,21 +366,27 @@ omap2_mcspi_txrx_pio(struct spi_device *
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
+				/* prevent last RX_ONLY read from triggering
+				 * more word i/o: switch to rx+tx
+				 */
+				if (c == 0 && tx == NULL)
+					mcspi_write_cs_reg(spi,
+							OMAP2_MCSPI_CHCONF0, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %02x\n",
 						word_len, *(rx - 1));
 #endif
 			}
-		}
+			c -= 1;
+		} while (c);
 	} else if (word_len <= 16) {
 		u16		*rx;
 		const u16	*tx;
 
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
-		c >>= 1;
-		while (c--) {
+		do {
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -443,21 +405,27 @@ omap2_mcspi_txrx_pio(struct spi_device *
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
+				/* prevent last RX_ONLY read from triggering
+				 * more word i/o: switch to rx+tx
+				 */
+				if (c == 0 && tx == NULL)
+					mcspi_write_cs_reg(spi,
+							OMAP2_MCSPI_CHCONF0, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 #endif
 			}
-		}
+			c -= 2;
+		} while (c);
 	} else if (word_len <= 32) {
 		u32		*rx;
 		const u32	*tx;
 
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
-		c >>= 2;
-		while (c--) {
+		do {
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -476,13 +444,20 @@ omap2_mcspi_txrx_pio(struct spi_device *
 					dev_err(&spi->dev, "RXS timed out\n");
 					goto out;
 				}
+				/* prevent last RX_ONLY read from triggering
+				 * more word i/o: switch to rx+tx
+				 */
+				if (c == 0 && tx == NULL)
+					mcspi_write_cs_reg(spi,
+							OMAP2_MCSPI_CHCONF0, l);
 				*rx++ = __raw_readl(rx_reg);
 #ifdef VERBOSE
 				dev_dbg(&spi->dev, "read-%d %04x\n",
 						word_len, *(rx - 1));
 #endif
 			}
-		}
+			c -= 4;
+		} while (c);
 	}
 
 	/* for TX_ONLY mode, be sure all words have shifted out */
@@ -490,14 +465,12 @@ omap2_mcspi_txrx_pio(struct spi_device *
 		if (mcspi_wait_for_reg_bit(chstat_reg,
 				OMAP2_MCSPI_CHSTAT_TXS) < 0) {
 			dev_err(&spi->dev, "TXS timed out\n");
-			goto out;
-		}
-		if (mcspi_wait_for_reg_bit(chstat_reg,
+		} else if (mcspi_wait_for_reg_bit(chstat_reg,
 				OMAP2_MCSPI_CHSTAT_EOT) < 0)
 			dev_err(&spi->dev, "EOT timed out\n");
-out:
-		omap2_mcspi_set_enable(spi, 0);
 	}
+out:
+	return count - c;
 }
 
 /* called only when no transfer is active to this device */
@@ -657,6 +630,7 @@ static int omap2_mcspi_setup(struct spi_
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
+		cs->base = mcspi->base + spi->chip_select * 0x14;
 		spi->controller_state = cs;
 	}
 
@@ -721,7 +695,8 @@ static void omap2_mcspi_work(struct work
 		struct omap2_mcspi_device_config *conf;
 		struct omap2_mcspi_cs		*cs;
 		int				par_override = 0;
-		int status = 0;
+		int				status = 0;
+		u32				chconf;
 
 		m = container_of(mcspi->msg_queue.next, struct spi_message,
 				 queue);
@@ -733,6 +708,7 @@ static void omap2_mcspi_work(struct work
 		conf = spi->controller_data;
 		cs = spi->controller_state;
 
+		omap2_mcspi_set_enable(spi, 1);
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
 				status = -EINVAL;
@@ -752,16 +728,37 @@ static void omap2_mcspi_work(struct work
 				cs_active = 1;
 			}
 
-			if (m->is_dma_mapped
-					&& (t->tx_dma != 0 || t->rx_dma != 0))
-				omap2_mcspi_txrx_dma(spi, t);
-			else
-				omap2_mcspi_txrx_pio(spi, t);
+			chconf = mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
+			chconf &= ~OMAP2_MCSPI_CHCONF_TRM_MASK;
+			if (t->tx_buf == NULL)
+				chconf |= OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
+			else if (t->rx_buf == NULL)
+				chconf |= OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
+			mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, chconf);
+
+			if (t->len) {
+				unsigned	count;
+
+				/* RX_ONLY mode needs dummy data in TX reg */
+				if (t->tx_buf == NULL)
+					__raw_writel(0, cs->base + OMAP2_MCSPI_TX0);
+
+				if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
+					count = omap2_mcspi_txrx_dma(spi, t);
+				else
+					count = omap2_mcspi_txrx_pio(spi, t);
+				m->actual_length += count;
+
+				if (count != t->len) {
+					status = -EIO;
+					break;
+				}
+			}
 
 			if (t->delay_usecs)
 				udelay(t->delay_usecs);
 
-			/* this ignores the "leave it on after last xfer" hint */
+			/* ignore the "leave it on after last xfer" hint */
 			if (t->cs_change) {
 				omap2_mcspi_force_cs(spi, 0);
 				cs_active = 0;
@@ -777,6 +774,8 @@ static void omap2_mcspi_work(struct work
 		if (cs_active)
 			omap2_mcspi_force_cs(spi, 0);
 
+		omap2_mcspi_set_enable(spi, 0);
+
 		m->status = status;
 		m->complete(m->context);
 
@@ -802,36 +801,67 @@ static int omap2_mcspi_transfer(struct s
 	if (list_empty(&m->transfers) || !m->complete)
 		return -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		const void	*tx_buf = t->tx_buf;
+		void		*rx_buf = t->rx_buf;
+		unsigned	len = t->len;
+
 		if (t->speed_hz > OMAP2_MCSPI_MAX_FREQ
-				|| (t->len && !(t->rx_buf || t->tx_buf))
+				|| (len && !(rx_buf || tx_buf))
 				|| (t->bits_per_word &&
 					(  t->bits_per_word < 4
 					|| t->bits_per_word > 32))) {
 			dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
 					t->speed_hz,
-					t->len,
-					t->rx_buf ? "rx" : "",
-					t->tx_buf ? "tx" : "",
+					len,
+					tx_buf ? "tx" : "",
+					rx_buf ? "rx" : "",
 					t->bits_per_word);
 			return -EINVAL;
 		}
 		if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16)) {
 			dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
 					t->speed_hz,
-					t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16));
+					OMAP2_MCSPI_MAX_FREQ/(1<<16));
 			return -EINVAL;
 		}
 
-		/* REVISIT move dma mapping to here */
+		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
+			continue;
+
+		/* Do DMA mapping "early" for better error reporting and
+		 * dcache use.  Note that if dma_unmap_single() ever starts
+		 * to do real work on ARM, we'd need to clean up mappings
+		 * for previous transfers on *ALL* exits of this loop...
+		 */
+		if (tx_buf != NULL) {
+			t->tx_dma = dma_map_single(&spi->dev, (void *) tx_buf,
+					len, DMA_TO_DEVICE);
+			if (dma_mapping_error(t->tx_dma)) {
+				dev_dbg(&spi->dev, "dma %cX %d bytes error\n",
+						'T', len);
+				return -EINVAL;
+			}
+		}
+		if (rx_buf != NULL) {
+			t->rx_dma = dma_map_single(&spi->dev, rx_buf, t->len,
+					DMA_FROM_DEVICE);
+			if (dma_mapping_error(t->rx_dma)) {
+				dev_dbg(&spi->dev, "dma %cX %d bytes error\n",
+						'R', len);
+				if (tx_buf != NULL)
+					dma_unmap_single(NULL, t->tx_dma,
+							len, DMA_TO_DEVICE);
+				return -EINVAL;
+			}
+		}
 	}
 
 	mcspi = spi_master_get_devdata(spi->master);
 
 	spin_lock_irqsave(&mcspi->lock, flags);
 	list_add_tail(&m->queue, &mcspi->msg_queue);
-	spin_unlock_irqrestore(&mcspi->lock, flags);
-
 	queue_work(omap2_mcspi_wq, &mcspi->work);
+	spin_unlock_irqrestore(&mcspi->lock, flags);
 
 	return 0;
 }
@@ -940,7 +970,7 @@ static int __init omap2_mcspi_probe(stru
 		goto err1;
 	}
 
-	mcspi->base = io_p2v(r->start);
+	mcspi->base = (void __iomem *) io_p2v(r->start);
 
 	INIT_WORK(&mcspi->work, omap2_mcspi_work);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
