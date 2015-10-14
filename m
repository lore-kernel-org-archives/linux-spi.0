From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 08/10] spi: dw: introduce spi_shutdown_chip()
Date: Wed, 14 Oct 2015 23:12:23 +0300
Message-ID: <1444853545-59868-9-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This helper disables SPI controller and sets clock to 0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 13 ++++++-------
 drivers/spi/spi-dw.h |  6 ++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a2ee776..047ffbd 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -548,22 +548,21 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
-	spi_enable_chip(dws, 0);
-	/* Disable clk */
-	spi_set_clk(dws, 0);
+
+	spi_shutdown_chip(dws);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
 
 int dw_spi_suspend_host(struct dw_spi *dws)
 {
-	int ret = 0;
+	int ret;
 
 	ret = spi_master_suspend(dws->master);
 	if (ret)
 		return ret;
-	spi_enable_chip(dws, 0);
-	spi_set_clk(dws, 0);
-	return ret;
+
+	spi_shutdown_chip(dws);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_spi_suspend_host);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b75ed32..35589a2 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -225,6 +225,12 @@ static inline void spi_reset_chip(struct dw_spi *dws)
 	spi_enable_chip(dws, 1);
 }
 
+static inline void spi_shutdown_chip(struct dw_spi *dws)
+{
+	spi_enable_chip(dws, 0);
+	spi_set_clk(dws, 0);
+}
+
 /*
  * Each SPI slave device to work with dw_api controller should
  * has such a structure claiming its working mode (poll or PIO/DMA),
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
