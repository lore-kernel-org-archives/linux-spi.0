From: Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: add SPI_LSB_FIRST to driver capabilities
Date: Mon, 13 Nov 2017 08:47:21 +0100
Message-ID: <20171113074721.22404-1-kurt@linutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver as well as the controller support the SPI lsb first
mode. However, it's not possible to configure it e.g. when using
spidev. Adding this flag to mode_bits resolves the issue and lsb first
mode can be used.

Signed-off-by: Kurt Kanzenbach <kurt-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
