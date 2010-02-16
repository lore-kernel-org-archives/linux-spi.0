From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 4/5] mmc_spi: added spi_register_lock_bus
Date: Tue, 16 Feb 2010 20:57:38 +0100
Message-ID: <20100216205738.535a7081.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Added spi_register_lock_bus call to mmc_spi, removed code that counts 
the number of SPI devices.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff -upr a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1083,8 +1083,10 @@ static void mmc_spi_request(struct mmc_h
 	}
 #endif
 
-	/* issue command; then optionally data and stop */
+	/* request exclusive bus access */
 	spi_lock_bus(host->spi);
+
+	/* issue command; then optionally data and stop */
 	status = mmc_spi_command_send(host, mrq, mrq->cmd, mrq->data != NULL);
 	if (status == 0 && mrq->data) {
 		mmc_spi_data_do(host, mrq->cmd, mrq->data, mrq->data->blksz);
@@ -1093,7 +1095,10 @@ static void mmc_spi_request(struct mmc_h
 		else
 			mmc_cs_off(host);
 	}
+
+	/* release the bus */
 	spi_unlock_bus(host->spi);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -1290,23 +1295,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
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
@@ -1338,6 +1326,13 @@ static int mmc_spi_probe(struct spi_devi
 		return status;
 	}
 
+	/* Ensure that the driver can get exclusive access. */
+	status = spi_register_lock_bus(spi);
+	if (status < 0) {
+		dev_err(&spi->dev, "can't share SPI bus\n");
+		return -EBUSY;
+	}
+
 	/* We need a supply of ones to transmit.  This is the only time
 	 * the CPU touches these, so cache coherency isn't a concern.
 	 *
@@ -1471,6 +1466,7 @@ fail_nobuf1:
 
 nomem:
 	kfree(ones);
+	spi_unregister_lock_bus(spi);
 	return status;
 }
 
@@ -1503,6 +1499,7 @@ static int __devexit mmc_spi_remove(stru
 		mmc_free_host(mmc);
 		mmc_spi_put_pdata(spi);
 		dev_set_drvdata(&spi->dev, NULL);
+		spi_unregister_lock_bus(spi);
 	}
 	return 0;
 }



------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
