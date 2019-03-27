From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH 3/4] spi: spi-fsl-spi: allow changing bits_per_word while
 CS is still active
Date: Wed, 27 Mar 2019 14:30:51 +0000
Message-ID: <20190327143040.16013-4-rasmus.villemoes@prevas.dk>
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

Commit c9bfcb315104 (spi_mpc83xx: much improved driver) introduced
logic to ensure bits_per_word and speed_hz stay the same for a series
of spi_transfers with CS active, arguing that

    The current driver may cause glitches on SPI CLK line since one
    must disable the SPI controller before changing any HW settings.

This sounds quite reasonable. So this is a quite naive attempt at
relaxing this sanity checking to only ensure that speed_hz is
constant - in the faint hope that if we do not causes changes to the
clock-related fields of the SPMODE register (DIV16 and PM), those
glitches won't appear.

The purpose of this change is to allow automatically optimizing large
transfers to use 32 bits-per-word; taking one interrupt for every byte
is extremely slow.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 481b075689b5..e2b341943796 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -367,7 +367,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master=
,
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs =3D 50;
-	int status;
+	int status, last_bpw;
=20
 	/* Don't allow changes if CS is active */
 	cs_change =3D 1;
@@ -375,21 +375,22 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 		if (cs_change)
 			first =3D t;
 		cs_change =3D t->cs_change;
-		if ((first->bits_per_word !=3D t->bits_per_word) ||
-			(first->speed_hz !=3D t->speed_hz)) {
+		if (first->speed_hz !=3D t->speed_hz) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz cannot change while CS is active\n");
+				"speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
=20
+	last_bpw =3D -1;
 	cs_change =3D 1;
 	status =3D -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (cs_change)
+		if (cs_change || last_bpw !=3D t->bits_per_word)
 			status =3D fsl_spi_setup_transfer(spi, t);
 		if (status < 0)
 			break;
+		last_bpw =3D t->bits_per_word;
=20
 		if (cs_change) {
 			fsl_spi_chipselect(spi, BITBANG_CS_ACTIVE);
--=20
2.20.1
