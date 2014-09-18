From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 06/10] spi: dw: introduce support of loopback mode
Date: Thu, 18 Sep 2014 20:08:56 +0300
Message-ID: <1411060140-2801-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1411060140-2801-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411060140-2801-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For testing purposes it's good to have a loopback mode enabled. The patch adds
necessary bits for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index d58edfe..54e195b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -599,6 +599,9 @@ static int dw_spi_setup(struct spi_device *spi)
 			| (spi->mode  << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
 
+	if (spi->mode & SPI_LOOP)
+		chip->cr0 |= 1 << SPI_SRL_OFFSET;
+
 	if (gpio_is_valid(spi->cs_gpio)) {
 		ret = gpio_direction_output(spi->cs_gpio,
 				!(spi->mode & SPI_CS_HIGH));
@@ -666,7 +669,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		goto err_free_master;
 	}
 
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
