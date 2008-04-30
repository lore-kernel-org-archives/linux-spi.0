From: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] Add card detect switch sensing during
	mmc_rescan
Date: Wed, 30 Apr 2008 17:35:39 -0400
Message-ID: <1CF6EDDF0820924DA43C9A52FE7325950B09962E@MI8NYCMAIL17.Mi8.com>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com><20080424140541.773f6e6b@mjolnir.drzeus.cx><200804291708.09424.david-b@pacbell.net>
	<200804291738.34965.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <200804291738.34965.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

The following patch adds optional card detect switch sensing.

This eliminates having to probe to determine what type of card is
installed in mmc_rescan() if we can determine that nothing is installed.

It eliminates the "mmc0: error -22 whilst initialising SDIO card" error
message that occurs when nothing is installed in the socket. It also
makes mmc_detect_change() in the mmc_spi.c driver work correctly.

This was tested on an EP93xx based platform with the mmc_spi.c driver.

Please let me know if there is anything wrong with this patch.

Thanks,
Hartley Sweeten


diff -burN linux-2.6.25/include/linux/mmc/host.h
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/include/linux/mm
c/host.h
--- linux-2.6.25/include/linux/mmc/host.h	2008-04-16
19:49:44.000000000 -0700
+++
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/include/linux/mm
c/host.h	2008-04-30 13:49:27.000000000 -0700
@@ -54,6 +54,7 @@
 	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*get_ro)(struct mmc_host *host);
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+	int	(*get_cd)(struct mmc_host *host);
 };
 
 struct mmc_card;
diff -burN linux-2.6.25/drivers/mmc/core/core.c
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/drivers/mmc/core
/core.c
--- linux-2.6.25/drivers/mmc/core/core.c	2008-04-16
19:49:44.000000000 -0700
+++
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/drivers/mmc/core
/core.c	2008-04-30 14:24:58.000000000 -0700
@@ -650,6 +650,17 @@
 		mmc_send_if_cond(host, host->ocr_avail);
 
 		/*
+		 * Check the card detect switch, if supported...
+		 */
+		if (host->ops->get_cd) {
+			if (!host->ops->get_cd(host)) {
+				mmc_release_host(host);
+				mmc_power_off(host);
+				return;
+			}
+		}
+
+		/*
 		 * First we search for SDIO...
 		 */
 		err = mmc_send_io_op_cond(host, 0, &ocr);
@@ -682,8 +693,19 @@
 		mmc_release_host(host);
 		mmc_power_off(host);
 	} else {
-		if (host->bus_ops->detect && !host->bus_dead)
+		if (host->ops->get_cd) {
+			if (!host->ops->get_cd(host)) {
+				if (host->bus_ops->remove &&
!host->bus_dead) {
+					host->bus_ops->remove(host);
+
+					mmc_claim_host(host);
+					mmc_detach_bus(host);
+					mmc_release_host(host);
+				}
+			}
+		} else if (host->bus_ops->detect && !host->bus_dead) {
 			host->bus_ops->detect(host);
+		}
 
 		mmc_bus_put(host);
 	}
diff -burN linux-2.6.25/drivers/mmc/host/mmc_spi.c
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/drivers/mmc/host
/mmc_spi.c
--- linux-2.6.25/drivers/mmc/host/mmc_spi.c	2008-04-16
19:49:44.000000000 -0700
+++
/home/bigguiness/linux-crater_1-0-3/kernel/linux-2.6.25/drivers/mmc/host
/mmc_spi.c	2008-04-30 14:25:41.000000000 -0700
@@ -1131,11 +1131,21 @@
 	return 0;
 }
 
+static int mmc_spi_get_cd(struct mmc_host *mmc)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
+
+	if (host->pdata && host->pdata->get_cd)
+		return host->pdata->get_cd(mmc->parent);
+	/* board doesn't support card detection; assume present */
+	return 1;
+}
 
 static const struct mmc_host_ops mmc_spi_ops = {
 	.request	= mmc_spi_request,
 	.set_ios	= mmc_spi_set_ios,
 	.get_ro		= mmc_spi_get_ro,
+	.get_cd		= mmc_spi_get_cd,
 };
 
  

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
