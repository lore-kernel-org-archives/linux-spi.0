From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: [RFC][PATCH 2/2] spi: fix spi_sync
Date: Thu, 25 Oct 2007 13:43:18 +0200
Message-ID: <200710251343.19356.marc.pignat@hevs.ch>
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

Fix spi_sync calling convention, fix spi_sync users.

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

---

Regards

Marc

--- drivers/rtc/rtc-max6902.c.orig	2007-10-25 13:29:26.000000000 +0200
+++ drivers/rtc/rtc-max6902.c	2007-10-25 13:29:17.000000000 +0200
@@ -89,14 +89,12 @@ static int max6902_get_reg(struct device
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
-	if (status == 0)
-		status = message.status;
-	else
+	if (status)
 		return status;
 
 	*data = chip->rx_buf[1];
 
-	return status;
+	return 0;
 }
 
 static int max6902_get_datetime(struct device *dev, struct rtc_time *dt)
@@ -125,9 +123,7 @@ static int max6902_get_datetime(struct d
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
-	if (status == 0)
-		status = message.status;
-	else
+	if (status)
 		return status;
 
 	/* The chip sends data in this order:
--- drivers/input/touchscreen/ads7846.c.orig	2007-10-25 13:30:11.000000000 +0200
+++ drivers/input/touchscreen/ads7846.c	2007-10-25 13:40:48.000000000 +0200
@@ -267,13 +267,12 @@ static int ads7846_read12_ser(struct dev
 	ts->irq_disabled = 0;
 	enable_irq(spi->irq);
 
-	if (req->msg.status)
-		status = req->msg.status;
-
-	/* on-wire is a must-ignore bit, a BE12 value, then padding */
-	sample = be16_to_cpu(req->sample);
-	sample = sample >> 3;
-	sample &= 0x0fff;
+	if (status == 0) {
+		/* on-wire is a must-ignore bit, a BE12 value, then padding */
+		sample = be16_to_cpu(req->sample);
+		sample = sample >> 3;
+		sample &= 0x0fff;
+	}
 
 	kfree(req);
 	return status ? status : sample;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
