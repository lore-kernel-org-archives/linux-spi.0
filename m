From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/13] spi: spi-mxs: Change flag arguments in txrx functions
	to bit flags
Date: Tue, 01 Oct 2013 13:14:50 -0700
Message-ID: <20131001201450.13660.95133.stgit@Graphine>
References: <20131001201425.13660.72740.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131001201425.13660.72740.stgit@Graphine>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There are three flag arguments to the PIO and DMA txrx functions.  Two
are passed as pointers to integers, even though they are input only
and not modified, which makes no sense to do.  The third is passed as
an integer.

The compiler must use an argument register or stack variable for each
flag this way.  Using bitflags in a single flag argument is more
efficient and produces smaller code, since all the flags can fit in a
single register.  And all the flag arguments get cumbersome,
especially when more are added for things like GPIO chipselects.

The "first" flag is never used, so can just be deleted.

The "last" flag is renamed to DEASSERT_CS, since that's really what it
does.  The spi_transfer cs_change flag means that CS might be
de-asserted on a transfer which is not last and not de-assert on the
last transfer, so it is not which transfer is the last we need to know
but rather the transfers after which CS should be de-asserted.

This also extends the driver to not ignore cs_change when setting the
DEASSERT_CS nee "last" flag.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index e2a9cc2..090930a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -57,6 +57,13 @@
 
 #define SG_MAXLEN		0xff00
 
+/*
+ * Flags for txrx functions.  More efficient that using an argument register for
+ * each one.
+ */
+#define TXRX_WRITE		(1<<0)	/* This is a write */
+#define TXRX_DEASSERT_CS	(1<<1)	/* De-assert CS at end of txrx */
+
 struct mxs_spi {
 	struct mxs_ssp		ssp;
 	struct completion	c;
@@ -184,7 +191,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
 
 static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 			    unsigned char *buf, int len,
-			    int *first, int *last, int write)
+			    unsigned int flags)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -214,15 +221,19 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
 	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
 
-	if (!write)
+	if (!(flags & TXRX_WRITE))
 		ctrl0 |= BM_SSP_CTRL0_READ;
 
 	/* Queue the DMA data transfer. */
 	for (sg_count = 0; sg_count < sgs; sg_count++) {
+		/* Prepare the transfer descriptor. */
 		min = min(len, desc_len);
 
-		/* Prepare the transfer descriptor. */
-		if ((sg_count + 1 == sgs) && *last)
+		/*
+		 * De-assert CS on last segment if flag is set (i.e., no more
+		 * transfers will follow)
+		 */
+		if ((sg_count + 1 == sgs) && (flags & TXRX_DEASSERT_CS))
 			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
 
 		if (ssp->devid == IMX23_SSP) {
@@ -247,7 +258,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 		sg_init_one(&dma_xfer[sg_count].sg, sg_buf, min);
 		ret = dma_map_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
-			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 		len -= min;
 		buf += min;
@@ -267,7 +278,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
-				write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 		if (!desc) {
@@ -304,7 +315,7 @@ err_vmalloc:
 	while (--sg_count >= 0) {
 err_mapped:
 		dma_unmap_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
-			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	}
 
 	kfree(dma_xfer);
@@ -314,7 +325,7 @@ err_mapped:
 
 static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 			    unsigned char *buf, int len,
-			    int *first, int *last, int write)
+			    unsigned int flags)
 {
 	struct mxs_ssp *ssp = &spi->ssp;
 
@@ -324,7 +335,7 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 	mxs_spi_set_cs(spi, cs);
 
 	while (len--) {
-		if (*last && len == 0)
+		if (len == 0 && (flags & TXRX_DEASSERT_CS))
 			writel(BM_SSP_CTRL0_IGNORE_CRC,
 			       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
@@ -337,7 +348,7 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 			writel(1, ssp->base + HW_SSP_XFER_SIZE);
 		}
 
-		if (write)
+		if (flags & TXRX_WRITE)
 			writel(BM_SSP_CTRL0_READ,
 				ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 		else
@@ -350,13 +361,13 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 		if (mxs_ssp_wait(spi, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN, 1))
 			return -ETIMEDOUT;
 
-		if (write)
+		if (flags & TXRX_WRITE)
 			writel(*buf, ssp->base + HW_SSP_DATA(ssp));
 
 		writel(BM_SSP_CTRL0_DATA_XFER,
 			     ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
-		if (!write) {
+		if (!(flags & TXRX_WRITE)) {
 			if (mxs_ssp_wait(spi, HW_SSP_STATUS(ssp),
 						BM_SSP_STATUS_FIFO_EMPTY, 0))
 				return -ETIMEDOUT;
@@ -381,13 +392,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 {
 	struct mxs_spi *spi = spi_master_get_devdata(master);
 	struct mxs_ssp *ssp = &spi->ssp;
-	int first, last;
 	struct spi_transfer *t, *tmp_t;
+	unsigned int flag;
 	int status = 0;
 	int cs;
 
-	first = last = 0;
-
 	cs = m->spi->chip_select;
 
 	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
@@ -396,10 +405,9 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		if (status)
 			break;
 
-		if (&t->transfer_list == m->transfers.next)
-			first = 1;
-		if (&t->transfer_list == m->transfers.prev)
-			last = 1;
+		/* De-assert on last transfer, inverted by cs_change flag */
+		flag = (&t->transfer_list == m->transfers.prev) ^ t->cs_change ?
+		       TXRX_DEASSERT_CS : 0;
 		if ((t->rx_buf && t->tx_buf) || (t->rx_dma && t->tx_dma)) {
 			dev_err(ssp->dev,
 				"Cannot send and receive simultaneously\n");
@@ -424,11 +432,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 			if (t->tx_buf)
 				status = mxs_spi_txrx_pio(spi, cs,
 						(void *)t->tx_buf,
-						t->len, &first, &last, 1);
+						t->len, flag | TXRX_WRITE);
 			if (t->rx_buf)
 				status = mxs_spi_txrx_pio(spi, cs,
 						t->rx_buf, t->len,
-						&first, &last, 0);
+						flag);
 		} else {
 			writel(BM_SSP_CTRL1_DMA_ENABLE,
 				ssp->base + HW_SSP_CTRL1(ssp) +
@@ -437,11 +445,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 			if (t->tx_buf)
 				status = mxs_spi_txrx_dma(spi, cs,
 						(void *)t->tx_buf, t->len,
-						&first, &last, 1);
+						flag | TXRX_WRITE);
 			if (t->rx_buf)
 				status = mxs_spi_txrx_dma(spi, cs,
 						t->rx_buf, t->len,
-						&first, &last, 0);
+						flag);
 		}
 
 		if (status) {
@@ -450,7 +458,6 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		}
 
 		m->actual_length += t->len;
-		first = last = 0;
 	}
 
 	m->status = status;


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
