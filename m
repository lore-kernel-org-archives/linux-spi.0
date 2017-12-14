From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Implement cs-gpios configuration" to the spi tree
Date: Thu, 14 Dec 2017 11:49:54 +0000
Message-ID: <E1ePS1S-0005VK-Gz@debutante>
References: <1513191913-10612-4-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513191913-10612-4-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Implement cs-gpios configuration

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

>From b8761434bdec32fa46a644c26a12d16a9b0f58d8 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Dec 2017 20:05:12 +0100
Subject: [PATCH] spi: sh-msiof: Implement cs-gpios configuration

The current support for GPIO chip selects assumes the GPIOs have been
configured by platform code or the boot loader.  This includes pinmux
setup and GPIO direction.  Hence it does not work as expected when just
described in DT using the "cs-gpios" property.

Fix this by:
  1. using devm_gpiod_get_index() to request the GPIO, and thus
     configure pinmux, if needed,
  2. configuring the GPIO direction is the spi_master.setup() callback.

Use gpio_is_valid() instead of a check on positive numbers.

Note that when using GPIO chip selects, at least one native chip select
must be left unused, as that native chip select will be driven anyway,
and (global) native chip select polarity must be taken into account.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 66 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9bdc292aa050..8aa5c7b910d9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -19,6 +19,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -55,6 +56,7 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	unsigned short unused_ss;
 	bool native_cs_inited;
 	bool native_cs_high;
 	bool slave_aborted;
@@ -547,8 +549,8 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi->cs_gpio = (uintptr_t)spi->controller_data;
 	}
 
-	if (spi->cs_gpio >= 0) {
-		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+	if (gpio_is_valid(spi->cs_gpio)) {
+		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 		return 0;
 	}
 
@@ -580,14 +582,20 @@ static int sh_msiof_prepare_message(struct spi_master *master,
 {
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(master);
 	const struct spi_device *spi = msg->spi;
+	u32 ss, cs_high;
 
 	/* Configure pins before asserting CS */
-	sh_msiof_spi_set_pin_regs(p, spi->chip_select,
-				  !!(spi->mode & SPI_CPOL),
+	if (gpio_is_valid(spi->cs_gpio)) {
+		ss = p->unused_ss;
+		cs_high = p->native_cs_high;
+	} else {
+		ss = spi->chip_select;
+		cs_high = !!(spi->mode & SPI_CS_HIGH);
+	}
+	sh_msiof_spi_set_pin_regs(p, ss, !!(spi->mode & SPI_CPOL),
 				  !!(spi->mode & SPI_CPHA),
 				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
+				  !!(spi->mode & SPI_LSB_FIRST), cs_high);
 	return 0;
 }
 
@@ -1091,6 +1099,45 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 }
 #endif
 
+static int sh_msiof_get_cs_gpios(struct sh_msiof_spi_priv *p)
+{
+	struct device *dev = &p->pdev->dev;
+	unsigned int used_ss_mask = 0;
+	unsigned int cs_gpios = 0;
+	unsigned int num_cs, i;
+	int ret;
+
+	ret = gpiod_count(dev, "cs");
+	if (ret <= 0)
+		return 0;
+
+	num_cs = max_t(unsigned int, ret, p->master->num_chipselect);
+	for (i = 0; i < num_cs; i++) {
+		struct gpio_desc *gpiod;
+
+		gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
+		if (!IS_ERR(gpiod)) {
+			cs_gpios++;
+			continue;
+		}
+
+		if (PTR_ERR(gpiod) != -ENOENT)
+			return PTR_ERR(gpiod);
+
+		if (i >= MAX_SS) {
+			dev_err(dev, "Invalid native chip select %d\n", i);
+			return -EINVAL;
+		}
+		used_ss_mask |= BIT(i);
+	}
+	p->unused_ss = ffz(used_ss_mask);
+	if (cs_gpios && p->unused_ss >= MAX_SS) {
+		dev_err(dev, "No unused native chip select available\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	enum dma_transfer_direction dir, unsigned int id, dma_addr_t port_addr)
 {
@@ -1304,13 +1351,18 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (p->info->rx_fifo_override)
 		p->rx_fifo_size = p->info->rx_fifo_override;
 
+	/* Setup GPIO chip selects */
+	master->num_chipselect = p->info->num_chipselect;
+	ret = sh_msiof_get_cs_gpios(p);
+	if (ret)
+		goto err1;
+
 	/* init master code */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
 	master->flags = chipdata->master_flags;
 	master->bus_num = pdev->id;
 	master->dev.of_node = pdev->dev.of_node;
-	master->num_chipselect = p->info->num_chipselect;
 	master->setup = sh_msiof_spi_setup;
 	master->prepare_message = sh_msiof_prepare_message;
 	master->slave_abort = sh_msiof_slave_abort;
-- 
2.15.1
