From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-rc2] spi: doc emphasises
	spi_master.setup() semantics
Date: Thu, 16 Apr 2009 16:07:00 -0700
Message-ID: <200904161607.00578.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

This is a doc-only patch which I hope will reduce the number of
spi_master controller driver patches starting out with a common
implementation bug.  (As in: almost every spi_master driver I see
starts out with its version of this bug.  Sigh.)

It just re-emphasizes that the setup() method may be called for
one device while a transfer is active on another ... which means
that most driver implementations shouldn't touch any registers.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 Documentation/spi/spi-summary |    6 ++++++
 include/linux/spi/spi.h       |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -511,10 +511,16 @@ SPI MASTER METHODS
 	This sets up the device clock rate, SPI mode, and word sizes.
 	Drivers may change the defaults provided by board_info, and then
 	call spi_setup(spi) to invoke this routine.  It may sleep.
+
 	Unless each SPI slave has its own configuration registers, don't
 	change them right away ... otherwise drivers could corrupt I/O
 	that's in progress for other SPI devices.
 
+		** BUG ALERT:  for some reason the first version of
+		** many spi_master drivers seems to get this wrong.
+		** When you code setup(), ASSUME that the controller
+		** is actively processing transfers for another device.
+
     master->transfer(struct spi_device *spi, struct spi_message *message)
     	This must not sleep.  Its responsibility is arrange that the
 	transfer happens and its complete() callback is issued.  The two
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -248,7 +248,12 @@ struct spi_master {
 	 */
 	u16			dma_alignment;
 
-	/* setup mode and clock, etc (spi driver may call many times) */
+	/* Setup mode and clock, etc (spi driver may call many times).
+	 *
+	 * IMPORTANT:  this may be called when transfers to another
+	 * device are active.  DO NOT UPDATE SHARED REGISTERS in ways
+	 * which could break those transfers.
+	 */
 	int			(*setup)(struct spi_device *spi);
 
 	/* bidirectional bulk transfers


------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
