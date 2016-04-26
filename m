From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32: Set proper bits_per_word_mask" to the spi tree
Date: Tue, 26 Apr 2016 11:26:52 +0100
Message-ID: <E1av0Ci-00079r-AS@debutante>
References: <1461627075.5054.1.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461627075.5054.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32: Set proper bits_per_word_mask

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

>From 2452ee25255af95d122ff66ea390facb67a61fc3 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Tue, 26 Apr 2016 07:31:15 +0800
Subject: [PATCH] spi: pic32: Set proper bits_per_word_mask

This driver only supports 8/16/32 bits_per_word, so set
master->bits_per_word_mask accordingly. With this change, we can remove
the spi->bits_per_word checking in pic32_spi_setup as it's done by spi
core.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pic32.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f8313ea11a34..4eeb8a85b030 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -592,16 +592,6 @@ static int pic32_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	switch (spi->bits_per_word) {
-	case 8:
-	case 16:
-	case 32:
-		break;
-	default:
-		dev_err(&spi->dev, "Invalid bits_per_word defined\n");
-		return -EINVAL;
-	}
-
 	/* PIC32 spi controller can drive /CS during transfer depending
 	 * on tx fifo fill-level. /CS will stay asserted as long as TX
 	 * fifo is non-empty, else will be deasserted indicating
@@ -791,7 +781,8 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	master->setup		= pic32_spi_setup;
 	master->cleanup		= pic32_spi_cleanup;
 	master->flags		= SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX;
-	master->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
+	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+					  SPI_BPW_MASK(32);
 	master->transfer_one		= pic32_spi_one_transfer;
 	master->prepare_message		= pic32_spi_prepare_message;
 	master->unprepare_message	= pic32_spi_unprepare_message;
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
