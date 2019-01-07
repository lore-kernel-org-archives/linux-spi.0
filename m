From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 6/8] spi: lpspi: add the error info of transfer speed setting
Date: Mon, 7 Jan 2019 07:47:45 +0000
Message-ID: <20190107074639.6336-7-xiaoning.wang@nxp.com>
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

Add a error info when set a speed which greater than half of per-clk of
spi module.

The minimum SCK period is 2 cycles(CCR[SCKDIV]). So the maximum transfer
speed is half of spi per-clk.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 84dcb9e176b8..69635cde0e22 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -255,6 +255,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	u8 prescale;
=20
 	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
+
+	if (config.speed_hz > perclk_rate / 2) {
+		dev_err(fsl_lpspi->dev,
+		      "per-clk should be at least two times of transfer speed");
+		return -EINVAL;
+	}
+
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -304,7 +311,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
lpspi)
 	return 0;
 }
=20
-static void fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -337,7 +344,7 @@ static void fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
-	fsl_lpspi_config(fsl_lpspi);
+	return fsl_lpspi_config(fsl_lpspi);
 }
=20
 static int fsl_lpspi_slave_abort(struct spi_controller *controller)
@@ -429,7 +436,10 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		fsl_lpspi_setup_transfer(spi, xfer);
+		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
+		if (ret < 0)
+			goto complete;
+
 		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
=20
 		is_first_xfer =3D false;
--=20
2.17.1
