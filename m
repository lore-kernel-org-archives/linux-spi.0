From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc3] spi controller mode check
	update
Date: Fri, 1 Jun 2007 16:28:07 -0700
Message-ID: <200706011628.07305.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This lets bitbanging SPI controller drivers declare that they
support modes like SPI_CS_HIGH and SPI_3WIRE.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

---
This updates a patch in 2.6.22-rc3 called
  
	spi-controller-drivers-check-for-unsupported-modes.patch

 drivers/spi/spi_bitbang.c       |   12 +++---------
 include/linux/spi/spi_bitbang.h |    1 +
 2 files changed, 4 insertions(+), 9 deletions(-)

--- g26.orig/include/linux/spi/spi_bitbang.h	2007-06-01 16:25:23.000000000 -0700
+++ g26/include/linux/spi/spi_bitbang.h	2007-06-01 16:26:06.000000000 -0700
@@ -26,6 +26,7 @@ struct spi_bitbang {
 	struct list_head	queue;
 	u8			busy;
 	u8			use_dma;
+	u8			flags;		/* extra spi->mode support */
 
 	struct spi_master	*master;
 
--- g26.orig/drivers/spi/spi_bitbang.c	2007-06-01 16:25:23.000000000 -0700
+++ g26/drivers/spi/spi_bitbang.c	2007-06-01 16:26:06.000000000 -0700
@@ -187,16 +187,10 @@ int spi_bitbang_setup(struct spi_device 
 
 	bitbang = spi_master_get_devdata(spi->master);
 
-	/* REVISIT: some systems will want to support devices using lsb-first
-	 * bit encodings on the wire.  In pure software that would be trivial,
-	 * just bitbang_txrx_le_cphaX() routines shifting the other way, and
-	 * some hardware controllers also have this support.
-	 *
-	 * REVISIT: we should accept SPI_CS_HIGH in some cases; it's
-	 * easy to implement that with GPIOs, but we don't know if the
-	 * underlying chipselect() method support that...
+	/* Bitbangers can support SPI_CS_HIGH, SPI_3WIRE, and so on;
+	 * add those to master->flags, and provide the other support.
 	 */
-	if ((spi->mode & ~(SPI_CPOL|SPI_CPHA)) != 0)
+	if ((spi->mode & ~(SPI_CPOL|SPI_CPHA|bitbang->flags)) != 0)
 		return -EINVAL;
 
 	if (!cs) {

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
