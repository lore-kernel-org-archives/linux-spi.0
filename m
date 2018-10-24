From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Date: Wed, 24 Oct 2018 02:50:27 +0000
Message-ID: <20181024024808.14485-3-xiaoning.wang@nxp.com>
References: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 58397acbce2f..a4ad3e881a5e 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -82,7 +82,8 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	bool is_slave;
=20
 	void *rx_buf;
@@ -149,8 +150,19 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		return ret;
+	}
=20
-	return clk_prepare_enable(fsl_lpspi->clk);
+	return 0;
 }
=20
 static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
@@ -158,7 +170,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
=20
 	return 0;
 }
@@ -242,7 +255,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	unsigned int perclk_rate, scldiv;
 	u8 prescale;
=20
-	perclk_rate =3D clk_get_rate(fsl_lpspi->clk);
+	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -508,15 +521,30 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fsl_lpspi->clk)) {
-		ret =3D PTR_ERR(fsl_lpspi->clk);
+	fsl_lpspi->clk_per =3D devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fsl_lpspi->clk_per)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_per);
+		goto out_controller_put;
+	}
+
+	fsl_lpspi->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk_ipg)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
+	}
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk);
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
+		dev_err(&pdev->dev,
+			"can't enable lpspi per clock, ret=3D%d\n", ret);
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
 		goto out_controller_put;
 	}
=20
@@ -524,7 +552,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -546,7 +575,8 @@ static int fsl_lpspi_remove(struct platform_device *pde=
v)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	return 0;
 }
--=20
2.17.1
