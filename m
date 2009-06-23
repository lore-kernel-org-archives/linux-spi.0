From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch] spi: add spi_master flag word
Date: Tue, 23 Jun 2009 12:09:08 -0700
Message-ID: <200906231209.08291.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Add a new spi_master.flags word listing constraints relevant
to that controller.  Define the first constraint bit:  a half
duplex restriction.  Include that constraint in the OMAP1
MicroWire controller driver.

Have the mmc_spi host be the first customer of this flag.
Its coding relies heavily on full duplex transfers, so it must
fail when the underlying controller driver won't perform them.

(The spi_write_then_read routine could use it too:  use the
temporarily-withdrawn full-duplex speedup unless this flag is
set, in which case the existing code applies.  Similarly, any
spi_master implementing only SPI_3WIRE should set the flag.)

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/mmc/host/mmc_spi.c |    6 ++++++
 drivers/spi/omap_uwire.c   |    2 ++
 include/linux/spi/spi.h    |    4 ++++
 3 files changed, 12 insertions(+)

--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1313,6 +1313,12 @@ static int mmc_spi_probe(struct spi_devi
 	struct mmc_spi_host	*host;
 	int			status;
 
+	/* We rely on full duplex transfers, mostly to reduce
+	 * per-transfer overheads (by making fewer transfers).
+	 */
+	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
+		return -EINVAL;
+
 	/* MMC and SD specs only seem to care that sampling is on the
 	 * rising edge ... meaning SPI modes 0 or 3.  So either SPI mode
 	 * should be legit.  We'll use mode 0 since the steady state is 0,
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -514,6 +514,8 @@ static int __init uwire_probe(struct pla
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
+	master->flags = SPI_MASTER_HALF_DUPLEX;
+
 	master->bus_num = 2;	/* "official" */
 	master->num_chipselect = 4;
 	master->setup = uwire_setup;
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -250,6 +250,10 @@ struct spi_master {
 	/* spi_device.mode flags understood by this controller driver */
 	u16			mode_bits;
 
+	/* other constraints relevant to this driver */
+	u16			flags;
+#define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
+
 	/* Setup mode and clock, etc (spi driver may call many times).
 	 *
 	 * IMPORTANT:  this may be called when transfers to another

------------------------------------------------------------------------------
