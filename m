From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 08/12] spi: spi-fsl-dspi: Add support for XSPI mode registers
Date: Wed, 20 Jun 2018 09:34:38 +0200
Message-ID: <20180620073442.20913-9-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This prepares for adding support for extended SPI mode (XSPI), by extending
the regmap with the extra SREX and CTAREx registers.

An additional register map is made for allowing 16 bit access to CMD and TX
FIFO of the PUSHR register separately, which is also needed for XSPI mode
support.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 63 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d83d3496d538..3e9dd645ee54 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -108,11 +108,21 @@
 #define SPI_RXFR2		0x84
 #define SPI_RXFR3		0x88
 
+#define SPI_CTARE(x)		(0x11c + (((x) & 0x3) * 4))
+#define SPI_CTARE_FMSZE(x)	(((x) & 0x1) << 16)
+#define SPI_CTARE_DTCP(x)	((x) & 0x7ff)
+
+#define SPI_SREX		0x13c
+
 #define SPI_FRAME_BITS(bits)	SPI_CTAR_FMSZ((bits) - 1)
 #define SPI_FRAME_BITS_MASK	SPI_CTAR_FMSZ(0xf)
 #define SPI_FRAME_BITS_16	SPI_CTAR_FMSZ(0xf)
 #define SPI_FRAME_BITS_8	SPI_CTAR_FMSZ(0x7)
 
+/* Register offsets for regmap_pushr */
+#define PUSHR_CMD		0x0
+#define PUSHR_TX		0x2
+
 #define SPI_CS_INIT		0x01
 #define SPI_CS_ASSERT		0x02
 #define SPI_CS_DROP		0x04
@@ -133,6 +143,7 @@ enum dspi_trans_mode {
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode trans_mode;
 	u8 max_clock_factor;
+	bool xspi_mode;
 };
 
 static const struct fsl_dspi_devtype_data vf610_data = {
@@ -143,6 +154,7 @@ static const struct fsl_dspi_devtype_data vf610_data = {
 static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
 	.trans_mode = DSPI_TCFQ_MODE,
 	.max_clock_factor = 8,
+	.xspi_mode = true,
 };
 
 static const struct fsl_dspi_devtype_data ls2085a_data = {
@@ -177,6 +189,7 @@ struct fsl_dspi {
 	struct platform_device	*pdev;
 
 	struct regmap		*regmap;
+	struct regmap		*regmap_pushr;
 	int			irq;
 	struct clk		*clk;
 
@@ -876,6 +889,35 @@ static const struct regmap_config dspi_regmap_config = {
 	.volatile_table = &dspi_volatile_table,
 };
 
+static const struct regmap_range dspi_xspi_volatile_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_TCR),
+	regmap_reg_range(SPI_SR, SPI_SR),
+	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_xspi_volatile_table = {
+	.yes_ranges     = dspi_xspi_volatile_ranges,
+	.n_yes_ranges   = ARRAY_SIZE(dspi_xspi_volatile_ranges),
+};
+
+static const struct regmap_config dspi_xspi_regmap_config[] = {
+	{
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = 0x13c,
+		.volatile_table = &dspi_xspi_volatile_table,
+	},
+	{
+		.name = "pushr",
+		.reg_bits = 16,
+		.val_bits = 16,
+		.reg_stride = 2,
+		.max_register = 0x2,
+	},
+};
+
 static void dspi_init(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
@@ -888,6 +930,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct fsl_dspi *dspi;
 	struct resource *res;
+	const struct regmap_config *regmap_config;
 	void __iomem *base;
 	struct fsl_dspi_platform_data *pdata;
 	int ret = 0, cs_num, bus_num;
@@ -946,8 +989,11 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	dspi->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
-						&dspi_regmap_config);
+	if (dspi->devtype_data->xspi_mode)
+		regmap_config = &dspi_xspi_regmap_config[0];
+	else
+		regmap_config = &dspi_regmap_config;
+	dspi->regmap = devm_regmap_init_mmio(&pdev->dev, base, regmap_config);
 	if (IS_ERR(dspi->regmap)) {
 		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
 				PTR_ERR(dspi->regmap));
@@ -955,6 +1001,19 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
+	if (dspi->devtype_data->xspi_mode) {
+		dspi->regmap_pushr = devm_regmap_init_mmio(
+			&pdev->dev, base + SPI_PUSHR,
+			&dspi_xspi_regmap_config[1]);
+		if (IS_ERR(dspi->regmap_pushr)) {
+			dev_err(&pdev->dev,
+				"failed to init pushr regmap: %ld\n",
+				PTR_ERR(dspi->regmap_pushr));
+			ret = PTR_ERR(dspi->regmap);
+			goto out_master_put;
+		}
+	}
+
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
-- 
2.17.1
