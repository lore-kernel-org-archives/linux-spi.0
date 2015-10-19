From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: eliminate unused threshold variables" to the spi tree
Date: Mon, 19 Oct 2015 20:43:27 +0100
Message-ID: <E1ZoGL9-0002Ko-TV@debutante>
References: <1444853545-59868-8-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-8-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: eliminate unused threshold variables

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

>From d53c0ef319eb5ceb5a089ff3050a2e6808c9adb9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 14 Oct 2015 23:12:22 +0300
Subject: [PATCH] spi: dw: eliminate unused threshold variables

The tx_threshold and rx_threshold variables are not used anywhere. Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a6fd7cfa1b40..c8e7715097e7 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -36,8 +36,6 @@ struct chip_data {
 
 	u8 poll_mode;		/* 1 means use poll mode */
 
-	u32 rx_threshold;
-	u32 tx_threshold;
 	u8 enable_dma;
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
@@ -425,9 +423,6 @@ static int dw_spi_setup(struct spi_device *spi)
 
 		chip->poll_mode = chip_info->poll_mode;
 		chip->type = chip_info->type;
-
-		chip->rx_threshold = 0;
-		chip->tx_threshold = 0;
 	}
 
 	chip->tmode = 0; /* Tx & Rx */
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
