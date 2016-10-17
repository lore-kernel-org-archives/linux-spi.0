From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH] spi: dspi: clear SPI_SR before enable interrupt
Date: Mon, 17 Oct 2016 18:02:34 +0800
Message-ID: <1476698554-12150-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <yao.yuan@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Yuan Yao <yao.yuan@nxp.com>

Once dspi is used in uboot, the SPI_SR have been set by some value.
At this time, if kernel enable the interrupt before clear the
status flag, that will trigger the wrong interrupt.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 35c0dd9..a67b0ff 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -70,6 +70,7 @@
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
+#define SPI_SR_CLEAR		0xdaad0000
 
 #define SPI_RSER		0x30
 #define SPI_RSER_EOQFE		0x10000000
@@ -646,6 +647,11 @@ static const struct regmap_config dspi_regmap_config = {
 	.max_register = 0x88,
 };
 
+static void dspi_init(struct fsl_dspi *dspi)
+{
+	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+}
+
 static int dspi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -709,6 +715,7 @@ static int dspi_probe(struct platform_device *pdev)
 		return PTR_ERR(dspi->regmap);
 	}
 
+	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
 		dev_err(&pdev->dev, "can't get platform irq\n");
-- 
2.1.0.27.g96db324
