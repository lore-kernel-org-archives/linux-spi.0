From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] spi: orion: Handle GPIO chip-selects
Date: Tue, 23 May 2017 12:45:31 +1200
Message-ID: <20170523004531.17538-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some hardware designs use GPIOs to add (or supplement) the SPI
chip-select so that more than one SPI slave device can be used.

For this to work with the spi-orion driver the SPI_MASTER_GPIO_SS flag
needs to be set (because the other outputs are gated internally by the
CS) and the correct chip-select (in this case CS0) needs to be driven by
the controller.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-orion.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index be2e87ee8b31..28fc9f161b9d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
+#include <linux/gpio.h>
 #include <asm/unaligned.h>
 
 #define DRIVER_NAME			"orion_spi"
@@ -320,12 +321,18 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct orion_spi *orion_spi;
+	int cs;
+
+	if (gpio_is_valid(spi->cs_gpio))
+		cs = 0;
+	else
+		cs = spi->chip_select;
 
 	orion_spi = spi_master_get_devdata(spi->master);
 
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
 	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
-				ORION_SPI_CS(spi->chip_select));
+				ORION_SPI_CS(cs));
 
 	/* Chip select logic is inverted from spi_set_cs */
 	if (!enable)
@@ -606,6 +613,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	master->setup = orion_spi_setup;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
 	master->auto_runtime_pm = true;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	platform_set_drvdata(pdev, master);
 
-- 
2.11.0.24.ge6920cf
