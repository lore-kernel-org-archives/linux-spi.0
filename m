From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc2 2/3] atmel_spi throughput
	improvement
Date: Wed, 14 Nov 2007 21:45:37 -0800
Message-ID: <200711142145.38399.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Don't insert (undesirable) delays between consecutive words (DLYBCT)
or when activating chipselects (DLYBS).

Removing the between-word delays improves the performance of bulk
transfers (such as mtd_dataflash, m25p80, mmc_spi) significantly.
In one test, the improvement was a factor of more than eight!

(The large DLYBCT value came from the legacy at91 SPI driver, and
it's not clear why it used such a huge value.)

Signed-off-by: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/spi/atmel_spi.c	2007-11-14 14:59:43.000000000 -0800
+++ b/drivers/spi/atmel_spi.c	2007-11-14 15:03:30.000000000 -0800
@@ -490,9 +490,14 @@ static int atmel_spi_setup(struct spi_de
 	if (!(spi->mode & SPI_CPHA))
 		csr |= SPI_BIT(NCPHA);
 
-	/* TODO: DLYBS and DLYBCT */
-	csr |= SPI_BF(DLYBS, 10);
-	csr |= SPI_BF(DLYBCT, 10);
+	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
+	 *
+	 * DLYBCT would add delays between words, slowing down transfers.
+	 * It could potentially be useful to cope with DMA bottlenecks, but
+	 * in those cases it's probably best to just use a lower bitrate.
+	 */
+	csr |= SPI_BF(DLYBS, 0);
+	csr |= SPI_BF(DLYBCT, 0);
 
 	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
 	npcs_pin = (unsigned int)spi->controller_data;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
