From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_slave_probe()
Date: Sat, 21 Sep 2019 15:19:27 +0200
Message-ID: <225b76ca-a367-4bef-d8ce-42c7af9242a5@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 15:12:33 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-slave-mt27xx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx=
.c
index 61bc43b0fe57..44edaa360405 100644
=2D-- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -368,7 +368,6 @@ static int mtk_spi_slave_probe(struct platform_device =
*pdev)
 {
 	struct spi_controller *ctlr;
 	struct mtk_spi_slave *mdata;
-	struct resource *res;
 	int irq, ret;

 	ctlr =3D spi_alloc_slave(&pdev->dev, sizeof(*mdata));
@@ -392,17 +391,8 @@ static int mtk_spi_slave_probe(struct platform_device=
 *pdev)
 	platform_set_drvdata(pdev, ctlr);

 	init_completion(&mdata->xfer_done);
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret =3D -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_ctlr;
-	}
-
 	mdata->dev =3D &pdev->dev;
-
-	mdata->base =3D devm_ioremap_resource(&pdev->dev, res);
+	mdata->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret =3D PTR_ERR(mdata->base);
 		goto err_put_ctlr;
=2D-
2.23.0
