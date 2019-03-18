From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: use the core way to implement cs-gpio function" to the spi tree
Date: Mon, 18 Mar 2019 14:52:12 +0000 (GMT)
Message-ID: <20190318145212.32ADB1128874@debutante.sirena.org.uk>
References: <20190306063020.793-6-xiaoning.wang@nxp.com>
Cc: Fugang Duan <Fugang.duan@nxp.com>, Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306063020.793-6-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: use the core way to implement cs-gpio function

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

>From c7a402599504384efe0e5232a4c78cb8eb7cb3d0 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Wed, 6 Mar 2019 06:30:43 +0000
Subject: [PATCH] spi: lpspi: use the core way to implement cs-gpio function

Use the default implementation of transfer_one_msg/chipselect/setup
functions in spi core to implement cs-gpio control.
Use fsl_lpspi_prepare_message to init the cs_gpio pin.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 101 +++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 69635cde0e22..a25e0e03f058 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -16,8 +17,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -91,6 +94,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool is_first_byte;
 
 	void *rx_buf;
 	const void *tx_buf;
@@ -106,6 +110,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
 
 	bool slave_aborted;
+
+	int chipselect[0];
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -178,6 +184,20 @@ static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 	return 0;
 }
 
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+				     struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =
+					spi_controller_get_devdata(controller);
+	struct spi_device *spi = msg->spi;
+	int gpio = fsl_lpspi->chipselect[spi->chip_select];
+
+	if (gpio_is_valid(gpio))
+		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
+
+	return 0;
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -210,8 +230,7 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi->rx(fsl_lpspi);
 }
 
-static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
-			      bool is_first_xfer)
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp = 0;
 
@@ -227,7 +246,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
 		temp |= TCR_CONT;
-		if (is_first_xfer)
+		if (fsl_lpspi->is_first_byte)
 			temp &= ~TCR_CONTC;
 		else
 			temp |= TCR_CONTC;
@@ -396,8 +415,7 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
-static int fsl_lpspi_transfer_one(struct spi_controller *controller,
-				  struct spi_device *spi,
+static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
@@ -422,40 +440,27 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 	return 0;
 }
 
-static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
-				      struct spi_message *msg)
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
+				  struct spi_device *spi,
+				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
-				spi_controller_get_devdata(controller);
-	struct spi_device *spi = msg->spi;
-	struct spi_transfer *xfer;
-	bool is_first_xfer = true;
-	int ret = 0;
-
-	msg->status = 0;
-	msg->actual_length = 0;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		ret = fsl_lpspi_setup_transfer(spi, xfer);
-		if (ret < 0)
-			goto complete;
-
-		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
-
-		is_first_xfer = false;
+					spi_controller_get_devdata(controller);
+	int ret;
 
-		ret = fsl_lpspi_transfer_one(controller, spi, xfer);
-		if (ret < 0)
-			goto complete;
+	fsl_lpspi->is_first_byte = true;
+	ret = fsl_lpspi_setup_transfer(spi, t);
+	if (ret < 0)
+		return ret;
 
-		msg->actual_length += xfer->len;
-	}
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi->is_first_byte = false;
 
-complete:
-	msg->status = ret;
-	spi_finalize_current_message(controller);
+	ret = fsl_lpspi_pio_transfer(controller, t);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
@@ -531,10 +536,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
+	struct spi_imx_master *lpspi_platform_info =
+		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int ret, irq;
+	int i, ret, irq;
 	u32 temp;
 
 	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
@@ -558,7 +566,30 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->is_slave = of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
 
-	controller->transfer_one_message = fsl_lpspi_transfer_one_msg;
+	if (!fsl_lpspi->is_slave) {
+		for (i = 0; i < controller->num_chipselect; i++) {
+			int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
+
+			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
+				cs_gpio = lpspi_platform_info->chipselect[i];
+
+			fsl_lpspi->chipselect[i] = cs_gpio;
+			if (!gpio_is_valid(cs_gpio))
+				continue;
+
+			ret = devm_gpio_request(&pdev->dev,
+						fsl_lpspi->chipselect[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+		}
+		controller->cs_gpios = fsl_lpspi->chipselect;
+		controller->prepare_message = fsl_lpspi_prepare_message;
+	}
+
+	controller->transfer_one = fsl_lpspi_transfer_one;
 	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-- 
2.20.1
