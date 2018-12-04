From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: Add cs-gpio support
Date: Tue, 4 Dec 2018 06:24:59 +0000
Message-ID: <20181204062313.28942-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
fsl_lpspi_unprepare_message() to enable and control cs line.
These two functions will be only called at the beginning and the ending
of a message transfer.

Still support using the mode without cs-gpio. It depends on if attribute
cs-gpio has been configured in dts file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a7d01b79827b..c6fe3f94de19 100644
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
@@ -104,6 +111,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[0];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -176,6 +185,48 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
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
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+						struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+	struct spi_device *spi =3D msg->spi;
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	if (gpio_is_valid(gpio)) {
+		gpio_direction_output(gpio,
+				fsl_lpspi->config.mode & SPI_CS_HIGH ? 0 : 1);
+	}
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_ACTIVE);
+
+	return 0;
+}
+
+static int fsl_lpspi_unprepare_message(struct spi_controller *controller,
+						struct spi_message *msg)
+{
+	struct spi_device *spi =3D msg->spi;
+
+	fsl_lpspi_chipselect(spi, LPSPI_CS_INACTIVE);
+
+	return 0;
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -512,10 +563,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
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
@@ -539,6 +593,29 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
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
+		}
+
+		controller->prepare_message =3D fsl_lpspi_prepare_message;
+		controller->unprepare_message =3D fsl_lpspi_unprepare_message;
+	}
+
 	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
--=20
2.17.1
