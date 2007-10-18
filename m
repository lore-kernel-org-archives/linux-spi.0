From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: [RFC,
	PATCH] SPI: fix return value for spi_read and spi_write
Date: Thu, 18 Oct 2007 18:40:38 +0200
Message-ID: <200710181840.38821.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

spi_read and spi_write functions don't report late errors, for instance fifo
underrun.

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

---

Hi all!

spi_read and spi_write should not only report errors from spi_sync, but
also from message->status when spi_sync worked.

Regards

Marc

--- include/linux/spi/spi.h.orig	2007-10-18 18:24:15.000000000 +0200
+++ include/linux/spi/spi.h	2007-10-18 18:38:10.000000000 +0200
@@ -593,6 +593,7 @@ extern int spi_sync(struct spi_device *s
 static inline int
 spi_write(struct spi_device *spi, const u8 *buf, size_t len)
 {
+	int status;
 	struct spi_transfer	t = {
 			.tx_buf		= buf,
 			.len		= len,
@@ -601,7 +602,10 @@ spi_write(struct spi_device *spi, const 
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spi_sync(spi, &m);
+
+	status = spi_sync(spi, &m);
+
+	return (status) ? status : m.status;
 }
 
 /**
@@ -617,6 +621,7 @@ spi_write(struct spi_device *spi, const 
 static inline int
 spi_read(struct spi_device *spi, u8 *buf, size_t len)
 {
+	int status;
 	struct spi_transfer	t = {
 			.rx_buf		= buf,
 			.len		= len,
@@ -625,7 +630,10 @@ spi_read(struct spi_device *spi, u8 *buf
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spi_sync(spi, &m);
+
+	status = spi_sync(spi, &m);
+
+	return (status) ? status : m.status;
 }
 
 /* this copies txbuf and rxbuf data; for small transfers only! */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
