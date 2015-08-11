From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: [PATCH 2/2] staging/fbtft: use spi_setup instead of direct call to master->setup
Date: Tue, 11 Aug 2015 09:27:51 +0200
Message-ID: <60ffd904-655b-404a-8c6c-5fb52f51566c@HUB2.rwth-ad.de>
References: <1439278071-21110-1-git-send-email-stefan.bruens@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439278071-21110-1-git-send-email-stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Avoid a crash, as master->setup may be NULL (e.g. xilinx controller).
Even if master->setup is set, spi_setup does several compatibility/
sanity checks which should not be skipped (fixes problems with
displays/controllers needing emulation for bits_per_word =3D 9).

Signed-off-by: Stefan Br=C3=BCns <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
---
 drivers/staging/fbtft/fb_watterott.c | 4 ++--
 drivers/staging/fbtft/fbtft-core.c   | 4 ++--
 drivers/staging/fbtft/flexfb.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbt=
ft/fb_watterott.c
index 88fb2c0..8eae6ef 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -169,7 +169,7 @@ static int init_display(struct fbtft_par *par)
 	/* enable SPI interface by having CS and MOSI low during reset */
 	save_mode =3D par->spi->mode;
 	par->spi->mode |=3D SPI_CS_HIGH;
-	ret =3D par->spi->master->setup(par->spi); /* set CS inactive low */
+	ret =3D spi_setup(par->spi); /* set CS inactive low */
 	if (ret) {
 		dev_err(par->info->device, "Could not set SPI_CS_HIGH\n");
 		return ret;
@@ -180,7 +180,7 @@ static int init_display(struct fbtft_par *par)
 	par->fbtftops.reset(par);
 	mdelay(1000);
 	par->spi->mode =3D save_mode;
-	ret =3D par->spi->master->setup(par->spi);
+	ret =3D spi_setup(par->spi);
 	if (ret) {
 		dev_err(par->info->device, "Could not restore SPI mode\n");
 		return ret;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft=
/fbtft-core.c
index 9cc8141..ba08da3 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1434,12 +1434,12 @@ int fbtft_probe_common(struct fbtft_display *di=
splay,
 	/* 9-bit SPI setup */
 	if (par->spi && display->buswidth =3D=3D 9) {
 		par->spi->bits_per_word =3D 9;
-		ret =3D par->spi->master->setup(par->spi);
+		ret =3D spi_setup(par->spi);
 		if (ret) {
 			dev_warn(&par->spi->dev,
 				"9-bit SPI not available, emulating using 8-bit.\n");
 			par->spi->bits_per_word =3D 8;
-			ret =3D par->spi->master->setup(par->spi);
+			ret =3D spi_setup(par->spi);
 			if (ret)
 				goto out_release;
 			/* allocate buffer with room for dc bits */
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/fle=
xfb.c
index 2c4ce07..fecf486 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -440,12 +440,12 @@ static int flexfb_probe_common(struct spi_device =
*sdev,
 			par->fbtftops.write_register =3D fbtft_write_reg8_bus9;
 			par->fbtftops.write_vmem =3D fbtft_write_vmem16_bus9;
 			sdev->bits_per_word =3D 9;
-			ret =3D sdev->master->setup(sdev);
+			ret =3D spi_setup(sdev);
 			if (ret) {
 				dev_warn(dev,
 					"9-bit SPI not available, emulating using 8-bit.\n");
 				sdev->bits_per_word =3D 8;
-				ret =3D sdev->master->setup(sdev);
+				ret =3D spi_setup(sdev);
 				if (ret)
 					goto out_release;
 				/* allocate buffer with room for dc bits */
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
