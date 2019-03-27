From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH 1/4] spi: spi-fsl-spi: remove always-true conditional in
 fsl_spi_do_one_msg
Date: Wed, 27 Mar 2019 14:30:50 +0000
Message-ID: <20190327143040.16013-2-rasmus.villemoes@prevas.dk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To: Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

__spi_validate() in the generic SPI code sets ->speed_hz and
->bits_per_word to non-zero values, so this condition is always true.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
This of course relies on no spi_message reaching
->transfer_one_message without having been through __spi_validate. I
believe that's ok.

 drivers/spi/spi-fsl-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3d7b50c65f36..6d114daa178a 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -384,12 +384,10 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 	cs_change =3D 1;
 	status =3D -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			if (cs_change)
-				status =3D fsl_spi_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-		}
+		if (cs_change)
+			status =3D fsl_spi_setup_transfer(spi, t);
+		if (status < 0)
+			break;
=20
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
--=20
2.20.1
