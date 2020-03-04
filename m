From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/12] spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write
Date: Thu,  5 Mar 2020 00:00:44 +0200
Message-ID: <20200304220044.11193-13-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200304220044.11193-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

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
2.17.1
