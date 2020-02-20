From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: fsl-lpspi: remove unneeded array
Date: Thu, 20 Feb 2020 14:11:48 +0000
Message-ID: <20200220141143.3902922-2-oleksandr.suvorov@toradex.com>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Igor Opanyuk <igor.opanyuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

- replace the array with the shift operation
- remove the extra comparing operation.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---

 drivers/spi/spi-fsl-lpspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d0b8cc741a24..298329b781d2 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -86,8 +86,6 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
=20
-static int clkdivs[] =3D {1, 2, 4, 8, 16, 32, 64, 128};
-
 struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
@@ -331,15 +329,14 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_dat=
a *fsl_lpspi)
 	}
=20
 	for (prescale =3D 0; prescale < 8; prescale++) {
-		scldiv =3D perclk_rate /
-			 (clkdivs[prescale] * config.speed_hz) - 2;
+		scldiv =3D perclk_rate / config.speed_hz / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale =3D prescale;
 			break;
 		}
 	}
=20
-	if (prescale =3D=3D 8 && scldiv >=3D 256)
+	if (scldiv >=3D 256)
 		return -EINVAL;
=20
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
--=20
2.24.1
