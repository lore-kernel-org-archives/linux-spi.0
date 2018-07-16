From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
Date: Sun, 15 Jul 2018 23:25:08 -0700
Message-ID: <20180716062508.7726-1-andrew.smirnov@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Users of SPI device drivers may rely on 'actual_length', so it is
important that information is correctly reported. One example would be
spi_mem_exec_op() which will fail if 'actual_length' doesn't match
requested transfer length. To fix the problem, add necessary code to
populate 'actual_length'.

Cc: Mark Brown <broonie@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: cphealy@gmail.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0630962ce442..8877dd1e18dc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -327,6 +327,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct spi_message *message = dspi->cur_msg;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int word = 1;
@@ -348,7 +349,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len * word;
+			const int len = dma->curr_xfer_len * word;
+
+			curr_remaining_bytes -= len;
+			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
-- 
2.17.1
