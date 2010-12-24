From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Patch v2 2/3] spi/dw_spi: change to EXPORT_SYMBOL_GPL for exported
	APIs
Date: Fri, 24 Dec 2010 13:59:10 +0800
Message-ID: <1293170351-7426-2-git-send-email-feng.tang@intel.com>
References: <1293170351-7426-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1293170351-7426-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/dw_spi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 25238a8..b50bf5b 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -941,7 +941,7 @@ err_free_master:
 exit:
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_add_host);
+EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
 void __devexit dw_spi_remove_host(struct dw_spi *dws)
 {
@@ -965,7 +965,7 @@ void __devexit dw_spi_remove_host(struct dw_spi *dws)
 	/* Disconnect from the SPI framework */
 	spi_unregister_master(dws->master);
 }
-EXPORT_SYMBOL(dw_spi_remove_host);
+EXPORT_SYMBOL_GPL(dw_spi_remove_host);
 
 int dw_spi_suspend_host(struct dw_spi *dws)
 {
@@ -978,7 +978,7 @@ int dw_spi_suspend_host(struct dw_spi *dws)
 	spi_set_clk(dws, 0);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_suspend_host);
+EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
 
 int dw_spi_resume_host(struct dw_spi *dws)
 {
@@ -990,7 +990,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 		dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);
 	return ret;
 }
-EXPORT_SYMBOL(dw_spi_resume_host);
+EXPORT_SYMBOL_GPL(dw_spi_resume_host);
 
 MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Driver for DesignWare SPI controller core");
-- 
1.7.0.4


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
