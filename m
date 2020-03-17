From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: efm32: Convert to use GPIO descriptors
Date: Tue, 17 Mar 2020 10:49:14 +0100
Message-ID: <20200317094914.331932-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This switches the EFM32 driver over to use the GPIO descriptor
handling in the core. The GPIO handling in this driver is
pretty simplistic so this should just work. Drop the GPIO headers
and insert the implicitly included <linux/of.h> header.

Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-efm32.c | 44 +++--------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index 64d4c441b641..ea6e4a7b3feb 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -6,14 +6,13 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_data/efm32-spi.h>
+#include <linux/of.h>
 
 #define DRIVER_NAME "efm32-spi"
 
@@ -82,9 +81,6 @@ struct efm32_spi_ddata {
 	const u8 *tx_buf;
 	u8 *rx_buf;
 	unsigned tx_len, rx_len;
-
-	/* chip selects */
-	unsigned csgpio[];
 };
 
 #define ddata_to_dev(ddata)	(&(ddata->bitbang.master->dev))
@@ -102,14 +98,6 @@ static u32 efm32_spi_read32(struct efm32_spi_ddata *ddata, unsigned offset)
 	return readl_relaxed(ddata->base + offset);
 }
 
-static void efm32_spi_chipselect(struct spi_device *spi, int is_on)
-{
-	struct efm32_spi_ddata *ddata = spi_master_get_devdata(spi->master);
-	int value = !(spi->mode & SPI_CS_HIGH) == !(is_on == BITBANG_CS_ACTIVE);
-
-	gpio_set_value(ddata->csgpio[spi->chip_select], value);
-}
-
 static int efm32_spi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
@@ -320,17 +308,11 @@ static int efm32_spi_probe(struct platform_device *pdev)
 	int ret;
 	struct spi_master *master;
 	struct device_node *np = pdev->dev.of_node;
-	int num_cs, i;
 
 	if (!np)
 		return -EINVAL;
 
-	num_cs = of_gpio_named_count(np, "cs-gpios");
-	if (num_cs < 0)
-		return num_cs;
-
-	master = spi_alloc_master(&pdev->dev,
-			sizeof(*ddata) + num_cs * sizeof(unsigned));
+	master = spi_alloc_master(&pdev->dev, sizeof(*ddata));
 	if (!master) {
 		dev_dbg(&pdev->dev,
 				"failed to allocate spi master controller\n");
@@ -340,14 +322,13 @@ static int efm32_spi_probe(struct platform_device *pdev)
 
 	master->dev.of_node = pdev->dev.of_node;
 
-	master->num_chipselect = num_cs;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+	master->use_gpio_descriptors = true;
 
 	ddata = spi_master_get_devdata(master);
 
 	ddata->bitbang.master = master;
-	ddata->bitbang.chipselect = efm32_spi_chipselect;
 	ddata->bitbang.setup_transfer = efm32_spi_setup_transfer;
 	ddata->bitbang.txrx_bufs = efm32_spi_txrx_bufs;
 
@@ -361,25 +342,6 @@ static int efm32_spi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	for (i = 0; i < num_cs; ++i) {
-		ret = of_get_named_gpio(np, "cs-gpios", i);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get csgpio#%u (%d)\n",
-					i, ret);
-			goto err;
-		}
-		ddata->csgpio[i] = ret;
-		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, ddata->csgpio[i]);
-		ret = devm_gpio_request_one(&pdev->dev, ddata->csgpio[i],
-				GPIOF_OUT_INIT_LOW, DRIVER_NAME);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-					"failed to configure csgpio#%u (%d)\n",
-					i, ret);
-			goto err;
-		}
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
-- 
2.24.1
