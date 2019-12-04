From: Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH] spi: fsl-lpspi: fix only one cs-gpio working
Date: Wed, 4 Dec 2019 14:13:33 +0000
Message-ID: <20191204141312.1411251-1-philippe.schenker@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
To: Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Why it does not work at the moment:
- num_chipselect sets the number of cs-gpios that are in the DT.
  This comes from drivers/spi/spi.c
- num_chipselect gets set with devm_spi_register_controller, that is
  called in drivers/spi/spi.c
- devm_spi_register_controller got called after num_chipselect has
  been used.

How this commit fixes the issue:
- devm_spi_register_controller gets called before num_chipselect is
  being used.

Fixes: c7a402599504 ("spi: lpspi: use the core way to implement cs-gpio fun=
ction")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 drivers/spi/spi-fsl-lpspi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2cc0ddb4a988..1375bdfc587b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -862,6 +862,22 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->dev =3D &pdev->dev;
 	fsl_lpspi->is_slave =3D is_slave;
=20
+	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
+	controller->transfer_one =3D fsl_lpspi_transfer_one;
+	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node =3D pdev->dev.of_node;
+	controller->bus_num =3D pdev->id;
+	controller->slave_abort =3D fsl_lpspi_slave_abort;
+
+	ret =3D devm_spi_register_controller(&pdev->dev, controller);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
+	}
+
 	if (!fsl_lpspi->is_slave) {
 		for (i =3D 0; i < controller->num_chipselect; i++) {
 			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
@@ -885,16 +901,6 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 		controller->prepare_message =3D fsl_lpspi_prepare_message;
 	}
=20
-	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
-	controller->transfer_one =3D fsl_lpspi_transfer_one;
-	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
-	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
-	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	controller->dev.of_node =3D pdev->dev.of_node;
-	controller->bus_num =3D pdev->id;
-	controller->slave_abort =3D fsl_lpspi_slave_abort;
-
 	init_completion(&fsl_lpspi->xfer_done);
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -952,12 +958,6 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
=20
-	ret =3D devm_spi_register_controller(&pdev->dev, controller);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_controller error.\n");
-		goto out_controller_put;
-	}
-
 	return 0;
=20
 out_controller_put:
--=20
2.24.0
