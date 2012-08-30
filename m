From: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/2] omap2-mcspi: fall back to PIO when the buffer is in high
	mem
Date: Thu, 30 Aug 2012 17:02:51 +0200
Message-ID: <1346338971-9106-2-git-send-email-jlu@pengutronix.de>
References: <1346338971-9106-1-git-send-email-jlu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1346338971-9106-1-git-send-email-jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

UBI uses vmalloc'ed buffers in some cases which are not valid for
DMA, so use PIO instead.

Signed-off-by: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index ceb27fc..6f361a1 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -927,7 +927,9 @@ static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_message *m)
 				__raw_writel(0, cs->base
 						+ OMAP2_MCSPI_TX0);
 
-			if (m->is_dma_mapped || t->len >= DMA_MIN_BYTES)
+			if (m->is_dma_mapped || (t->len >= DMA_MIN_BYTES
+				&& t->tx_buf < high_memory
+				&& t->rx_buf < high_memory))
 				count = omap2_mcspi_txrx_dma(spi, t);
 			else
 				count = omap2_mcspi_txrx_pio(spi, t);
@@ -1004,6 +1006,11 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
 			continue;
 
+		if (tx_buf >= high_memory || rx_buf >= high_memory) {
+			WARN_ONCE(1, "high memory is invalid for DMA, falling back to PIO\n");
+			continue;
+		}
+
 		if (tx_buf != NULL) {
 			t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
 					len, DMA_TO_DEVICE);
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
