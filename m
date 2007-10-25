From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: [RFC][PATCH 1/2] spi: fix spi_sync
Date: Thu, 25 Oct 2007 13:42:55 +0200
Message-ID: <200710251342.55501.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Ease spi_sync calling convention. There is no more need to check the return
value AND the message->status. As a side effect, this will correct the wrong
behaviour of spi_read and spi_write.

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

---

At this time (2.6.23.1), spi_read and spi_write functions only check the return
value of spi_sync. This is wrong since they should check for message->status
too.
After a short inspection of all files using spi_sync in the kernel, it seems that we
should change the spi_sync function (rather than all users).


Inspection details:
files using spi_sync without reading message->status:
drivers/mtd/devices/m25p80.c
drivers/mtd/devices/mtd_dataflash.c
drivers/spi/tle62x0.c
drivers/spi/spidev.c
drivers/spi/at25.c
include/linux/spi.h

files using spi_sync, but executing some unnecessary code when the return value
or message->status report an error:
drivers/rtc/rtc-max6902.c
drivers/spi/spi.c
drivers/input/touchscreen/ads7846.c

files using spi_sync the Right Way(TM):
[no files]

Regards

Marc

--- drivers/spi/spi.c.orig	2007-10-25 13:24:09.000000000 +0200
+++ drivers/spi/spi.c	2007-10-25 13:22:23.000000000 +0200
@@ -542,10 +542,7 @@ static void spi_complete(void *arg)
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
@@ -555,8 +552,10 @@ int spi_sync(struct spi_device *spi, str
 	message->complete = spi_complete;
 	message->context = &done;
 	status = spi_async(spi, message);
-	if (status == 0)
+	if (status == 0) {
 		wait_for_completion(&done);
+		status = m->status;
+	}
 	message->context = NULL;
 	return status;
 }
@@ -629,10 +628,8 @@ int spi_write_then_read(struct spi_devic
 
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
