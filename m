From: han.xu@nxp.com
Subject: [PATCH 2/3] spi: spi-fsl-qspi: change i.MX7D RX FIFO size
Date: Wed, 10 Jul 2019 10:31:27 +0800
Message-ID: <20190710023128.13115-3-han.xu@nxp.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
To: han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710023128.13115-1-han.xu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Han Xu <han.xu@nxp.com>

The RX FIFO should be 128 byte rather than 512 byte. It's a typo on
reference manual.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..1d08c60e5ae2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -206,7 +206,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 };
 
 static const struct fsl_qspi_devtype_data imx7d_data = {
-	.rxfifo = SZ_512,
+	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
-- 
2.17.1
