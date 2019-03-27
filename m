From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [RFC PATCH 4/4] spi: spi-fsl-spi: automatically adapt bits-per-word
 in cpu mode
Date: Wed, 27 Mar 2019 14:30:52 +0000
Message-ID: <20190327143040.16013-5-rasmus.villemoes@prevas.dk>
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

Taking one interrupt for every byte is rather slow. Since the
controller is perfectly capable of transmitting 32 bits at a time,
change t->bits_per-word to 32 when the length is divisible by 4 and
large enough that the reduced number of interrupts easily compensates
for the one or two extra fsl_spi_setup_transfer() calls this causes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/spi/spi-fsl-spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e2b341943796..b36ac6aa3b1f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -363,12 +363,28 @@ static int fsl_spi_bufs(struct spi_device *spi, struc=
t spi_transfer *t,
 static int fsl_spi_do_one_msg(struct spi_master *master,
 			      struct spi_message *m)
 {
+	struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata(master);
 	struct spi_device *spi =3D m->spi;
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs =3D 50;
 	int status, last_bpw;
=20
+	/*
+	 * In CPU mode, optimize large byte transfers to use larger
+	 * bits_per_word values to reduce number of interrupts taken.
+	 */
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->len < 256 || t->bits_per_word !=3D 8)
+				continue;
+			if ((t->len & 3) =3D=3D 0)
+				t->bits_per_word =3D 32;
+			else if ((t->len & 1) =3D=3D 0)
+				t->bits_per_word =3D 16;
+		}
+	}
+
 	/* Don't allow changes if CS is active */
 	cs_change =3D 1;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
--=20
2.20.1
