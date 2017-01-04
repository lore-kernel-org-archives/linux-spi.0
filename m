From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)" to the spi tree
Date: Wed, 04 Jan 2017 18:37:30 +0000
Message-ID: <E1cOqRG-00023x-MG@debutante>
References: <20170103134820.159600-1-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170103134820.159600-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)

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

>From cf1716e9dae5b21b9bbcfe5eb0106c3b0aee37e8 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 3 Jan 2017 15:48:20 +0200
Subject: [PATCH] spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)

The commit a3ff9582369e ("spi: dw-mid: switch to new dmaengine_terminate_*
API") converted mid_spi_dma_exit() but missed mid_spi_dma_stop().

This is follow up to convert the rest.

Fixes: a3ff9582369e ("spi: dw-mid: switch to new dmaengine_terminate_* API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index e31971f91475..837cb8d0bac6 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -274,11 +274,11 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 static void mid_spi_dma_stop(struct dw_spi *dws)
 {
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
-		dmaengine_terminate_all(dws->txchan);
+		dmaengine_terminate_sync(dws->txchan);
 		clear_bit(TX_BUSY, &dws->dma_chan_busy);
 	}
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy)) {
-		dmaengine_terminate_all(dws->rxchan);
+		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
