From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: use DMA by default if supported" to the spi tree
Date: Mon, 30 May 2016 18:39:33 +0100
Message-ID: <E1b7RA5-0000tn-3z@debutante>
References: <1464375468-11510-1-git-send-email-dan@emutex.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	robert.jarzmik-GANU6spQydw@public.gmane.org
To: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464375468-11510-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: use DMA by default if supported

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

>From c64e1265ae8516c0282b45e099ac5fbdb8486c4c Mon Sep 17 00:00:00 2001
From: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Date: Fri, 27 May 2016 19:57:48 +0100
Subject: [PATCH] spi: pxa2xx: use DMA by default if supported

Currently, even if the PXA2xx SPI master supports DMA, it won't be
enabled unless (i) the slave device is enumerated through ACPI, or
(ii) the slave device is registered with board-specific
controller_data specified.  Even then, there isn't a field in the
controller_data that explicitly enables dma - it just gets enabled
if the master supports it and controller_data is non-NULL.

This means that drivers which register SPI devices on a bus without
awareness of this controller cannot avail of DMA performance gains.

This patch allows DMA transfers to be used if supported.

Signed-off-by: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fe07c0592b44..27e03076f379 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1240,7 +1240,7 @@ static int setup(struct spi_device *spi)
 			chip->frm = spi->chip_select;
 		} else
 			chip->gpio_cs = -1;
-		chip->enable_dma = 0;
+		chip->enable_dma = drv_data->master_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
 	}
 
@@ -1259,17 +1259,9 @@ static int setup(struct spi_device *spi)
 			tx_hi_thres = chip_info->tx_hi_threshold;
 		if (chip_info->rx_threshold)
 			rx_thres = chip_info->rx_threshold;
-		chip->enable_dma = drv_data->master_info->enable_dma;
 		chip->dma_threshold = 0;
 		if (chip_info->enable_loopback)
 			chip->cr1 = SSCR1_LBM;
-	} else if (ACPI_HANDLE(&spi->dev)) {
-		/*
-		 * Slave devices enumerated from ACPI namespace don't
-		 * usually have chip_info but we still might want to use
-		 * DMA with them.
-		 */
-		chip->enable_dma = drv_data->master_info->enable_dma;
 	}
 
 	chip->lpss_rx_threshold = SSIRF_RxThresh(rx_thres);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
