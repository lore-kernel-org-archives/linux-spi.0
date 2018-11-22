From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v4 5/7] mtd: m25p80: add support of octo mode I/O transfer
Date: Thu, 22 Nov 2018 05:14:54 +0000
Message-ID: <1542863544-21257-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for octo mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octo transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..6f3c280 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -195,7 +195,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem =3D spimem;
=20
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTO) {
+		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTO)
+			hwcaps.mask |=3D (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
=20
 		if (spi->mode & SPI_TX_QUAD)
--=20
2.7.4
