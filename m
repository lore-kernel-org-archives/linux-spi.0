From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 2/3] mmc_spi: add support for
	card-detection polling
Date: Fri, 23 May 2008 19:43:43 +0400
Message-ID: <20080523154343.GB24862@polina.dev.rtsoft.ru>
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
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
In-Reply-To: <20080523154204.GA19803-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

This patch adds new platform data variable "caps", so platforms
could pass theirs capabilities into MMC core (for example, platforms
without interrupt on the CD line will most probably want to pass
MMC_CAP_NEEDS_POLL).

New platform get_cd() callback provided to optimize polling.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/mmc/host/mmc_spi.c  |   19 +++++++++++++++++--
 include/linux/spi/mmc_spi.h |    9 +++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 3550858..724870c 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1131,11 +1131,20 @@ static int mmc_spi_get_ro(struct mmc_host *mmc)
 	return 0;
 }
 
+static int mmc_spi_get_cd(struct mmc_host *mmc)
+{
+	struct mmc_spi_host *host = mmc_priv(mmc);
+
+	if (host->pdata && host->pdata->get_cd)
+		return host->pdata->get_cd(mmc->parent);
+	return -ENOSYS;
+}
 
 static const struct mmc_host_ops mmc_spi_ops = {
 	.request	= mmc_spi_request,
 	.set_ios	= mmc_spi_set_ios,
 	.get_ro		= mmc_spi_get_ro,
+	.get_cd		= mmc_spi_get_cd,
 };
 
 
@@ -1319,17 +1328,23 @@ static int mmc_spi_probe(struct spi_device *spi)
 			goto fail_glue_init;
 	}
 
+	/* pass platform capabilities, if any */
+	if (host->pdata)
+		mmc->caps |= host->pdata->caps;
+
 	status = mmc_add_host(mmc);
 	if (status != 0)
 		goto fail_add_host;
 
-	dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
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
index d5ca78b..a3626ae 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -23,6 +23,15 @@ struct mmc_spi_platform_data {
 	/* sense switch on sd cards */
 	int (*get_ro)(struct device *);
 
+	/*
+	 * If board does not use CD interrupts, driver can optimize polling
+	 * using this function.
+	 */
+	int (*get_cd)(struct device *);
+
+	/* Capabilities to pass into mmc core (e.g. MMC_CAP_NEEDS_POLL). */
+	unsigned long caps;
+
 	/* how long to debounce card detect, in msecs */
 	u16 detect_delay;
 
-- 
1.5.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
