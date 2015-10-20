From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 2/2] spi: dw: remove a NULL check when call ->remove()
Date: Tue, 20 Oct 2015 12:11:41 +0300
Message-ID: <1445332301-15126-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1445332301-15126-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445332301-15126-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently all users aware about calling dw_spi_remove_host() with properly set
parameter. Remove unneeded check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 221ff97..cc2e980 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -540,8 +540,6 @@ EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
 void dw_spi_remove_host(struct dw_spi *dws)
 {
-	if (!dws)
-		return;
 	dw_spi_debugfs_remove(dws);
 
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
