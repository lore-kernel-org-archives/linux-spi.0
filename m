From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc1-git 1/2] simplify spi_sync()
	calling convention
Date: Sat, 27 Oct 2007 19:22:27 -0700
Message-ID: <200710271922.28212.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
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

From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

Simplify spi_sync calling convention, eliminating the need to check
both the return value AND the message->status.  In consequence, this
corrects misbehaviours of spi_read and spi_write (which only checked
the former) and their callers.

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/spi/spi.c	2007-10-27 18:37:42.000000000 -0700
+++ b/drivers/spi/spi.c	2007-10-27 18:42:32.000000000 -0700
@@ -539,10 +539,7 @@ static void spi_complete(void *arg)
  * Also, the caller is guaranteeing that the memory associated with the
  * message will not be freed before this call returns.
  *
- * The return value is a negative error code if the message could not be
- * submitted, else zero.  When the value is zero, then message->status is
- * also defined;  it's the completion code for the transfer, either zero
- * or a negative error code from the controller driver.
+ * It returns zero on success, else a negative error code.
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
 {
@@ -552,8 +549,10 @@ int spi_sync(struct spi_device *spi, str
 	message->complete = spi_complete;
 	message->context = &done;
 	status = spi_async(spi, message);
-	if (status == 0)
+	if (status == 0) {
 		wait_for_completion(&done);
+		status = message->status;
+	}
 	message->context = NULL;
 	return status;
 }
@@ -626,10 +625,8 @@ int spi_write_then_read(struct spi_devic
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
-	if (status == 0) {
+	if (status == 0)
 		memcpy(rxbuf, x[1].rx_buf, n_rx);
-		status = message.status;
-	}
 
 	if (x[0].tx_buf == buf)
 		up(&lock);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
