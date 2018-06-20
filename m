From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH 06/12] spi: spi-fsl-dspi: Fixup regmap configuration
Date: Wed, 20 Jun 2018 09:34:36 +0200
Message-ID: <20180620073442.20913-7-esben.haabendal@gmail.com>
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

Mark volatile registers to avoid caching bugs.

Note: SPI_MCR is marked volatile because of CLR_TXF and CLR_RXF bits.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index df07dd4722fb..5c5905b6509f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -862,11 +862,23 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_volatile_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_TCR),
+	regmap_reg_range(SPI_SR, SPI_SR),
+	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+};
+
+static const struct regmap_access_table dspi_volatile_table = {
+	.yes_ranges     = dspi_volatile_ranges,
+	.n_yes_ranges   = ARRAY_SIZE(dspi_volatile_ranges),
+};
+
 static const struct regmap_config dspi_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = 0x88,
+	.volatile_table = &dspi_volatile_table,
 };
 
 static void dspi_init(struct fsl_dspi *dspi)
-- 
2.17.1
