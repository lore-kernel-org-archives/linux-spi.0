From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Date: Wed, 24 Oct 2018 02:50:32 +0000
Message-ID: <20181024024808.14485-5-xiaoning.wang@nxp.com>
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

Remove Reset operation in fsl_lpspi_config(). This RST may cause both CLK
and CS pins go from high to low level under cs-gpio mode.
Add fsl_lpspi_reset() function after one message transfer to clear all
flags in use.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a8a6699e2741..844b713553d1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -281,10 +281,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
_lpspi)
 	u32 temp;
 	int ret;
=20
-	temp =3D CR_RST;
-	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
-	writel(0, fsl_lpspi->base + IMX7ULP_CR);
-
 	if (!fsl_lpspi->is_slave) {
 		ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
 		if (ret)
@@ -375,6 +371,21 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u32 temp;
+
+	/* W1C for all flags in SR */
+	temp =3D 0x3F << 8;
+	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
+
+	/* Clear FIFO and disable module */
+	temp =3D CR_RRF | CR_RTF;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -396,9 +407,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
-	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
-	if (ret)
-		return ret;
+	fsl_lpspi_reset(fsl_lpspi);
=20
 	return 0;
 }
--=20
2.17.1
