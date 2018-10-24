From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 5/5] spi: lpspi: CLK pin becomes low when CR_RST=1
Date: Wed, 24 Oct 2018 07:58:32 +0000
Message-ID: <20181024075617.19548-5-xiaoning.wang@nxp.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024075617.19548-1-xiaoning.wang@nxp.com>
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
V2:
 - Wrong place to remove fsl_lpspi_txfifo_empty() code when I split patch
   from my work git tree Although the final code which after applying all
   these five patches is correct.
---
 drivers/spi/spi-fsl-lpspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1be29daa9f92..3a7fe1c83aaa 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -282,10 +282,6 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl=
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
@@ -376,6 +372,21 @@ static int fsl_lpspi_wait_for_completion(struct spi_co=
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
@@ -397,6 +408,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller=
 *controller,
 	if (ret)
 		return ret;
=20
+	fsl_lpspi_reset(fsl_lpspi);
+
 	return 0;
 }
=20
--=20
2.17.1
