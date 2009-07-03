From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch] spi: omap2_mcspi rxdma bugfix
Date: Thu, 2 Jul 2009 17:00:44 -0700
Message-ID: <200907021700.44984.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Juuso Oikarinen <juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

When data is read through DMA, the last element must be read separately
through the RX register. It cannot be transferred by the DMA. For further
details see e.g. OMAP35x TRM (table 19-16).

Without the fix the driver causes extra clocks to be clocked to the
bus after DMA RX operations. This can cause interesting behaviour with
some devices.

Signed-off-by: Juuso Oikarinen <juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
[aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org: Simplified the patch while keeping the idea.]
Signed-off-by: Aaro Koskinen <aaro.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -272,7 +272,7 @@ omap2_mcspi_txrx_dma(struct spi_device *
 
 	if (rx != NULL) {
 		omap_set_dma_transfer_params(mcspi_dma->dma_rx_channel,
-				data_type, element_count, 1,
+				data_type, element_count - 1, 1,
 				OMAP_DMA_SYNC_ELEMENT,
 				mcspi_dma->dma_rx_sync_dev, 1);
 
@@ -303,6 +303,25 @@ omap2_mcspi_txrx_dma(struct spi_device *
 	if (rx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_rx_completion);
 		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
+		omap2_mcspi_set_enable(spi, 0);
+		if (likely(mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHSTAT0)
+				& OMAP2_MCSPI_CHSTAT_RXS)) {
+			u32 w;
+
+			w = mcspi_read_cs_reg(spi, OMAP2_MCSPI_RX0);
+			if (word_len <= 8)
+				((u8 *)xfer->rx_buf)[element_count - 1] = w;
+			else if (word_len <= 16)
+				((u16 *)xfer->rx_buf)[element_count - 1] = w;
+			else /* word_len <= 32 */
+				((u32 *)xfer->rx_buf)[element_count - 1] = w;
+		} else {
+			dev_err(&spi->dev, "DMA RX last word empty");
+			count -= (word_len <= 8)  ? 1 :
+				 (word_len <= 16) ? 2 :
+			       /* word_len <= 32 */ 4;
+		}
+		omap2_mcspi_set_enable(spi, 1);
 	}
 	return count;
 }

------------------------------------------------------------------------------
