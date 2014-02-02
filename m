From: =?UTF-8?q?Stefan=20S=C3=B8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Do not configure the controller on each transfer unless needed
Date: Sun,  2 Feb 2014 16:24:12 +0100
Message-ID: <1391354652-32092-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_transfer->speed_hz and spi_transfer->bits_per_word used to only be =
set when
not using the default settings but are not set on every transfer, causi=
ng
omap2_mcspi_setup_transfer to be called on each transfer. This patch ch=
anges
the check to only call omap2_mcspi_setup_transfer if the settings needs=
 to be
changed.

Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcsp=
i.c
index a72127f..965539b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1057,12 +1057,15 @@ static void omap2_mcspi_work(struct omap2_mcspi=
 *mcspi, struct spi_message *m)
 			status =3D -EINVAL;
 			break;
 		}
-		if (par_override || t->speed_hz || t->bits_per_word) {
+		if (par_override ||
+		    (t->speed_hz !=3D spi->max_speed_hz) ||
+		    (t->bits_per_word !=3D spi->bits_per_word)) {
 			par_override =3D 1;
 			status =3D omap2_mcspi_setup_transfer(spi, t);
 			if (status < 0)
 				break;
-			if (!t->speed_hz && !t->bits_per_word)
+			if (t->speed_hz =3D=3D spi->max_speed_hz &&
+			    t->bits_per_word =3D=3D spi->bits_per_word)
 				par_override =3D 0;
 		}
 		if (cd && cd->cs_per_word) {
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
