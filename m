From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/9] spi: dw: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:49:24 +0900
Message-ID: <002201cfc658$816252c0$8426f840$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Baruch Siach' <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
  WARNING: min() should probably be min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR))
  WARNING: else is not generally useful after a break or return
  WARNING: Missing a blank line after declarations
  WARNING: void function return statements are not generally useful

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-dw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 670f0627f3bf..f6e1ee658720 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -135,8 +135,7 @@ static int mrst_spi_debugfs_init(struct dw_spi *dws)
 
 static void mrst_spi_debugfs_remove(struct dw_spi *dws)
 {
-	if (dws->debugfs)
-		debugfs_remove_recursive(dws->debugfs);
+	debugfs_remove_recursive(dws->debugfs);
 }
 
 #else
@@ -177,7 +176,7 @@ static inline u32 rx_max(struct dw_spi *dws)
 {
 	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
 
-	return min(rx_left, (u32)dw_readw(dws, DW_SPI_RXFLR));
+	return min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR));
 }
 
 static void dw_writer(struct dw_spi *dws)
@@ -228,8 +227,9 @@ static void *next_transfer(struct dw_spi *dws)
 					struct spi_transfer,
 					transfer_list);
 		return RUNNING_STATE;
-	} else
-		return DONE_STATE;
+	}
+
+	return DONE_STATE;
 }
 
 /*
@@ -471,10 +471,12 @@ static void pump_transfers(unsigned long data)
 	 */
 	if (!dws->dma_mapped && !chip->poll_mode) {
 		int templen = dws->len / dws->n_bytes;
+
 		txint_level = dws->fifo_len / 2;
 		txint_level = (templen > txint_level) ? txint_level : templen;
 
-		imask |= SPI_INT_TXEI | SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI;
+		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
+			 SPI_INT_RXUI | SPI_INT_RXOI;
 		dws->transfer_handler = interrupt_transfer;
 	}
 
@@ -515,7 +517,6 @@ static void pump_transfers(unsigned long data)
 
 early_exit:
 	giveback(dws);
-	return;
 }
 
 static int dw_spi_transfer_one_message(struct spi_master *master,
@@ -619,6 +620,7 @@ static void spi_hw_init(struct dw_spi *dws)
 	 */
 	if (!dws->fifo_len) {
 		u32 fifo;
+
 		for (fifo = 2; fifo <= 257; fifo++) {
 			dw_writew(dws, DW_SPI_TXFLTR, fifo);
 			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
