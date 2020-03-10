From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/7] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
Date: Tue, 10 Mar 2020 14:55:39 +0200
Message-ID: <20200310125542.5939-5-olteanv@gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200310125542.5939-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

In DMA mode, dspi_setup_accel does not get called, which results in the
dspi->oper_word_size variable (which is used by dspi_dma_xfer) to not be
initialized properly.

Because oper_word_size is zero, a few calculations end up being
incorrect, and the DMA transfer eventually times out instead of sending
anything on the wire.

Set up native transfers (or 8-on-16 acceleration) using dspi_setup_accel
for DMA mode too.

Also take the opportunity and simplify the DMA buffer handling a little
bit.

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
Changes in v3:
Pretty much re-did the patch. Before, dspi_setup_accel was called just
once at the beginning of dspi_dma_xfer. Now it is called in the while
loop. Everything else is just refactoring that follows along.

Changes in v2:
None.

 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 drivers/spi/spi-fsl-dspi.c | 83 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c59b68592283..8f5d18dc78d5 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -119,7 +119,6 @@ struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
 	int			fifo_size;
-	int			dma_bufsize;
 };
 
 enum {
@@ -138,7 +137,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[VF610] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 2,
-		.dma_bufsize		= 4096,
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
@@ -167,19 +165,16 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_DMA_MODE,
-		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
@@ -191,9 +186,6 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 };
 
 struct fsl_dspi_dma {
-	/* Length of transfer in words of dspi->fifo_size */
-	u32					curr_xfer_len;
-
 	u32					*tx_dma_buf;
 	struct dma_chan				*chan_tx;
 	dma_addr_t				tx_dma_phys;
@@ -352,7 +344,7 @@ static void dspi_rx_dma_callback(void *arg)
 	int i;
 
 	if (dspi->rx) {
-		for (i = 0; i < dma->curr_xfer_len; i++)
+		for (i = 0; i < dspi->words_in_flight; i++)
 			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
 
@@ -366,12 +358,12 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	int time_left;
 	int i;
 
-	for (i = 0; i < dma->curr_xfer_len; i++)
+	for (i = 0; i < dspi->words_in_flight; i++)
 		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
 					dma->tx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -389,7 +381,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
 					dma->rx_dma_phys,
-					dma->curr_xfer_len *
+					dspi->words_in_flight *
 					DMA_SLAVE_BUSWIDTH_4_BYTES,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -437,46 +429,56 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	struct fsl_dspi_dma *dma = dspi->dma;
-	int curr_remaining_bytes;
-	int bytes_per_buffer;
+	int bytes_in_flight = dspi->len;
+	int chunk_size;
 	int ret = 0;
 
-	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
-	while (curr_remaining_bytes) {
+	/*
+	 * dspi->len gets decremented by dspi_pop_tx_pushr in
+	 * dspi_next_xfer_dma_submit
+	 */
+	while (dspi->len) {
+		/* Figure out operational bits-per-word for this chunk */
+		dspi_setup_accel(dspi);
+
+		/*
+		 * If the 16-bit TXDATA of the PUSHR is underutilized, then
+		 * each DMA buffer will be able to hold only up to fifo_size
+		 * useful bytes.
+		 */
+		if (dspi->oper_word_size == 1)
+			chunk_size = dspi->devtype_data->fifo_size;
+		else
+			chunk_size = dspi->devtype_data->fifo_size * 2;
+
 		/* Check if current transfer fits the DMA buffer */
-		dma->curr_xfer_len = curr_remaining_bytes /
-				     dspi->oper_word_size;
-		if (dma->curr_xfer_len > bytes_per_buffer)
-			dma->curr_xfer_len = bytes_per_buffer;
+		bytes_in_flight = dspi->len;
+		if (bytes_in_flight > chunk_size)
+			bytes_in_flight = chunk_size;
+
+		dspi->words_in_flight = bytes_in_flight / dspi->oper_word_size;
 
 		ret = dspi_next_xfer_dma_submit(dspi);
 		if (ret) {
 			dev_err(dev, "DMA transfer failed\n");
-			goto exit;
-
-		} else {
-			const int len = dma->curr_xfer_len *
-					dspi->oper_word_size;
-			curr_remaining_bytes -= len;
-			message->actual_length += len;
-			if (curr_remaining_bytes < 0)
-				curr_remaining_bytes = 0;
+			break;
 		}
+
+		message->actual_length += bytes_in_flight;
 	}
 
-exit:
 	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -500,14 +502,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->tx_dma_buf = dma_alloc_coherent(dev, dma_bufsize,
 					     &dma->tx_dma_phys, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma->rx_dma_buf = dma_alloc_coherent(dev, dma_bufsize,
 					     &dma->rx_dma_phys, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -544,10 +546,10 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dev, dma_bufsize,
 			  dma->rx_dma_buf, dma->rx_dma_phys);
 err_rx_dma_buf:
-	dma_free_coherent(dev, dspi->devtype_data->dma_bufsize,
+	dma_free_coherent(dev, dma_bufsize,
 			  dma->tx_dma_buf, dma->tx_dma_phys);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -562,6 +564,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
+	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	struct device *dev = &dspi->pdev->dev;
 
@@ -570,15 +573,13 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 
 	if (dma->chan_tx) {
 		dma_unmap_single(dev, dma->tx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_TO_DEVICE);
+				 dma_bufsize, DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
 		dma_unmap_single(dev, dma->rx_dma_phys,
-				 dspi->devtype_data->dma_bufsize,
-				 DMA_FROM_DEVICE);
+				 dma_bufsize, DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
-- 
2.17.1
