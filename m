From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
Date: Mon, 16 Jul 2018 21:33:29 -0700
Message-ID: <20180717043329.4209-1-andrew.smirnov@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Upper layer users of SPI device drivers may rely on 'actual_length',
so it is important that information is correctly reported. One such
example is spi_mem_exec_op() function that will fail if
'actual_length' of the data transferred is not what was requested. Add
necessary code to populate 'actual_length.

Cc: Mark Brown <broonie@kernel.org>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: cphealy@gmail.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]

    - Patch rebase on for-next branch of SPI sybsytem's git tree

[v1] lkml.kernel.org/r/20180716062508.7726-1-andrew.smirnov@gmail.com

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 89a1e7a4fe5d..9e598642ca66 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -358,6 +358,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
+	struct spi_message *message = dspi->cur_msg;
 	int curr_remaining_bytes;
 	int bytes_per_buffer;
 	int ret = 0;
@@ -377,8 +378,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			goto exit;
 
 		} else {
-			curr_remaining_bytes -= dma->curr_xfer_len
-				* dspi->bytes_per_word;
+			const int len =
+				dma->curr_xfer_len * dspi->bytes_per_word;
+			curr_remaining_bytes -= len;
+			message->actual_length += len;
 			if (curr_remaining_bytes < 0)
 				curr_remaining_bytes = 0;
 		}
-- 
2.17.1
