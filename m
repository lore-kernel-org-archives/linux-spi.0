From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: orion: Handle GPIO chip-selects" to the spi tree
Date: Wed, 24 May 2017 18:03:09 +0100
Message-ID: <E1dDZgj-00005U-BT@debutante>
References: <20170523004531.17538-1-chris.packham@alliedtelesis.co.nz>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523004531.17538-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: orion: Handle GPIO chip-selects

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

>From b28b9149b37f909a05f1e06e5a8b262a519dbd2b Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Tue, 23 May 2017 16:03:21 +1200
Subject: [PATCH] spi: orion: Handle GPIO chip-selects

Some hardware designs use GPIOs to add (or supplement) the SPI
chip-select so that more than one SPI slave device can be used.

For this to work with the spi-orion driver the SPI_MASTER_GPIO_SS flag
needs to be set (because the other outputs are gated internally by the
CS) and the correct chip-select (in this case CS0) needs to be driven by
the controller.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
