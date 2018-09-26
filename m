From: Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 4/9] mtd: spi: Modify the HW capability mask according to supported RX lanes
Date: Thu, 27 Sep 2018 00:07:34 +0200
Message-ID: <20180926220739.620-5-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It may happen that we got two identical SPI devices connected to the QSPI
controller with asymmetrical number of RX lanes. Due to PCB constraints,
one can work as DUAL and second as QUAD.

For such scenario we do need support for setting different read commands.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index ad951a46a628..4f0c78ba6fcb 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -977,7 +977,7 @@ static void fsl_qspi_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
 
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
+	struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ_1_1_4 |
 			SNOR_HWCAPS_PP,
 	};
@@ -987,7 +987,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct spi_nor *nor;
 	struct mtd_info *mtd;
-	int ret, i = 0;
+	int ret, i = 0, width;
 
 	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
 	if (!q)
@@ -1104,6 +1104,14 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto mutex_failed;
 
+		if (!of_property_read_u32(np, "spi-rx-bus-width", &width)) {
+			if (width == 2) {
+				hwcaps.mask &= ~SNOR_HWCAPS_READ_QUAD;
+				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
+			} else if (width != 4)
+				return -EINVAL;
+		}
+
 		/* set the chip address for READID */
 		fsl_qspi_set_base_addr(q, nor);
 
-- 
2.11.0
