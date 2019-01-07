From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 7/8] spi: lpspi: Add cs-gpio support
Date: Mon, 7 Jan 2019 07:47:47 +0000
Message-ID: <20190107074639.6336-8-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add cs-gpio feature for LPSPI.
The cs line will be controlled in fsl_lpspi_transfe_one_msg() function.

Still support using the mode without cs-gpio. It depends on if attribute
cs-gpio has been configured in dts file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 89 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 69635cde0e22..83e15366b739 100644
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
@@ -16,7 +17,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/spi-imx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -28,6 +31,10 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+#define LPSPI_CS_ACTIVE		1
+#define LPSPI_CS_INACTIVE	0
+#define LPSPI_CS_DELAY		100
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -91,6 +98,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool hascsgpio;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -106,6 +114,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[4];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -178,6 +188,20 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static void fsl_lpspi_chipselect(struct spi_device *spi, bool enable)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	enable =3D (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable);
+
+	if (!gpio_is_valid(gpio))
+		return;
+
+	gpio_set_value_cansleep(gpio, enable);
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -422,6 +446,25 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	return 0;
 }
=20
+static int fsl_lpspi_setup(struct spi_device *spi)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n", __func__,
+		 spi->mode, spi->bits_per_word, spi->max_speed_hz);
+
+	if (gpio_is_valid(gpio)) {
+		gpio_direction_output(gpio,
+				fsl_lpspi->config.mode & SPI_CS_HIGH ? 0 : 1);
+	}
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
@@ -430,8 +473,12 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
+	bool keep_cs =3D false;
 	int ret =3D 0;
=20
+	if (fsl_lpspi->hascsgpio)
+		fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+
 	msg->status =3D 0;
 	msg->actual_length =3D 0;
=20
@@ -448,10 +495,24 @@ static int fsl_lpspi_transfer_one_msg(struct spi_cont=
roller *controller,
 		if (ret < 0)
 			goto complete;
=20
+		if (fsl_lpspi->hascsgpio && xfer->cs_change) {
+			if (list_is_last(&xfer->transfer_list,
+					 &msg->transfers)) {
+				keep_cs =3D true;
+			} else {
+				fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+				udelay(10);
+				fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+			}
+		}
+
 		msg->actual_length +=3D xfer->len;
 	}
=20
 complete:
+	if (fsl_lpspi->hascsgpio && !keep_cs)
+		fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
 	msg->status =3D ret;
 	spi_finalize_current_message(controller);
=20
@@ -531,10 +592,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
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
@@ -558,6 +622,29 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
+	fsl_lpspi->hascsgpio =3D false;
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
+					fsl_lpspi->chipselect[i], DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+			controller->setup =3D fsl_lpspi_setup;
+			fsl_lpspi->hascsgpio =3D true;
+		}
+	}
+
 	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
--=20
2.17.1
