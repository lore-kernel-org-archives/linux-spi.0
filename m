From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc1-git 2/2] use simplified
	spi_sync() calling convention
Date: Sat, 27 Oct 2007 19:29:34 -0700
Message-ID: <200710271929.34914.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
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

From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>

Given the patch which simplifies the spi_sync calling convention, this
one updates the callers of that routine which tried using it according
to the previous specification.  (Most didn't.)

Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/input/touchscreen/ads7846.c |   13 ++++++-------
 drivers/mmc/host/mmc_spi.c          |   10 ----------
 drivers/rtc/rtc-max6902.c           |   12 +++---------
 3 files changed, 9 insertions(+), 26 deletions(-)

--- a/drivers/input/touchscreen/ads7846.c	2007-10-27 19:17:58.000000000 -0700
+++ b/drivers/input/touchscreen/ads7846.c	2007-10-27 19:18:11.000000000 -0700
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
--- a/drivers/mmc/host/mmc_spi.c	2007-10-27 19:17:58.000000000 -0700
+++ b/drivers/mmc/host/mmc_spi.c	2007-10-27 19:18:11.000000000 -0700
@@ -176,8 +176,6 @@ mmc_spi_readbytes(struct mmc_spi_host *h
 				DMA_FROM_DEVICE);
 
 	status = spi_sync(host->spi, &host->readback);
-	if (status == 0)
-		status = host->readback.status;
 
 	if (host->dma_dev)
 		dma_sync_single_for_cpu(host->dma_dev,
@@ -480,8 +478,6 @@ mmc_spi_command_send(struct mmc_spi_host
 				DMA_BIDIRECTIONAL);
 	}
 	status = spi_sync(host->spi, &host->m);
-	if (status == 0)
-		status = host->m.status;
 
 	if (host->dma_dev)
 		dma_sync_single_for_cpu(host->dma_dev,
@@ -624,8 +620,6 @@ mmc_spi_writeblock(struct mmc_spi_host *
 				DMA_BIDIRECTIONAL);
 
 	status = spi_sync(spi, &host->m);
-	if (status == 0)
-		status = host->m.status;
 
 	if (status != 0) {
 		dev_dbg(&spi->dev, "write error (%d)\n", status);
@@ -726,8 +720,6 @@ mmc_spi_readblock(struct mmc_spi_host *h
 		}
 
 		status = spi_sync(spi, &host->m);
-		if (status == 0)
-			status = host->m.status;
 
 		if (host->dma_dev) {
 			dma_sync_single_for_cpu(host->dma_dev,
@@ -905,8 +897,6 @@ mmc_spi_data_do(struct mmc_spi_host *hos
 					DMA_BIDIRECTIONAL);
 
 		tmp = spi_sync(spi, &host->m);
-		if (tmp == 0)
-			tmp = host->m.status;
 
 		if (host->dma_dev)
 			dma_sync_single_for_cpu(host->dma_dev,
--- a/drivers/rtc/rtc-max6902.c	2007-10-27 19:17:58.000000000 -0700
+++ b/drivers/rtc/rtc-max6902.c	2007-10-27 19:18:11.000000000 -0700
@@ -89,13 +89,9 @@ static int max6902_get_reg(struct device
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
-	if (status == 0)
-		status = message.status;
-	else
-		return status;
-
-	*data = chip->rx_buf[1];
 
+	if (status == 0)
+		*data = chip->rx_buf[1];
 	return status;
 }
 
@@ -125,9 +121,7 @@ static int max6902_get_datetime(struct d
 
 	/* do the i/o */
 	status = spi_sync(spi, &message);
-	if (status == 0)
-		status = message.status;
-	else
+	if (status)
 		return status;
 
 	/* The chip sends data in this order:

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
