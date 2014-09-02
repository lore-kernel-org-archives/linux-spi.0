From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/9] spi: tegra114: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:52:23 +0900
Message-ID: <002601cfc658$ec0efa60$c42cef20$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Laxman Dewangan' <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-tegra114.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e4a85ada861d..795bcbc0131b 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -302,6 +302,7 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 		max_n_32bit = DIV_ROUND_UP(nbytes, 4);
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
+
 			for (i = 0; (i < 4) && nbytes; i++, nbytes--)
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
@@ -312,6 +313,7 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 		nbytes = written_words * tspi->bytes_per_word;
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
+
 			for (i = 0; nbytes && (i < tspi->bytes_per_word);
 							i++, nbytes--)
 				x |= (u32)(*tx_buf++) << (i * 8);
@@ -338,6 +340,7 @@ static unsigned int tegra_spi_read_rx_fifo_to_client_rxbuf(
 		len = tspi->curr_dma_words * tspi->bytes_per_word;
 		for (count = 0; count < rx_full_count; count++) {
 			u32 x = tegra_spi_readl(tspi, SPI_RX_FIFO);
+
 			for (i = 0; len && (i < 4); i++, len--)
 				*rx_buf++ = (x >> i*8) & 0xFF;
 		}
@@ -345,8 +348,10 @@ static unsigned int tegra_spi_read_rx_fifo_to_client_rxbuf(
 		read_words += tspi->curr_dma_words;
 	} else {
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+
 		for (count = 0; count < rx_full_count; count++) {
 			u32 x = tegra_spi_readl(tspi, SPI_RX_FIFO) & rx_mask;
+
 			for (i = 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
@@ -365,6 +370,7 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 
 	if (tspi->is_packed) {
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
+
 		memcpy(tspi->tx_dma_buf, t->tx_buf + tspi->cur_pos, len);
 	} else {
 		unsigned int i;
@@ -374,6 +380,7 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = 0;
+
 			for (i = 0; consume && (i < tspi->bytes_per_word);
 							i++, consume--)
 				x |= (u32)(*tx_buf++) << (i * 8);
@@ -396,6 +403,7 @@ static void tegra_spi_copy_spi_rxbuf_to_client_rxbuf(
 
 	if (tspi->is_packed) {
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
+
 		memcpy(t->rx_buf + tspi->cur_rx_pos, tspi->rx_dma_buf, len);
 	} else {
 		unsigned int i;
@@ -405,6 +413,7 @@ static void tegra_spi_copy_spi_rxbuf_to_client_rxbuf(
 
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = tspi->rx_dma_buf[count] & rx_mask;
+
 			for (i = 0; (i < tspi->bytes_per_word); i++)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
