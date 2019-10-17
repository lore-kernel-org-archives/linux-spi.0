From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 5/7] spi: atmel: Remove platform data support
Date: Thu, 17 Oct 2019 16:18:44 +0200
Message-ID: <20191017141846.7523-6-gregory.clement@bootlin.com>
References: <20191017141846.7523-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141846.7523-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver is now only used through the device tree. Simplify code
by explicitly depend on device tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/spi/Kconfig     |  1 +
 drivers/spi/spi-atmel.c | 16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6f7fdcbb9151..6c0c1f55bd71 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -80,6 +80,7 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on ARCH_AT91 || COMPILE_TEST
+	depends on OF
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 ARM chips.
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 19600de40422..1ff5b20eabf7 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1500,7 +1500,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
 	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = pdev->id;
-	master->num_chipselect = master->dev.of_node ? 0 : 4;
+	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 	master->transfer_one_message = atmel_spi_transfer_one_message;
@@ -1528,16 +1528,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	atmel_get_caps(as);
 
-	/*
-	 * If there are chip selects in the device tree, those will be
-	 * discovered by the SPI core when registering the SPI master
-	 * and assigned to each SPI device.
-	 */
-	if (atmel_spi_is_v2(as) &&
-	    pdev->dev.of_node &&
-	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL))
-		master->num_chipselect = 4;
-
 	as->use_dma = false;
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
@@ -1745,20 +1735,18 @@ static const struct dev_pm_ops atmel_spi_pm_ops = {
 #define ATMEL_SPI_PM_OPS	NULL
 #endif
 
-#if defined(CONFIG_OF)
 static const struct of_device_id atmel_spi_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-spi" },
 	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
-#endif
 
 static struct platform_driver atmel_spi_driver = {
 	.driver		= {
 		.name	= "atmel_spi",
 		.pm	= ATMEL_SPI_PM_OPS,
-		.of_match_table	= of_match_ptr(atmel_spi_dt_ids),
+		.of_match_table	= atmel_spi_dt_ids,
 	},
 	.probe		= atmel_spi_probe,
 	.remove		= atmel_spi_remove,
-- 
2.23.0
