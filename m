From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: add SPI_LSB_FIRST to driver capabilities" to the spi tree
Date: Thu, 16 Nov 2017 19:30:06 +0000 (GMT)
Message-ID: <20171116193006.86CC744005B@finisterre.ee.mobilebroadband>
References: <20171113074721.22404-1-kurt@linutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171113074721.22404-1-kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: add SPI_LSB_FIRST to driver capabilities

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

>From 00ac9562158e8541d60e91eb72aa9ed0674d4a6a Mon Sep 17 00:00:00 2001
From: Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Date: Mon, 13 Nov 2017 08:47:21 +0100
Subject: [PATCH] spi: spi-fsl-dspi: add SPI_LSB_FIRST to driver capabilities

The driver as well as the controller support the SPI lsb first
mode. However, it's not possible to configure it e.g. when using
spidev. Adding this flag to mode_bits resolves the issue and lsb first
mode can be used.

Signed-off-by: Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f652f70cb8db..02d3ed7f2558 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -980,7 +980,7 @@ static int dspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 
 	master->cleanup = dspi_cleanup;
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(4) | SPI_BPW_MASK(8) |
 					SPI_BPW_MASK(16);
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
