From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 5/8] spi: lpspi: use the core way to implement cs-gpio
 function
Date: Wed, 6 Mar 2019 06:30:43 +0000
Message-ID: <20190306063020.793-6-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the default implementation of transfer_one_msg/chipselect/setup
functions in spi core to implement cs-gpio control.
Use fsl_lpspi_prepare_message to init the cs_gpio pin.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
---
V2:
 - use core way to implement cs-gpio control. Removed the redundant code
   in the driver.
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
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -106,6 +110,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[0];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -178,6 +184,20 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+				     struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+					spi_controller_get_devdata(controller);
+	struct spi_device *spi =3D msg->spi;
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
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
@@ -210,8 +230,7 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_dat=
a *fsl_lpspi)
 		fsl_lpspi->rx(fsl_lpspi);
 }
=20
-static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
-			      bool is_first_xfer)
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp =3D 0;
=20
@@ -227,7 +246,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fs=
l_lpspi,
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
 		temp |=3D TCR_CONT;
-		if (is_first_xfer)
+		if (fsl_lpspi->is_first_byte)
 			temp &=3D ~TCR_CONTC;
 		else
 			temp |=3D TCR_CONTC;
@@ -396,8 +415,7 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_l=
pspi)
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one(struct spi_controller *controller,
-				  struct spi_device *spi,
+static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -422,40 +440,27 @@ static int fsl_lpspi_transfer_one(struct spi_controll=
er *controller,
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
-				      struct spi_message *msg)
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
+				  struct spi_device *spi,
+				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
-				spi_controller_get_devdata(controller);
-	struct spi_device *spi =3D msg->spi;
-	struct spi_transfer *xfer;
-	bool is_first_xfer =3D true;
-	int ret =3D 0;
-
-	msg->status =3D 0;
-	msg->actual_length =3D 0;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
-		if (ret < 0)
-			goto complete;
-
-		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
-
-		is_first_xfer =3D false;
+					spi_controller_get_devdata(controller);
+	int ret;
=20
-		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
-		if (ret < 0)
-			goto complete;
+	fsl_lpspi->is_first_byte =3D true;
+	ret =3D fsl_lpspi_setup_transfer(spi, t);
+	if (ret < 0)
+		return ret;
=20
-		msg->actual_length +=3D xfer->len;
-	}
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi->is_first_byte =3D false;
=20
-complete:
-	msg->status =3D ret;
-	spi_finalize_current_message(controller);
+	ret =3D fsl_lpspi_pio_transfer(controller, t);
+	if (ret < 0)
+		return ret;
=20
-	return ret;
+	return 0;
 }
=20
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
@@ -531,10 +536,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
fsl_lpspi)
=20
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	struct device_node *np =3D pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
+	struct spi_imx_master *lpspi_platform_info =3D
+		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int ret, irq;
+	int i, ret, irq;
 	u32 temp;
=20
 	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
@@ -558,7 +566,30 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
-	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
+	if (!fsl_lpspi->is_slave) {
+		for (i =3D 0; i < controller->num_chipselect; i++) {
+			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
+
+			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
+				cs_gpio =3D lpspi_platform_info->chipselect[i];
+
+			fsl_lpspi->chipselect[i] =3D cs_gpio;
+			if (!gpio_is_valid(cs_gpio))
+				continue;
+
+			ret =3D devm_gpio_request(&pdev->dev,
+						fsl_lpspi->chipselect[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+		}
+		controller->cs_gpios =3D fsl_lpspi->chipselect;
+		controller->prepare_message =3D fsl_lpspi_prepare_message;
+	}
+
+	controller->transfer_one =3D fsl_lpspi_transfer_one;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
 	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
--=20
2.17.1
