From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 3/4] spi: lpspi: Let watermark change with send data length
Date: Fri, 30 Nov 2018 04:29:09 +0000
Message-ID: <20181130042753.28756-4-xiaoning.wang@nxp.com>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Configure watermark to change with the length of the sent data.
Support LPSPI sending message shorter than tx/rxfifosize.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Change log:
V2:
 - No change.
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index cbf165e7bd17..08dcc3c22e88 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -89,6 +89,7 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *);
=20
 	u32 remain;
+	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
=20
@@ -235,7 +236,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_da=
ta *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
+	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -261,7 +262,8 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	if (prescale =3D=3D 8 && scldiv >=3D 256)
 		return -EINVAL;
=20
-	writel(scldiv, fsl_lpspi->base + IMX7ULP_CCR);
+	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
+					fsl_lpspi->base + IMX7ULP_CCR);
=20
 	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
@@ -329,6 +331,11 @@ static void fsl_lpspi_setup_transfer(struct spi_device=
 *spi,
 		fsl_lpspi->tx =3D fsl_lpspi_buf_tx_u32;
 	}
=20
+	if (t->len <=3D fsl_lpspi->txfifosize)
+		fsl_lpspi->watermark =3D t->len;
+	else
+		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
+
 	fsl_lpspi_config(fsl_lpspi);
 }
=20
--=20
2.17.1
