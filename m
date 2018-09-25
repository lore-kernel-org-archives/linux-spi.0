From: Hieu Tran Dang <dangtranhieu2012@gmail.com>
Subject: [PATCH 2/2] spi: fsl-lpspi: Option to prevent FIFO under/overrun
Date: Wed, 26 Sep 2018 03:37:01 +0700
Message-ID: <20180925203701.13605-3-dangtranhieu2012@gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Cc: Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Gao Pan <pandy.gao@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Certain devices don't work well when a transmit FIFO underrun or
receive FIFO overrun occurs. Example is the SAF400x radio chip when
running at high speed which leads to garbage being sent to/received from
the chip. In which case, it should stall waiting for further data to be
available before proceeding. This patch add option to configure the SPI
controller to allow stalling (unset NOSTALL bit in CFGR1).

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e6d5cc6ab108..7588b62ef08b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -73,6 +73,7 @@ struct lpspi_config {
 	u8 prescale;
 	u16 mode;
 	u32 speed_hz;
+	bool nostall;
 };
 
 struct fsl_lpspi_data {
@@ -276,7 +277,11 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	temp = CFGR1_PCSCFG | CFGR1_MASTER | CFGR1_NOSTALL;
+	temp = CFGR1_PCSCFG | CFGR1_MASTER;
+
+	if (fsl_lpspi->config.nostall)
+		temp |= CFGR1_NOSTALL;
+
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
@@ -475,6 +480,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(fsl_lpspi->clk);
 
+	fsl_lpspi->config.nostall =
+		!of_get_property(pdev->dev.of_node, "fsl,allow-stall", NULL);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-- 
2.17.1
