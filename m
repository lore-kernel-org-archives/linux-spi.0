From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 01/12] spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics
Date: Thu,  5 Mar 2020 00:00:33 +0200
Message-ID: <20200304220044.11193-2-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Reduce the if-then-else-if-then-else sequence to:
 - a simple division in the case of bytes_per_word calculation
 - a memcpy command with a variable size. The semantics of larger-than-8
   xfer->bits_per_word is that those words are to be interpreted and
   transmitted in CPU native endianness.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c357c3247232..896d7a0f45b0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -252,12 +252,7 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	u32 txdata = 0;
 
 	if (dspi->tx) {
-		if (dspi->bytes_per_word == 1)
-			txdata = *(u8 *)dspi->tx;
-		else if (dspi->bytes_per_word == 2)
-			txdata = *(u16 *)dspi->tx;
-		else  /* dspi->bytes_per_word == 4 */
-			txdata = *(u32 *)dspi->tx;
+		memcpy(&txdata, dspi->tx, dspi->bytes_per_word);
 		dspi->tx += dspi->bytes_per_word;
 	}
 	dspi->len -= dspi->bytes_per_word;
@@ -284,12 +279,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	/* Mask off undefined bits */
 	rxdata &= (1 << dspi->bits_per_word) - 1;
 
-	if (dspi->bytes_per_word == 1)
-		*(u8 *)dspi->rx = rxdata;
-	else if (dspi->bytes_per_word == 2)
-		*(u16 *)dspi->rx = rxdata;
-	else /* dspi->bytes_per_word == 4 */
-		*(u32 *)dspi->rx = rxdata;
+	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
 	dspi->rx += dspi->bytes_per_word;
 }
 
@@ -814,12 +804,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		dspi->progress = 0;
 		/* Validated transfer specific frame size (defaults applied) */
 		dspi->bits_per_word = transfer->bits_per_word;
-		if (transfer->bits_per_word <= 8)
-			dspi->bytes_per_word = 1;
-		else if (transfer->bits_per_word <= 16)
-			dspi->bytes_per_word = 2;
-		else
-			dspi->bytes_per_word = 4;
+		dspi->bytes_per_word = DIV_ROUND_UP(dspi->bits_per_word, 8);
 
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-- 
2.17.1
