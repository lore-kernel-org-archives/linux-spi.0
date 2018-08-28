From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE" to the spi tree
Date: Tue, 28 Aug 2018 21:58:26 +0100 (BST)
Message-ID: <20180828205826.C7B9244009F@finisterre.ee.mobilebroadband>
References: <20180817235158.5578-1-angelo@sysam.it>
Cc: Esben Haabendal <esben@haabendal.dk>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        broonie@kernel.org, linux-spi@vger.kernel.org, eha@deif.com,
        linux-spi@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180817235158.5578-1-angelo@sysam.it>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE

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

>From 5223c9c1cbfc0cd4d0a1b50758e0949af3290fa1 Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <angelo@sysam.it>
Date: Sat, 18 Aug 2018 01:51:58 +0200
Subject: [PATCH] spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE

This patch fixes the dspi_eoq_write function used by the
ColdFire mcf5441x family. The 16 bit cmd part must be re-set at
each data transfer.

Also, now that fifo_size variables are used for eoq_read/write,
a proper fifo size must be set (16 slots for the ColdFire dspi
module version).

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Acked-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-fsl-dspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7cb3ab0a35a0..3082e72e4f6c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -30,7 +30,11 @@
 
 #define DRIVER_NAME "fsl-dspi"
 
+#ifdef CONFIG_M5441x
+#define DSPI_FIFO_SIZE			16
+#else
 #define DSPI_FIFO_SIZE			4
+#endif
 #define DSPI_DMA_BUFSIZE		(DSPI_FIFO_SIZE * 1024)
 
 #define SPI_MCR		0x00
@@ -623,9 +627,11 @@ static void dspi_tcfq_read(struct fsl_dspi *dspi)
 static void dspi_eoq_write(struct fsl_dspi *dspi)
 {
 	int fifo_size = DSPI_FIFO_SIZE;
+	u16 xfer_cmd = dspi->tx_cmd;
 
 	/* Fill TX FIFO with as many transfers as possible */
 	while (dspi->len && fifo_size--) {
+		dspi->tx_cmd = xfer_cmd;
 		/* Request EOQF for last transfer in FIFO */
 		if (dspi->len == dspi->bytes_per_word || fifo_size == 0)
 			dspi->tx_cmd |= SPI_PUSHR_CMD_EOQ;
-- 
2.18.0
