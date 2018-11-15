From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning
Date: Thu, 15 Nov 2018 11:32:09 +0100
Message-ID: <20181115103209.20619-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

A careless oversight. Sorry.

Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
Changes since v1:
- Applied Robert Jarzmik's wise suggestion to remove useless
  conditionals and thus reduce this into a single line.

 drivers/spi/spi-pxa2xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 29e6025f104c..4f55c9647289 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1555,19 +1555,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pde=
v)
 	}
 #endif
=20
-#if CONFIG_OF
-	if (of_id) {
-		pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node,
-								"spi-slave");
-	}
-#endif
-
 	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
 	ssp->irq =3D platform_get_irq(pdev, 0);
 	ssp->type =3D type;
 	ssp->pdev =3D pdev;
 	ssp->port_id =3D pxa2xx_spi_get_port_id(adev);
=20
+	pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node, "spi-slave=
");
 	pdata->num_chipselect =3D 1;
 	pdata->enable_dma =3D true;
=20
--=20
2.19.1
