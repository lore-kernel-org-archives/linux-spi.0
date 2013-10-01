From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/13] spi: spi-mxs: Fix chip select control bits in DMA mode
Date: Tue, 01 Oct 2013 13:15:04 -0700
Message-ID: <20131001201504.13660.68255.stgit@Graphine>
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

In DMA mode the chip select control bits would be ORed into the CTRL0
register without first clearing the bits.  This means that after
addressing slave 1, the CTRL0 bit to address slave 1 would be still be
set when addressing slave 0, resulting in slave 1 continuing to be
addressed.

The message handling function would pass the CS value to the txrx
function, which would re-program the bits on each transfer in the
message.  The selected CS does not change during a message so this is
inefficient.  It also means there are two different sets of code for
selecting the CS, one for PIO that worked and one for DMA that didn't.

Change the code to set the CS bits in the message handling function
once.  Now the DMA and PIO txrx functions don't need to care about CS
at all.

Signed-off-by: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mxs.c |   36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 68ea507..a9a273e 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -140,18 +140,6 @@ static uint32_t mxs_spi_cs_to_reg(unsigned cs)
 	return select;
 }
 
-static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
-{
-	const uint32_t mask =
-		BM_SSP_CTRL0_WAIT_FOR_CMD | BM_SSP_CTRL0_WAIT_FOR_IRQ;
-	uint32_t select;
-	struct mxs_ssp *ssp = &spi->ssp;
-
-	writel(mask, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
-	select = mxs_spi_cs_to_reg(cs);
-	writel(select, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
-}
-
 static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
 	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
@@ -189,7 +177,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
+static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 			    unsigned char *buf, int len,
 			    unsigned int flags)
 {
@@ -217,10 +205,11 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 	INIT_COMPLETION(spi->c);
 
+	/* Chip select was already programmed into CTRL0 */
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
 	ctrl0 &= ~(BM_SSP_CTRL0_XFER_COUNT | BM_SSP_CTRL0_IGNORE_CRC |
 		 BM_SSP_CTRL0_READ);
-	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
+	ctrl0 |= BM_SSP_CTRL0_DATA_XFER;
 
 	if (!(flags & TXRX_WRITE))
 		ctrl0 |= BM_SSP_CTRL0_READ;
@@ -324,7 +313,7 @@ err_mapped:
 	return ret;
 }
 
-static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
+static int mxs_spi_txrx_pio(struct mxs_spi *spi,
 			    unsigned char *buf, int len,
 			    unsigned int flags)
 {
@@ -333,8 +322,6 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 
-	mxs_spi_set_cs(spi, cs);
-
 	while (len--) {
 		if (len == 0 && (flags & TXRX_DEASSERT_CS))
 			writel(BM_SSP_CTRL0_IGNORE_CRC,
@@ -396,9 +383,12 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	struct spi_transfer *t, *tmp_t;
 	unsigned int flag;
 	int status = 0;
-	int cs;
 
-	cs = m->spi->chip_select;
+	/* Program CS register bits here, it will be used for all transfers. */
+	writel(BM_SSP_CTRL0_WAIT_FOR_CMD | BM_SSP_CTRL0_WAIT_FOR_IRQ,
+	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
+	writel(mxs_spi_cs_to_reg(m->spi->chip_select),
+	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
 	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
 
@@ -431,11 +421,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 				STMP_OFFSET_REG_CLR);
 
 			if (t->tx_buf)
-				status = mxs_spi_txrx_pio(spi, cs,
+				status = mxs_spi_txrx_pio(spi,
 						(void *)t->tx_buf,
 						t->len, flag | TXRX_WRITE);
 			if (t->rx_buf)
-				status = mxs_spi_txrx_pio(spi, cs,
+				status = mxs_spi_txrx_pio(spi,
 						t->rx_buf, t->len,
 						flag);
 		} else {
@@ -444,11 +434,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 				STMP_OFFSET_REG_SET);
 
 			if (t->tx_buf)
-				status = mxs_spi_txrx_dma(spi, cs,
+				status = mxs_spi_txrx_dma(spi,
 						(void *)t->tx_buf, t->len,
 						flag | TXRX_WRITE);
 			if (t->rx_buf)
-				status = mxs_spi_txrx_dma(spi, cs,
+				status = mxs_spi_txrx_dma(spi,
 						t->rx_buf, t->len,
 						flag);
 		}


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
