From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Remove unused members from struct chip_data" to the spi tree
Date: Fri, 26 Jan 2018 15:26:24 +0000
Message-ID: <E1ef5tY-0006jD-6r@debutante>
References: <20180126142449.18954-1-jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180126142449.18954-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Remove unused members from struct chip_data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 993181e151311936d7a343fccd6cc4cebe83ad81 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Fri, 26 Jan 2018 16:24:49 +0200
Subject: [PATCH] spi: dw: Remove unused members from struct chip_data

Local struct chip_data has two members that are not used:

- cs. Looks like was never used
- enable_dma. Became unused by the commit f89a6d8f43eb ("spi: dw-mid: move
  to use core SPI DMA mappings").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b217c22ff72f..211cc7d75bf8 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -30,13 +30,11 @@
 
 /* Slave spi_dev related */
 struct chip_data {
-	u8 cs;			/* chip select pin */
 	u8 tmode;		/* TR/TO/RO/EEPROM */
 	u8 type;		/* SPI/SSP/MicroWire */
 
 	u8 poll_mode;		/* 1 means use poll mode */
 
-	u8 enable_dma;
 	u16 clk_div;		/* baud rate divider */
 	u32 speed_hz;		/* baud rate */
 	void (*cs_control)(u32 command);
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
