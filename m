From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write" to the spi tree
Date: Thu, 05 Mar 2020 14:37:13 +0000
Message-ID: <applied-20200304220044.11193-13-olteanv@gmail.com>
References: <20200304220044.11193-13-olteanv@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-13-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

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

>From e9bac90036d394b01cc7d5297a11d33b8ab92a91 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 5 Mar 2020 00:00:44 +0200
Subject: [PATCH] spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

Although the SPI system timestamps are supposed to reflect the moment
that the peripheral has received a word rather than the moment when the
CPU has enqueued that word to the FIFO, in practice it is easier to just
record the latter time than the former (with a smaller error).

With the recent migration of TCFQ users from poll back to interrupt mode
(this time for XSPI FIFO), it's wiser to keep the interrupt latency
outside of the measurement of the PTP system timestamp itself. If there
proves to be any constant offset that requires static compensation, that
can always be added later. So far that does not appear to be the case at
least on the LS1021A-TSN board, where testing shows that the phc2sys
offset is able to remain within +/- 200 ns even after 68 hours of
testing.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
Link: https://lore.kernel.org/r/20200304220044.11193-13-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d5983be32180..b5ab0afbfa26 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -838,19 +838,18 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 
 static void dspi_fifo_write(struct fsl_dspi *dspi)
 {
+	struct spi_transfer *xfer = dspi->cur_transfer;
+	struct spi_message *msg = dspi->cur_msg;
+	int bytes_sent;
+
 	dspi_setup_accel(dspi);
 
+	spi_take_timestamp_pre(dspi->ctlr, xfer, dspi->progress, !dspi->irq);
+
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_fifo_write(dspi);
 	else
 		dspi_xspi_fifo_write(dspi);
-}
-
-static int dspi_rxtx(struct fsl_dspi *dspi)
-{
-	struct spi_transfer *xfer = dspi->cur_transfer;
-	struct spi_message *msg = dspi->cur_msg;
-	int bytes_sent;
 
 	/* Update total number of bytes that were transferred */
 	bytes_sent = dspi->words_in_flight * dspi->oper_word_size;
@@ -859,16 +858,16 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 
 	spi_take_timestamp_post(dspi->ctlr, dspi->cur_transfer,
 				dspi->progress, !dspi->irq);
+}
 
+static int dspi_rxtx(struct fsl_dspi *dspi)
+{
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
 		return 0;
 
-	spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
-			       dspi->progress, !dspi->irq);
-
 	dspi_fifo_write(dspi);
 
 	return -EINPROGRESS;
-- 
2.20.1
