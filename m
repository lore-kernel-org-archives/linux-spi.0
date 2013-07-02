From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 03/11] spi: spi-ep93xx: remove bits_per_word() helper
Date: Tue, 2 Jul 2013 10:07:01 -0700
Message-ID: <201307021007.01896.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mika.westerberg-X3B1VOXEql0@public.gmane.org,
	hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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

Check t->bits_per_word directly and remove the inline helper function.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d7eccfc..d5e6420 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -429,17 +429,9 @@ static void ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
 	ep93xx_spi_write_u16(espi, SSPCR0, cr0);
 }
 
-static inline int bits_per_word(const struct ep93xx_spi *espi)
-{
-	struct spi_message *msg = espi->current_msg;
-	struct spi_transfer *t = msg->state;
-
-	return t->bits_per_word;
-}
-
 static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
 {
-	if (bits_per_word(espi) > 8) {
+	if (t->bits_per_word > 8) {
 		u16 tx_val = 0;
 
 		if (t->tx_buf)
@@ -458,7 +450,7 @@ static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
 
 static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
 {
-	if (bits_per_word(espi) > 8) {
+	if (t->bits_per_word > 8) {
 		u16 rx_val;
 
 		rx_val = ep93xx_spi_read_u16(espi, SSPDR);
@@ -544,7 +536,7 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_transfer_direction dir)
 	size_t len = t->len;
 	int i, ret, nents;
 
-	if (bits_per_word(espi) > 8)
+	if (t->bits_per_word > 8)
 		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	else
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
