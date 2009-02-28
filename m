From: Balaji Rao <balajirrao@openmoko.org>
Subject: [PATCH 2/2] spi_bitbang: Add support for non-blocking synchronous
	transfers
Date: Sat, 28 Feb 2009 13:41:17 +0530
Message-ID: <20090228081117.31964.51155.stgit@fedora.yogi>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Andy Green <andy@openmoko.com>,
	Simon Kagstrom <simon.kagstrom@gmail.com>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754810AbZB1IMo@vger.kernel.org>
In-Reply-To: <20090228081036.31964.80618.stgit@fedora.yogi>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The synchronous transfer code in bitbang_work workqueue function is
refactored into a spearate function which optionally becomes the master's
transfer_sync method.

Some initial part of the work was done by Simon Kagstrom.

Signed-off-by: Balaji Rao <balajirrao@openmoko.org>
Signed-off-by: Simon Kagstrom <simon.kagstrom@gmail.com>
Cc: Andy Green <andy@openmoko.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: spi-devel-general@lists.sourceforge.net
---
 drivers/spi/spi_bitbang.c       |  227 +++++++++++++++++++++------------------
 include/linux/spi/spi_bitbang.h |    5 +
 2 files changed, 125 insertions(+), 107 deletions(-)

diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 85e61f4..39dd736 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -264,130 +264,140 @@ static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
  * Drivers can provide word-at-a-time i/o primitives, or provide
  * transfer-at-a-time ones to leverage dma or fifo hardware.
  */
-static void bitbang_work(struct work_struct *work)
-{
-	struct spi_bitbang	*bitbang =
-		container_of(work, struct spi_bitbang, work);
-	unsigned long		flags;
-
-	spin_lock_irqsave(&bitbang->lock, flags);
-	bitbang->busy = 1;
-	while (!list_empty(&bitbang->queue)) {
-		struct spi_message	*m;
-		struct spi_device	*spi;
-		unsigned		nsecs;
-		struct spi_transfer	*t = NULL;
-		unsigned		tmp;
-		unsigned		cs_change;
-		int			status;
-		int			(*setup_transfer)(struct spi_device *,
-						struct spi_transfer *);
 
-		m = container_of(bitbang->queue.next, struct spi_message,
-				queue);
-		list_del_init(&m->queue);
-		spin_unlock_irqrestore(&bitbang->lock, flags);
+/* Synchronous non blocking transfer */
+int
+spi_bitbang_transfer_sync(struct spi_device *spi, struct spi_message *m)
+{
+	struct spi_bitbang *bitbang = spi_master_get_devdata(spi->master);
+	struct spi_transfer *t;
+	unsigned long flags;
+	int cs_change = 1;
+	int status;
+	int nsecs;
+	int (*setup_transfer)(struct spi_device *, struct spi_transfer *);
+
+	/* FIXME this is made-up ... the correct value is known to
+	 * word-at-a-time bitbang code, and presumably chipselect()
+	 * should enforce these requirements too?
+	 */
+	nsecs = 100;
+	cs_change = 1;
+	status = 0;
+	setup_transfer = NULL;
+
+	local_irq_save(flags);
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		/* override or restore speed and wordsize */
+		if (t->speed_hz || t->bits_per_word) {
+			setup_transfer = bitbang->setup_transfer;
+			if (!setup_transfer) {
+				status = -ENOPROTOOPT;
+				break;
+			}
+		}
+		if (setup_transfer) {
+			status = setup_transfer(spi, t);
+			if (status < 0)
+				break;
+		}
 
-		/* FIXME this is made-up ... the correct value is known to
-		 * word-at-a-time bitbang code, and presumably chipselect()
-		 * should enforce these requirements too?
+		/* set up default clock polarity, and activate chip;
+		 * this implicitly updates clock and spi modes as
+		 * previously recorded for this device via setup().
+		 * (and also deselects any other chip that might be
+		 * selected ...)
 		 */
-		nsecs = 100;
-
-		spi = m->spi;
-		tmp = 0;
-		cs_change = 1;
-		status = 0;
-		setup_transfer = NULL;
 
-		list_for_each_entry (t, &m->transfers, transfer_list) {
-
-			/* override or restore speed and wordsize */
-			if (t->speed_hz || t->bits_per_word) {
-				setup_transfer = bitbang->setup_transfer;
-				if (!setup_transfer) {
-					status = -ENOPROTOOPT;
-					break;
-				}
-			}
-			if (setup_transfer) {
-				status = setup_transfer(spi, t);
-				if (status < 0)
-					break;
-			}
+		if (cs_change) {
+			bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
+			ndelay(nsecs);
+		}
 
-			/* set up default clock polarity, and activate chip;
-			 * this implicitly updates clock and spi modes as
-			 * previously recorded for this device via setup().
-			 * (and also deselects any other chip that might be
-			 * selected ...)
-			 */
-			if (cs_change) {
-				bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
-				ndelay(nsecs);
-			}
-			cs_change = t->cs_change;
-			if (!t->tx_buf && !t->rx_buf && t->len) {
-				status = -EINVAL;
-				break;
-			}
+		cs_change = t->cs_change;
+		if (!t->tx_buf && !t->rx_buf && t->len) {
+			status = -EINVAL;
+			break;
+		}
 
-			/* transfer data.  the lower level code handles any
-			 * new dma mappings it needs. our caller always gave
-			 * us dma-safe buffers.
+		/* transfer data.  the lower level code handles any
+		 * new dma mappings it needs. our caller always gave
+		 * us dma-safe buffers.
+		 */
+		if (t->len) {
+			/* REVISIT dma API still needs a designated
+			 * DMA_ADDR_INVALID; ~0 might be better.
 			 */
-			if (t->len) {
-				/* REVISIT dma API still needs a designated
-				 * DMA_ADDR_INVALID; ~0 might be better.
-				 */
-				if (!m->is_dma_mapped)
-					t->rx_dma = t->tx_dma = 0;
-				status = bitbang->txrx_bufs(spi, t);
-			}
-			if (status > 0)
-				m->actual_length += status;
-			if (status != t->len) {
-				/* always report some kind of error */
-				if (status >= 0)
-					status = -EREMOTEIO;
-				break;
-			}
-			status = 0;
+			if (!m->is_dma_mapped)
+				t->rx_dma = t->tx_dma = 0;
+			status = bitbang->txrx_bufs(spi, t);
+		}
 
+		if (status > 0)
+			m->actual_length += status;
+		if (status != t->len) {
+			/* always report some kind of error */
+			if (status >= 0)
+				status = -EREMOTEIO;
+			break;
+		}
+		status = 0;
 			/* protocol tweaks before next transfer */
-			if (t->delay_usecs)
-				udelay(t->delay_usecs);
-
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
 			if (!cs_change)
 				continue;
-			if (t->transfer_list.next == &m->transfers)
-				break;
-
+		if (t->transfer_list.next == &m->transfers)
+			break;
 			/* sometimes a short mid-message deselect of the chip
-			 * may be needed to terminate a mode or command
-			 */
-			ndelay(nsecs);
-			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-			ndelay(nsecs);
-		}
+		 * may be needed to terminate a mode or command
+		 */
+		ndelay(nsecs);
+		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+		ndelay(nsecs);
+	}
 
-		m->status = status;
+	m->status = status;
+	if (m->complete)
 		m->complete(m->context);
 
-		/* restore speed and wordsize */
-		if (setup_transfer)
-			setup_transfer(spi, NULL);
+	/* restore speed and wordsize */
+	if (setup_transfer)
+		setup_transfer(spi, NULL);
 
-		/* normally deactivate chipselect ... unless no error and
-		 * cs_change has hinted that the next message will probably
-		 * be for this chip too.
-		 */
-		if (!(status == 0 && cs_change)) {
-			ndelay(nsecs);
-			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-			ndelay(nsecs);
-		}
+	/* normally deactivate chipselect ... unless no error and
+	 * cs_change has hinted that the next message will probably
+	 * be for this chip too.
+	 */
+	if (!(status == 0 && cs_change)) {
+		ndelay(nsecs);
+		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+		ndelay(nsecs);
+	}
 
+	local_irq_restore(flags);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_transfer_sync);
+
+static void bitbang_work(struct work_struct *work)
+{
+	struct spi_bitbang	*bitbang =
+		container_of(work, struct spi_bitbang, work);
+	unsigned long		flags;
+
+	spin_lock_irqsave(&bitbang->lock, flags);
+	bitbang->busy = 1;
+	while (!list_empty(&bitbang->queue)) {
+		struct spi_message	*m;
+
+		m = container_of(bitbang->queue.next, struct spi_message,
+				queue);
+		list_del_init(&m->queue);
+
+		spin_unlock_irqrestore(&bitbang->lock, flags);
+		spi_bitbang_transfer_sync(m->spi, m);
 		spin_lock_irqsave(&bitbang->lock, flags);
 	}
 	bitbang->busy = 0;
@@ -459,6 +469,9 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 
 	if (!bitbang->master->transfer)
 		bitbang->master->transfer = spi_bitbang_transfer;
+	if (!bitbang->master->transfer_sync && bitbang->non_blocking_transfer)
+		bitbang->master->transfer_sync = spi_bitbang_transfer_sync;
+
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index eed4254..b99ed8d 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -31,6 +31,9 @@ struct spi_bitbang {
 	u8			use_dma;
 	u8			flags;		/* extra spi->mode support */
 
+	/* Support for synchronous non blocking transfers */
+	int 			non_blocking_transfer;
+
 	struct spi_master	*master;
 
 	/* setup_transfer() changes clock and/or wordsize to match settings
@@ -60,6 +63,8 @@ struct spi_bitbang {
 extern int spi_bitbang_setup(struct spi_device *spi);
 extern void spi_bitbang_cleanup(struct spi_device *spi);
 extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
+extern int spi_bitbang_transfer_sync(struct spi_device *spi,
+				      struct spi_message *m);
 extern int spi_bitbang_setup_transfer(struct spi_device *spi,
 				      struct spi_transfer *t);
 
