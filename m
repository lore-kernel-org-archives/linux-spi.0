From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: bitbang: switch to the generic implementation of
 transfer_one_message
Date: Tue, 29 Sep 2015 23:15:53 +0200
Message-ID: <560AFF89.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Change the bitbang driver to use the generic implementation of
transfer_one_message. This simplifies the bitbang driver code and
provides benefits like the statistics in the generic implementation.

Successfully tested on a IMX6-based system (spi-imx) and on a MIPS-based
router (OpenWRT with spi-ath79).

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bitbang.c | 125 +++++++++++++---------------------------------
 1 file changed, 36 insertions(+), 89 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index ad3168d..7f5ffbf 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -24,6 +24,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 
+#define SPI_BITBANG_CS_DELAY	100
+
 
 /*----------------------------------------------------------------------*/
 
@@ -265,100 +267,28 @@ static int spi_bitbang_prepare_hardware(struct spi_master *spi)
 }
 
 static int spi_bitbang_transfer_one(struct spi_master *master,
-				    struct spi_message *m)
+				    struct spi_device *spi,
+				    struct spi_transfer *transfer)
 {
-	struct spi_bitbang	*bitbang;
-	unsigned		nsecs;
-	struct spi_transfer	*t = NULL;
-	unsigned		cs_change;
-	int			status;
-	struct spi_device	*spi = m->spi;
-
-	bitbang = spi_master_get_devdata(master);
-
-	/* FIXME this is made-up ... the correct value is known to
-	 * word-at-a-time bitbang code, and presumably chipselect()
-	 * should enforce these requirements too?
-	 */
-	nsecs = 100;
-
-	cs_change = 1;
-	status = 0;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-
-		if (bitbang->setup_transfer) {
-			status = bitbang->setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
-
-		/* set up default clock polarity, and activate chip;
-		 * this implicitly updates clock and spi modes as
-		 * previously recorded for this device via setup().
-		 * (and also deselects any other chip that might be
-		 * selected ...)
-		 */
-		if (cs_change) {
-			bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
-			ndelay(nsecs);
-		}
-		cs_change = t->cs_change;
-		if (!t->tx_buf && !t->rx_buf && t->len) {
-			status = -EINVAL;
-			break;
-		}
-
-		/* transfer data.  the lower level code handles any
-		 * new dma mappings it needs. our caller always gave
-		 * us dma-safe buffers.
-		 */
-		if (t->len) {
-			/* REVISIT dma API still needs a designated
-			 * DMA_ADDR_INVALID; ~0 might be better.
-			 */
-			if (!m->is_dma_mapped)
-				t->rx_dma = t->tx_dma = 0;
-			status = bitbang->txrx_bufs(spi, t);
-		}
-		if (status > 0)
-			m->actual_length += status;
-		if (status != t->len) {
-			/* always report some kind of error */
-			if (status >= 0)
-				status = -EREMOTEIO;
-			break;
-		}
-		status = 0;
+	struct spi_bitbang *bitbang = spi_master_get_devdata(master);
+	int status = 0;
 
-		/* protocol tweaks before next transfer */
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-
-		if (cs_change &&
-		    !list_is_last(&t->transfer_list, &m->transfers)) {
-			/* sometimes a short mid-message deselect of the chip
-			 * may be needed to terminate a mode or command
-			 */
-			ndelay(nsecs);
-			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-			ndelay(nsecs);
-		}
+	if (bitbang->setup_transfer) {
+		status = bitbang->setup_transfer(spi, transfer);
+		if (status < 0)
+			goto out;
 	}
 
-	m->status = status;
+	if (transfer->len)
+		status = bitbang->txrx_bufs(spi, transfer);
 
-	/* normally deactivate chipselect ... unless no error and
-	 * cs_change has hinted that the next message will probably
-	 * be for this chip too.
-	 */
-	if (!(status == 0 && cs_change)) {
-		ndelay(nsecs);
-		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-		ndelay(nsecs);
-	}
+	if (status == transfer->len)
+		status = 0;
+	else if (status >= 0)
+		status = -EREMOTEIO;
 
-	spi_finalize_current_message(master);
+out:
+	spi_finalize_current_transfer(master);
 
 	return status;
 }
@@ -376,6 +306,22 @@ static int spi_bitbang_unprepare_hardware(struct spi_master *spi)
 	return 0;
 }
 
+static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
+{
+	struct spi_bitbang *bitbang = spi_master_get_devdata(spi->master);
+
+	/* SPI core provides CS high / low, but bitbang driver
+	 * expects CS active
+	 * spi device driver takes care of handling SPI_CS_HIGH
+	 */
+	enable = (!!(spi->mode & SPI_CS_HIGH) == enable);
+
+	ndelay(SPI_BITBANG_CS_DELAY);
+	bitbang->chipselect(spi, enable ? BITBANG_CS_ACTIVE :
+			    BITBANG_CS_INACTIVE);
+	ndelay(SPI_BITBANG_CS_DELAY);
+}
+
 /*----------------------------------------------------------------------*/
 
 /**
@@ -424,7 +370,8 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 
 	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
 	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
-	master->transfer_one_message = spi_bitbang_transfer_one;
+	master->transfer_one = spi_bitbang_transfer_one;
+	master->set_cs = spi_bitbang_set_cs;
 
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
