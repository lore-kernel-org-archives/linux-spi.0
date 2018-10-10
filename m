From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 03/11] spi: pxa2xx: Use an enum for type
Date: Wed, 10 Oct 2018 19:09:28 +0200
Message-ID: <20181010170936.316862-4-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

That seems to be the correct type.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c   | 6 +++---
 include/linux/pxa2xx_ssp.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..f674541675bb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1429,7 +1429,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id =3D NULL;
 	const struct pci_device_id *pcidev_id =3D NULL;
-	int type;
+	enum pxa_ssp_type type;
=20
 	adev =3D ACPI_COMPANION(&pdev->dev);
=20
@@ -1443,9 +1443,9 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return NULL;
=20
 	if (adev_id)
-		type =3D (int)adev_id->driver_data;
+		type =3D (enum pxa_ssp_type)adev_id->driver_data;
 	else if (pcidev_id)
-		type =3D (int)pcidev_id->driver_data;
+		type =3D (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
 		return NULL;
=20
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 13b4244d44c1..262e1f318836 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -217,7 +217,7 @@ struct ssp_device {
=20
 	const char	*label;
 	int		port_id;
-	int		type;
+	enum pxa_ssp_type type;
 	int		use_count;
 	int		irq;
=20
--=20
2.19.0
