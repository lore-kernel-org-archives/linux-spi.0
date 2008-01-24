From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc8] spi: omap2_mcspi PIO RX fix
Date: Thu, 24 Jan 2008 13:40:24 -0800
Message-ID: <200801241340.25207.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

From: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Before transmission of the last word in PIO RX_ONLY mode rx+tx mode
is enabled:

	/* prevent last RX_ONLY read from triggering
	 * more word i/o: switch to rx+tx
	 */
	if (c == 0 && tx == NULL)
		mcspi_write_cs_reg(spi,
				OMAP2_MCSPI_CHCONF0, l);

But because c is decremented after the test, c will never be zero and
rx+tx will not be enabled. This breaks RX_ONLY mode PIO transfers.

Fix it by decrementing c in the beginning of the various I/O loops.

Signed-off-by: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -350,6 +350,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		tx = xfer->tx_buf;
 
 		do {
+			c -= 1;
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -380,7 +381,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 						word_len, *(rx - 1));
 #endif
 			}
-			c -= 1;
 		} while (c);
 	} else if (word_len <= 16) {
 		u16		*rx;
@@ -389,6 +389,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
+			c -= 2;
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -419,7 +420,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 						word_len, *(rx - 1));
 #endif
 			}
-			c -= 2;
 		} while (c);
 	} else if (word_len <= 32) {
 		u32		*rx;
@@ -428,6 +428,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
+			c -= 4;
 			if (tx != NULL) {
 				if (mcspi_wait_for_reg_bit(chstat_reg,
 						OMAP2_MCSPI_CHSTAT_TXS) < 0) {
@@ -458,7 +459,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 						word_len, *(rx - 1));
 #endif
 			}
-			c -= 4;
 		} while (c);
 	}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
