From: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: [PATCH] spi: sifive: check return value for platform_get_resource()
Date: Tue, 17 Sep 2019 09:12:38 +0000
Message-ID: <20190917085627.4562-1-mail@aurabindo.in>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: broonie@kernel.org, palmer@sifive.com, paul.walmsley@sifive.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

platform_get_resource() may return NULL. If it is so, return -ENXIO

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 drivers/spi/spi-sifive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..67485067a694 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pd=
ev)
 =09platform_set_drvdata(pdev, master);
=20
 =09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (!res) {
+=09=09dev_err(&pdev->dev, "no IOMEM resource found\n");
+=09=09ret =3D -ENXIO;
+=09=09goto put_master;
+=09}
+
 =09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
 =09if (IS_ERR(spi->regs)) {
 =09=09ret =3D PTR_ERR(spi->regs);
--=20
2.23.0
