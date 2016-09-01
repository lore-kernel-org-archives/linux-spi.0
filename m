From: Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] spi: imx: support loopback mode on imx35
Date: Thu, 1 Sep 2016 22:39:58 +0200
Message-ID: <20160901203957.GA7994@reykholt.kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

imx35 and compatible chipsets support loopback mode by setting a
loopback control bit in the test register. Make this setting available
for data transfers, similar to what we do for imx51.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/spi/spi-imx.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5cc72be..53e7a32 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -455,6 +455,9 @@ static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 #define MX31_CSPISTATUS		0x14
 #define MX31_STATUS_RR		(1 << 3)
 
+#define MX31_CSPI_TESTREG	0x1C
+#define MX31_TEST_LBC		(1 << 14)
+
 /* These functions also work for the i.MX35, but be aware that
  * the i.MX35 has a slightly different register layout for bits
  * we do not use here.
@@ -510,6 +513,13 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
+	reg = readl(spi_imx->base + MX31_CSPI_TESTREG);
+	if (spi->mode & SPI_LOOP)
+		reg |= MX31_TEST_LBC;
+	else
+		reg &= ~MX31_TEST_LBC;
+	writel(reg, spi_imx->base + MX31_CSPI_TESTREG);
+
 	return 0;
 }
 
@@ -1186,7 +1196,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	if (is_imx51_ecspi(spi_imx))
+	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
 
 	init_completion(&spi_imx->xfer_done);
-- 
1.7.10.4
