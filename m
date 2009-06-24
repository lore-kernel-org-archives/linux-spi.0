From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-git] spi: bitbang bugfix in
	message setup
Date: Wed, 24 Jun 2009 10:12:32 -0700
Message-ID: <200906241012.32360.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
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

Bugfix to spi_bitbang infrastructure:  make sure to always set transfer
parameters on the first pass through the message's per-transfer loop.
This can matter with drivers that replace the per-word or per-buffer
transfer primitives, on busses with multiple SPI devices.

Previously, this could have started messages using the settings left
after previous messages.  The problem was observed when a high speed
chip (m25p80 type flash) was running very slowly because a low speed
device (avr8 microcontroller) had previously used the bus.  Similar
faults could have driven the low speed device too fast, or used an
unexpected word size.

Acked-by: Steven A. Falco <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
For 2.6.31 ... bug is in older kernels too, but doesn't appear to have
hurt anyone before now; this particular driver config isn't common.

 drivers/spi/spi_bitbang.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -258,6 +258,11 @@ static void bitbang_work(struct work_str
 	struct spi_bitbang	*bitbang =
 		container_of(work, struct spi_bitbang, work);
 	unsigned long		flags;
+	int			do_setup = -1;
+	int			(*setup_transfer)(struct spi_device *,
+					struct spi_transfer *);
+
+	setup_transfer = bitbang->setup_transfer;
 
 	spin_lock_irqsave(&bitbang->lock, flags);
 	bitbang->busy = 1;
@@ -269,8 +274,6 @@ static void bitbang_work(struct work_str
 		unsigned		tmp;
 		unsigned		cs_change;
 		int			status;
-		int			(*setup_transfer)(struct spi_device *,
-						struct spi_transfer *);
 
 		m = container_of(bitbang->queue.next, struct spi_message,
 				queue);
@@ -287,19 +290,19 @@ static void bitbang_work(struct work_str
 		tmp = 0;
 		cs_change = 1;
 		status = 0;
-		setup_transfer = NULL;
 
 		list_for_each_entry (t, &m->transfers, transfer_list) {
 
-			/* override or restore speed and wordsize */
-			if (t->speed_hz || t->bits_per_word) {
-				setup_transfer = bitbang->setup_transfer;
+			/* override speed or wordsize? */
+			if (t->speed_hz || t->bits_per_word)
+				do_setup = 1;
+
+			/* init (-1) or override (1) transfer params */
+			if (do_setup != 0) {
 				if (!setup_transfer) {
 					status = -ENOPROTOOPT;
 					break;
 				}
-			}
-			if (setup_transfer) {
 				status = setup_transfer(spi, t);
 				if (status < 0)
 					break;
@@ -363,9 +366,10 @@ static void bitbang_work(struct work_str
 		m->status = status;
 		m->complete(m->context);
 
-		/* restore speed and wordsize */
-		if (setup_transfer)
+		/* restore speed and wordsize if it was overridden */
+		if (do_setup == 1)
 			setup_transfer(spi, NULL);
+		do_setup = 0;
 
 		/* normally deactivate chipselect ... unless no error and
 		 * cs_change has hinted that the next message will probably


------------------------------------------------------------------------------
