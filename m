From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 2/2] mmc_spi: add support for
	card-detection polling
Date: Wed, 21 May 2008 22:47:52 +0400
Message-ID: <20080521184752.GB32052@polina.dev.rtsoft.ru>
References: <20080521184713.GA30284@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080521184713.GA30284-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

If platform_data lacks init() callback (solely used to request
card-detect interrupt), we mark the host as MMC_CAP_NEEDS_POLL.

get_cd() host operation provided to optimize polling.

p.s. Since mmc_host_ops no longer the same for every instance of
mmc_spi, struct mmc_host_ops can't be const and should be allocated
dynamically.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/mmc/host/mmc_spi.c  |   31 +++++++++++++++++++++----------
 include/linux/spi/mmc_spi.h |    6 ++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 3550858..667855a 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -115,6 +115,7 @@ struct scratch {
 
 struct mmc_spi_host {
 	struct mmc_host		*mmc;
+	struct mmc_host_ops	mmc_spi_ops;
 	struct spi_device	*spi;
 
 	unsigned char		power_mode;
@@ -1131,13 +1132,12 @@ static int mmc_spi_get_ro(struct mmc_host *mmc)
 	return 0;
 }
 
+static int mmc_spi_get_cd(struct mmc_host *mmc)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
 
-static const struct mmc_host_ops mmc_spi_ops = {
-	.request	= mmc_spi_request,
-	.set_ios	= mmc_spi_set_ios,
-	.get_ro		= mmc_spi_get_ro,
-};
-
+	return host->pdata->get_cd(mmc->parent);
+}
 
 /****************************************************************************/
 
@@ -1236,8 +1236,12 @@ static int mmc_spi_probe(struct spi_device *spi)
 	mmc = mmc_alloc_host(sizeof(*host), &spi->dev);
 	if (!mmc)
 		goto nomem;
+	host = mmc_priv(mmc);
 
-	mmc->ops = &mmc_spi_ops;
+	host->mmc_spi_ops.request = mmc_spi_request,
+	host->mmc_spi_ops.set_ios = mmc_spi_set_ios,
+	host->mmc_spi_ops.get_ro = mmc_spi_get_ro,
+	mmc->ops = &host->mmc_spi_ops;
 	mmc->max_blk_size = MMC_SPI_BLOCKSIZE;
 
 	/* As long as we keep track of the number of successfully
@@ -1256,7 +1260,6 @@ static int mmc_spi_probe(struct spi_device *spi)
 	mmc->f_min = 400000;
 	mmc->f_max = spi->max_speed_hz;
 
-	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->spi = spi;
 
@@ -1323,13 +1326,21 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (status != 0)
 		goto fail_add_host;
 
-	dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
+	if (host->pdata && !host->pdata->init)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
+	if (host->pdata && host->pdata->get_cd)
+		host->mmc_spi_ops.get_cd = mmc_spi_get_cd;
+
+	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
 			mmc->class_dev.bus_id,
 			host->dma_dev ? "" : ", no DMA",
 			(host->pdata && host->pdata->get_ro)
 				? "" : ", no WP",
 			(host->pdata && host->pdata->setpower)
-				? "" : ", no poweroff");
+				? "" : ", no poweroff",
+			(mmc->caps & MMC_CAP_NEEDS_POLL)
+				? ", cd polling" : "");
 	return 0;
 
 fail_add_host:
diff --git a/include/linux/spi/mmc_spi.h b/include/linux/spi/mmc_spi.h
index d5ca78b..915faf3 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -23,6 +23,12 @@ struct mmc_spi_platform_data {
 	/* sense switch on sd cards */
 	int (*get_ro)(struct device *);
 
+	/*
+	 * if board does not use CD interrupts, driver can poll the CD
+	 * line using this function.
+	 */
+	int (*get_cd)(struct device *);
+
 	/* how long to debounce card detect, in msecs */
 	u16 detect_delay;
 
-- 
1.5.5.1

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
