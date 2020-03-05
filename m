From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics" to the spi tree
Date: Thu, 05 Mar 2020 14:38:01 +0000
Message-ID: <applied-20200304220044.11193-2-olteanv@gmail.com>
References: <20200304220044.11193-2-olteanv@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-2-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 53fadb4d90c762b560a9d0983bb5894129057ea1 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 5 Mar 2020 00:00:33 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics

Reduce the if-then-else-if-then-else sequence to:
 - a simple division in the case of bytes_per_word calculation
 - a memcpy command with a variable size. The semantics of larger-than-8
   xfer->bits_per_word is that those words are to be interpreted and
   transmitted in CPU native endianness.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Link: https://lore.kernel.org/r/20200304220044.11193-2-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.20.1
