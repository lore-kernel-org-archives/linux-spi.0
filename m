From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/2 V2] spi/mmc_spi: mmc_spi adaptations
 for SPI bus locking API
Date: Thu, 18 Feb 2010 12:47:46 +0100
Message-ID: <20100218124746.d1bea430.eschwab@online.de>
References: <20100218124425.599c4d76.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org,
	vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100218124425.599c4d76.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Modification of the mmc_spi driver to use the SPI bus locking API.
With this, the mmc_spi driver can be used together with other SPI
devices on the same SPI bus. The exclusive access to the SPI bus is
now managed in the SPI layer. The counting of chip selects in the probe
function is no longer needed.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
V2: pass spi_master* instead of spi* to spi_bus_lock

--- linux-2.6.33-rc8.orig/drivers/mmc/host/mmc_spi.c	2010-02-12 20:07:45.000000000 +0100
+++ buslocknew/drivers/mmc/host/mmc_spi.c	2010-02-18 12:21:26.000000000 +0100
@@ -181,7 +181,7 @@ mmc_spi_readbytes(struct mmc_spi_host *h
 				host->data_dma, sizeof(*host->data),
 				DMA_FROM_DEVICE);
 
-	status = spi_sync(host->spi, &host->readback);
+	status = spi_sync_locked(host->spi, &host->readback);
 
 	if (host->dma_dev)
 		dma_sync_single_for_cpu(host->dma_dev,
@@ -540,7 +540,7 @@ mmc_spi_command_send(struct mmc_spi_host
 				host->data_dma, sizeof(*host->data),
 				DMA_BIDIRECTIONAL);
 	}
-	status = spi_sync(host->spi, &host->m);
+	status = spi_sync_locked(host->spi, &host->m);
 
 	if (host->dma_dev)
 		dma_sync_single_for_cpu(host->dma_dev,
@@ -684,7 +684,7 @@ mmc_spi_writeblock(struct mmc_spi_host *
 				host->data_dma, sizeof(*scratch),
 				DMA_BIDIRECTIONAL);
 
-	status = spi_sync(spi, &host->m);
+	status = spi_sync_locked(spi, &host->m);
 
 	if (status != 0) {
 		dev_dbg(&spi->dev, "write error (%d)\n", status);
@@ -821,7 +821,7 @@ mmc_spi_readblock(struct mmc_spi_host *h
 				DMA_FROM_DEVICE);
 	}
 
-	status = spi_sync(spi, &host->m);
+	status = spi_sync_locked(spi, &host->m);
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
@@ -1017,7 +1017,7 @@ mmc_spi_data_do(struct mmc_spi_host *hos
 					host->data_dma, sizeof(*scratch),
 					DMA_BIDIRECTIONAL);
 
-		tmp = spi_sync(spi, &host->m);
+		tmp = spi_sync_locked(spi, &host->m);
 
 		if (host->dma_dev)
 			dma_sync_single_for_cpu(host->dma_dev,
@@ -1083,6 +1083,9 @@ static void mmc_spi_request(struct mmc_h
 	}
 #endif
 
+	/* request exclusive bus access */
+	spi_bus_lock(host->spi->master);
+
 	/* issue command; then optionally data and stop */
 	status = mmc_spi_command_send(host, mrq, mrq->cmd, mrq->data != NULL);
 	if (status == 0 && mrq->data) {
@@ -1093,6 +1096,9 @@ static void mmc_spi_request(struct mmc_h
 			mmc_cs_off(host);
 	}
 
+	/* release the bus */
+	spi_bus_unlock(host->spi->master);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -1289,23 +1295,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
 	return IRQ_HANDLED;
 }
 
-struct count_children {
-	unsigned	n;
-	struct bus_type	*bus;
-};
-
-static int maybe_count_child(struct device *dev, void *c)
-{
-	struct count_children *ccp = c;
-
-	if (dev->bus == ccp->bus) {
-		if (ccp->n)
-			return -EBUSY;
-		ccp->n++;
-	}
-	return 0;
-}
-
 static int mmc_spi_probe(struct spi_device *spi)
 {
 	void			*ones;
@@ -1337,32 +1326,6 @@ static int mmc_spi_probe(struct spi_devi
 		return status;
 	}
 
-	/* We can use the bus safely iff nobody else will interfere with us.
-	 * Most commands consist of one SPI message to issue a command, then
-	 * several more to collect its response, then possibly more for data
-	 * transfer.  Clocking access to other devices during that period will
-	 * corrupt the command execution.
-	 *
-	 * Until we have software primitives which guarantee non-interference,
-	 * we'll aim for a hardware-level guarantee.
-	 *
-	 * REVISIT we can't guarantee another device won't be added later...
-	 */
-	if (spi->master->num_chipselect > 1) {
-		struct count_children cc;
-
-		cc.n = 0;
-		cc.bus = spi->dev.bus;
-		status = device_for_each_child(spi->dev.parent, &cc,
-				maybe_count_child);
-		if (status < 0) {
-			dev_err(&spi->dev, "can't share SPI bus\n");
-			return status;
-		}
-
-		dev_warn(&spi->dev, "ASSUMING SPI bus stays unshared!\n");
-	}
-
 	/* We need a supply of ones to transmit.  This is the only time
 	 * the CPU touches these, so cache coherency isn't a concern.
 	 *


------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
