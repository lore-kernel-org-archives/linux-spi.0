From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc4] spi doc updates
Date: Mon, 11 Jun 2007 21:27:38 -0700
Message-ID: <200706112127.39213.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Update two points in the SPI interface documentation:

 - Update description of the "chip stays selected after message ends"
   mode.  In some cases it's required for correctness; it isn't just a
   performance tweak.  (Yes: to use this mode on mult-device busses,
   another programming interface will be needed.  One draft has been
   circulated already.)

 - Clarify spi_setup(), highlighting that callers must ensure that no 
   requests are queued (can't change configuration except between I/Os),
   and that the device must be deselected when this returns (which is
   a key part of why it's called during device init).

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 include/linux/spi/spi.h |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- g26.orig/include/linux/spi/spi.h	2007-06-08 17:48:30.000000000 -0700
+++ g26/include/linux/spi/spi.h	2007-06-11 21:20:26.000000000 -0700
@@ -351,9 +351,14 @@ extern struct spi_master *spi_busnum_to_
  * chip transactions together.
  *
  * (ii) When the transfer is the last one in the message, the chip may
- * stay selected until the next transfer.  This is purely a performance
- * hint; the controller driver may need to select a different device
- * for the next message.
+ * stay selected until the next transfer.  On multi-device SPI busses
+ * with nothing blocking messages going to other devices, this is just
+ * a performance hint; starting a message to another device deselects
+ * this one.  But in other cases, this can be used to ensure correctness.
+ * Some devices need protocol transactions to be built from a series of
+ * spi_message submissions, where the content of one message is determined
+ * by the results of previous messages and where the whole transaction
+ * ends when the chipselect goes intactive.
  *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
@@ -490,14 +495,15 @@ static inline void spi_message_free(stru
 /**
  * spi_setup - setup SPI mode and clock rate
  * @spi: the device whose settings are being modified
- * Context: can sleep
+ * Context: can sleep, and no requests are queued to the device
  *
  * SPI protocol drivers may need to update the transfer mode if the
- * device doesn't work with the mode 0 default.  They may likewise need
+ * device doesn't work with its default.  They may likewise need
  * to update clock rates or word sizes from initial values.  This function
  * changes those settings, and must be called from a context that can sleep.
- * The changes take effect the next time the device is selected and data
- * is transferred to or from it.
+ * Except for SPI_CS_HIGH, which takes effect immediately, the changes take
+ * effect the next time the device is selected and data is transferred to
+ * or from it.  When this function returns, the spi device is deselected.
  *
  * Note that this call will fail if the protocol driver specifies an option
  * that the underlying controller or its driver does not support.  For

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
