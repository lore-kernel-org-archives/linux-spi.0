From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] spi/imx: prevent NULL pointer dereference in spi_imx_probe()
Date: Tue,  3 Apr 2012 15:03:44 +0200
Message-ID: <1333458224-7602-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Beisert <kernel@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	=?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When no platform_data is present and either 'spi-num-chipselects' is
not defined in the DT or 'cs-gpios' has less entries than
'spi-num-chipselects' specifies, the NULL platform_data pointer is
being dereferenced.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/spi/spi-imx.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 373f4ff..570f220 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -766,8 +766,12 @@ static int __devinit spi_imx_probe(struct platform=
_device *pdev)
 	}
=20
 	ret =3D of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
-	if (ret < 0)
-		num_cs =3D mxc_platform_info->num_chipselect;
+	if (ret < 0) {
+		if (mxc_platform_info)
+			num_cs =3D mxc_platform_info->num_chipselect;
+		else
+			return ret;
+	}
=20
 	master =3D spi_alloc_master(&pdev->dev,
 			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
@@ -784,7 +788,7 @@ static int __devinit spi_imx_probe(struct platform_=
device *pdev)
=20
 	for (i =3D 0; i < master->num_chipselect; i++) {
 		int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
-		if (cs_gpio < 0)
+		if (cs_gpio < 0 && mxc_platform_info)
 			cs_gpio =3D mxc_platform_info->chipselect[i];
=20
 		spi_imx->chipselect[i] =3D cs_gpio;
--=20
1.7.2.5
