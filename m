From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 7/8] spi: lpspi: Add the missing NULL check
Date: Wed, 6 Mar 2019 06:30:47 +0000
Message-ID: <20190306063020.793-8-xiaoning.wang@nxp.com>
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

The spi_transfer *t will be used in one transfer whatever. If t is NULL,
there has no need to try sending data, so add an error return here.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
---
V2:
 - add this patch in this version
---
 drivers/spi/spi-fsl-lpspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9ff32fb67a29..2ac3ac5ea50a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -438,9 +438,12 @@ static int fsl_lpspi_setup_transfer(struct spi_control=
ler *controller,
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(spi->controller);
=20
+	if (t =3D=3D NULL)
+		return -EINVAL;
+
 	fsl_lpspi->config.mode =3D spi->mode;
-	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
-	fsl_lpspi->config.speed_hz =3D t ? t->speed_hz : spi->max_speed_hz;
+	fsl_lpspi->config.bpw =3D t->bits_per_word;
+	fsl_lpspi->config.speed_hz =3D t->speed_hz;
 	fsl_lpspi->config.chip_select =3D spi->chip_select;
=20
 	if (!fsl_lpspi->config.speed_hz)
--=20
2.17.1
