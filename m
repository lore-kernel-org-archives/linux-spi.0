From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v2 3/4] spi: spi-fsl-dspi: Fix cmd_fifo is written before tx_fifo
Date: Sun, 30 Sep 2018 17:25:34 +0800
Message-ID: <20180930092535.24544-3-chuanhua.han@nxp.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, eha@deif.com,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the problem of invalid data writing during the XSPI
mode transfer of the dspi controller.
In XSPI mode,When I executed TX FIFO first and then CMD FIFO for XSPI
transmission, I found that SPIx_SR[TFIWF]=1(Invalid Data present in TX
FIFO since CMD FIFO is empty).
This is the time when no data can be read or written (all the data
obtained is equal to 0).

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
 -The original patch is divided into multiple patches(the original
patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
mode"),one of which is segmented.

 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4dc1064bf408..96e790e90997 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -590,6 +590,7 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
+		cmd_fifo_write(dspi);
 		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
 			/* LSB */
 			tx_fifo_write(dspi, data & 0xFFFF);
@@ -599,7 +600,6 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 			tx_fifo_write(dspi, data >> 16);
 			tx_fifo_write(dspi, data & 0xFFFF);
 		}
-		cmd_fifo_write(dspi);
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
 		 * simultaneously.
-- 
2.17.1
