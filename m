From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-pxa2xx: Remove unused legacy PXA DMA API channel numbers" to the spi tree
Date: Mon, 03 Aug 2015 17:14:36 +0100
Message-ID: <E1ZMINo-0003Sn-V6@finisterre>
References: <1438598472-1145-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438598472-1145-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-pxa2xx: Remove unused legacy PXA DMA API channel numbers

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

>From f47da2400e8828eda2ed4208fb312031f8b7d2ae Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 3 Aug 2015 13:41:11 +0300
Subject: [PATCH] spi: spi-pxa2xx: Remove unused legacy PXA DMA API channel
 numbers

These became unused by the commit 6356437e65c2
("spi: spi-pxa2xx: remove legacy PXA DMA bits").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 --
 drivers/spi/spi-pxa2xx.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2c9fa40..e924710 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1475,8 +1475,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	/* Setup DMA if requested */
-	drv_data->tx_channel = -1;
-	drv_data->rx_channel = -1;
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 9f01e9c..3b69c46 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -37,8 +37,6 @@ struct driver_data {
 	struct pxa2xx_spi_master *master_info;
 
 	/* PXA private DMA setup stuff */
-	int rx_channel;
-	int tx_channel;
 	u32 *null_dma_buf;
 
 	/* SSP register addresses */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
