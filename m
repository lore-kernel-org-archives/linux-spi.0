From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v2 4/4] spi: spi-fsl-dspi: Fix adjust the byte order when sending and receiving data
Date: Sun, 30 Sep 2018 17:25:35 +0800
Message-ID: <20180930092535.24544-4-chuanhua.han@nxp.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, eha@deif.com,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the byte order inversion problem in the XSPI mode of
the dspi controller during data transfer.
In XSPI mode,When I read and write data without converting the byte
order of the data, and read and write the data directly, I tested spi
flash connected by the dspi controller and found that the byte
order of the data was reversed by the correct byte order.
When I changed the byte order according to the SPIx_CTARn[LSBFE] flag,
the correct data was obtained.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
 -The original patch is divided into multiple patches(the original
patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
mode"),one of which is segmented.

 drivers/spi/spi-fsl-dspi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 96e790e90997..44cc2bd0120e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -220,9 +220,15 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 		if (dspi->bytes_per_word == 1)
 			txdata = *(u8 *)dspi->tx;
 		else if (dspi->bytes_per_word == 2)
-			txdata = *(u16 *)dspi->tx;
+			if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
+				txdata =  cpu_to_le16(*(u16 *)dspi->tx);
+			else
+				txdata =  cpu_to_be16(*(u16 *)dspi->tx);
 		else  /* dspi->bytes_per_word == 4 */
-			txdata = *(u32 *)dspi->tx;
+			if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
+				txdata = cpu_to_le32(*(u32 *)dspi->tx);
+			else
+				txdata = cpu_to_be32(*(u32 *)dspi->tx);
 		dspi->tx += dspi->bytes_per_word;
 	}
 	dspi->len -= dspi->bytes_per_word;
@@ -246,9 +252,15 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (dspi->bytes_per_word == 1)
 		*(u8 *)dspi->rx = rxdata;
 	else if (dspi->bytes_per_word == 2)
-		*(u16 *)dspi->rx = rxdata;
+		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
+			*(u16 *)dspi->rx = be16_to_cpu(rxdata);
+		else
+			*(u16 *)dspi->rx = be16_to_cpu(rxdata);
 	else /* dspi->bytes_per_word == 4 */
-		*(u32 *)dspi->rx = rxdata;
+		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1))
+			*(u32 *)dspi->rx = le32_to_cpu(rxdata);
+		else
+			*(u32 *)dspi->rx = be32_to_cpu(rxdata);
 	dspi->rx += dspi->bytes_per_word;
 }
 
@@ -593,12 +605,12 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		cmd_fifo_write(dspi);
 		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
 			/* LSB */
-			tx_fifo_write(dspi, data & 0xFFFF);
 			tx_fifo_write(dspi, data >> 16);
+			tx_fifo_write(dspi, data & 0xFFFF);
 		} else {
 			/* MSB */
-			tx_fifo_write(dspi, data >> 16);
 			tx_fifo_write(dspi, data & 0xFFFF);
+			tx_fifo_write(dspi, data >> 16);
 		}
 	} else {
 		/* Write one entry to both TX FIFO and CMD FIFO
-- 
2.17.1
