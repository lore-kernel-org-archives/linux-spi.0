From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Fix cs_change handling in message transfer" to the spi tree
Date: Tue, 05 Apr 2016 12:13:18 -0700
Message-ID: <E1anWPe-0001J1-Gm@finisterre>
References: <1459859594-3414-1-git-send-email-andrey.vostrikov@cogentembedded.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459859594-3414-1-git-send-email-andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Fix cs_change handling in message transfer

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

>From 92dc20d83adec565378254c0630e839ff5674e14 Mon Sep 17 00:00:00 2001
From: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Date: Tue, 5 Apr 2016 15:33:14 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Fix cs_change handling in message transfer

There are use cases when chip select should be triggered between transfers
in single SPI message. Current implementation does this only on last
transfer in message ignoring cs_change value provided in current transfer.

Signed-off-by: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 39412c9097c6..c1a2d747b246 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -385,8 +385,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->cur_chip = spi_get_ctldata(spi);
 		dspi->cs = spi->chip_select;
 		dspi->cs_change = 0;
-		if (dspi->cur_transfer->transfer_list.next
-				== &dspi->cur_msg->transfers)
+		if (list_is_last(&dspi->cur_transfer->transfer_list,
+				 &dspi->cur_msg->transfers) || transfer->cs_change)
 			dspi->cs_change = 1;
 		dspi->void_write_data = dspi->cur_chip->void_write_data;
 
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
