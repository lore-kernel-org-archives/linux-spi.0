From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/5] mmc_spi: added spi_lock_bus
Date: Tue, 16 Feb 2010 20:57:33 +0100
Message-ID: <20100216205733.580dbf93.eschwab@online.de>
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

From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

The MMC/SPI spec does not play well with typical SPI design -- it often
needs to send out a command in one message, read a response, then do some
other arbitrary step.  Since we can't let another SPI client use the bus
during this time, use the new SPI lock/unlock functions to provide the
required exclusivity.

Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/mmc_spi.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index a461017..a96e058 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1084,6 +1084,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #endif
 
 	/* issue command; then optionally data and stop */
+	spi_lock_bus(host->spi);
 	status = mmc_spi_command_send(host, mrq, mrq->cmd, mrq->data != NULL);
 	if (status == 0 && mrq->data) {
 		mmc_spi_data_do(host, mrq->cmd, mrq->data, mrq->data->blksz);
@@ -1092,7 +1093,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		else
 			mmc_cs_off(host);
 	}
-
+	spi_unlock_bus(host->spi);
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -1337,32 +1338,6 @@ static int mmc_spi_probe(struct spi_device *spi)
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
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
