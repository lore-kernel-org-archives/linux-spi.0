From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH 2/4] spi: spi-fsl-spi: relax message sanity checking a
 little
Date: Wed, 27 Mar 2019 14:30:51 +0000
Message-ID: <20190327143040.16013-3-rasmus.villemoes@prevas.dk>
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

The comment says that we should not allow changes (to
bits_per_word/speed_hz) while CS is active, and indeed the code below
does fsl_spi_setup_transfer() when the ->cs_change of the previous
spi_transfer was set (and for the very first transfer).

So the sanity checking is a bit too strict - we can change it to
follow the same logic as is used by the actual transfer loop.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 6d114daa178a..481b075689b5 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -370,13 +370,15 @@ static int fsl_spi_do_one_msg(struct spi_master *mast=
er,
 	int status;
=20
 	/* Don't allow changes if CS is active */
-	first =3D list_first_entry(&m->transfers, struct spi_transfer,
-			transfer_list);
+	cs_change =3D 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (cs_change)
+			first =3D t;
+		cs_change =3D t->cs_change;
 		if ((first->bits_per_word !=3D t->bits_per_word) ||
 			(first->speed_hz !=3D t->speed_hz)) {
 			dev_err(&spi->dev,
-				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+				"bits_per_word/speed_hz cannot change while CS is active\n");
 			return -EINVAL;
 		}
 	}
--=20
2.20.1
