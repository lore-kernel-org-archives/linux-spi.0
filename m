From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 05/12] spi/mxs: Fix chip select control bits in DMA mode
Date: Tue,  2 Apr 2013 05:19:48 -0700
Message-ID: <1364905195-24286-5-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
addressing slave 1 the bit would be still be set when addressing slave
0, resulting in slave 1 continuing to be addressed.

The message handing function would pass the cs value to the txrx
function, which would re-program the bits on each transfer in the
message.  The selected cs does not change during a message so this is
inefficient.  It also means there are two different sets of code for
selecting the CS, one for PIO that worked and one for DMA that didn't.

Change the code to set the CS bits in the message transfer function
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
index 86a714b..ad3fd9c 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -152,18 +152,6 @@ static uint32_t mxs_spi_cs_to_reg(unsigned cs)
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
@@ -201,7 +189,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
+static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 			    unsigned char *buf, int len,
 			    unsigned int flags)
 {
@@ -229,10 +217,11 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 
 	INIT_COMPLETION(spi->c);
 
+	/* Chip select was already programmed into CTRL0 */
 	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
 	ctrl0 &= ~(BM_SSP_CTRL0_XFER_COUNT | BM_SSP_CTRL0_IGNORE_CRC |
 		 BM_SSP_CTRL0_READ);
-	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
+	ctrl0 |= BM_SSP_CTRL0_DATA_XFER;
 
 	if (!(flags & TXRX_WRITE))
 		ctrl0 |= BM_SSP_CTRL0_READ;
@@ -336,7 +325,7 @@ err_mapped:
 	return ret;
 }
 
-static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
+static int mxs_spi_txrx_pio(struct mxs_spi *spi,
 			    unsigned char *buf, int len,
 			    unsigned int flags)
 {
@@ -346,8 +335,6 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
 	writel(BM_SSP_CTRL0_IGNORE_CRC,
 	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 
-	mxs_spi_set_cs(spi, cs);
-
 	while (len--) {
 		if (len == 0 && (flags & TXRX_DEASSERT_CS))
 			writel(BM_SSP_CTRL0_IGNORE_CRC,
@@ -409,9 +396,12 @@ static int mxs_spi_transfer_one(struct spi_master *master,
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
 
@@ -444,11 +434,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
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
@@ -457,11 +447,11 @@ static int mxs_spi_transfer_one(struct spi_master *master,
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
-- 
1.7.10.4


------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
