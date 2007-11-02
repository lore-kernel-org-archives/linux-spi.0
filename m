From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] Blackfin SPI driver: use void
	__iomem * for regs_base
Date: Fri,  2 Nov 2007 10:38:30 +0800
Message-ID: <1193971112-7744-3-git-send-email-bryan.wu@analog.com>
References: <1193971112-7744-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193971112-7744-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index fc0c374..a6f6d5f 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -78,7 +78,7 @@ struct driver_data {
 	struct spi_master *master;
 
 	/* Regs base of SPI controller */
-	u32 regs_base;
+	void __iomem *regs_base;
 
 	/* BFIN hookup */
 	struct bfin5xx_spi_master *master_info;
@@ -1301,9 +1301,8 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		goto out_error_get_res;
 	}
 
-	drv_data->regs_base = (u32) ioremap(res->start,
-					(res->end - res->start + 1));
-	if (!drv_data->regs_base) {
+	drv_data->regs_base = ioremap(res->start, (res->end - res->start + 1));
+	if (drv_data->regs_base == NULL) {
 		dev_err(dev, "Cannot map IO\n");
 		status = -ENXIO;
 		goto out_error_ioremap;
@@ -1342,7 +1341,7 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
 		goto out_error;
 	}
 
-	dev_info(dev, "%s, Version %s, regs_base@0x%08x, dma channel@%d\n",
+	dev_info(dev, "%s, Version %s, regs_base@%p, dma channel@%d\n",
 		DRV_DESC, DRV_VERSION, drv_data->regs_base,
 		drv_data->dma_channel);
 	return status;
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
