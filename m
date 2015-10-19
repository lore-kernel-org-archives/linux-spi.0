From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: introduce spi_shutdown_chip()" to the spi tree
Date: Mon, 19 Oct 2015 20:43:27 +0100
Message-ID: <E1ZoGL9-0002KK-0Q@debutante>
References: <1444853545-59868-9-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-9-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: introduce spi_shutdown_chip()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1cc3f141f0cb5a822cdef30fb1d92ae6f4176bfa Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:23 +0300
Subject: [PATCH] spi: dw: introduce spi_shutdown_chip()

This helper disables SPI controller and sets clock to 0.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 13 ++++++-------
 drivers/spi/spi-dw.h |  6 ++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index c8e7715097e7..a730c353d3bf 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -546,22 +546,21 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
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
index b75ed327d5a2..35589a270468 100644
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
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
