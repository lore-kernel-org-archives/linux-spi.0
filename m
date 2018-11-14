From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning
Date: Wed, 14 Nov 2018 18:31:07 +0100
Message-ID: <20181114173107.1229717-1-lkundrak@v3.sk>
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
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 29e6025f104c..7194070e4009 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1555,7 +1555,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	}
 #endif
=20
-#if CONFIG_OF
+#ifdef CONFIG_OF
 	if (of_id) {
 		pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node,
 								"spi-slave");
--=20
2.19.1
