From: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] omap2_mcspi: Use dma_min_bytes
	parameter when it is configured.
Date: Tue,  6 Apr 2010 13:39:49 +0300
Message-ID: <1270550389-30392-2-git-send-email-roman.tereshonkov@nokia.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1270550389-30392-1-git-send-email-roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

When dma_min_bytes parameter is set as non-zero from device configuration it
overlaps the global one DMA_MIN_BYTES.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a9d58ce..1befdf8 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -793,6 +793,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 		int				par_override = 0;
 		int				status = 0;
 		u32				chconf;
+		u32				dma_min_bytes = DMA_MIN_BYTES;
 
 		m = container_of(mcspi->msg_queue.next, struct spi_message,
 				 queue);
@@ -803,6 +804,9 @@ static void omap2_mcspi_work(struct work_struct *work)
 		spi = m->spi;
 		cs = spi->controller_state;
 
+		if (spi->dma_min_bytes)
+			dma_min_bytes = spi->dma_min_bytes;
+
 		omap2_mcspi_set_enable(spi, 1);
 		list_for_each_entry(t, &m->transfers, transfer_list) {
 			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
@@ -839,7 +843,7 @@ static void omap2_mcspi_work(struct work_struct *work)
 					__raw_writel(0, cs->base
 							+ OMAP2_MCSPI_TX0);
 
-				if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
+				if (m->is_dma_mapped || t->len >= dma_min_bytes)
 					count = omap2_mcspi_txrx_dma(spi, t);
 				else
 					count = omap2_mcspi_txrx_pio(spi, t);
@@ -889,6 +893,7 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 	struct omap2_mcspi	*mcspi;
 	unsigned long		flags;
 	struct spi_transfer	*t;
+	u32			dma_min_bytes;
 
 	m->actual_length = 0;
 	m->status = 0;
@@ -896,6 +901,9 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 	/* reject invalid messages and transfers */
 	if (list_empty(&m->transfers) || !m->complete)
 		return -EINVAL;
+
+	dma_min_bytes = spi->dma_min_bytes ? spi->dma_min_bytes : DMA_MIN_BYTES;
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		const void	*tx_buf = t->tx_buf;
 		void		*rx_buf = t->rx_buf;
@@ -921,7 +929,7 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
 			return -EINVAL;
 		}
 
-		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
+		if (m->is_dma_mapped || len < dma_min_bytes)
 			continue;
 
 		/* Do DMA mapping "early" for better error reporting and
-- 
1.6.2.rc1.3.g81d3f


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
