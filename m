From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
Date: Mon,  9 Mar 2020 16:56:21 +0200
Message-ID: <20200309145624.10026-4-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309145624.10026-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Fixes: 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible")
Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a8e56abe20ac..5624b9ee77db 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -372,6 +372,8 @@ static void dspi_rx_dma_callback(void *arg)
 	complete(&dma->cmd_rx_complete);
 }
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
 	struct device *dev = &dspi->pdev->dev;
@@ -459,9 +461,10 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 	int bytes_per_buffer;
 	int ret = 0;
 
+	dspi_setup_accel(dspi);
+
 	curr_remaining_bytes = dspi->len;
-	bytes_per_buffer = dspi->devtype_data->dma_bufsize /
-			   dspi->devtype_data->fifo_size;
+	bytes_per_buffer = dspi->devtype_data->dma_bufsize;
 	while (curr_remaining_bytes) {
 		/* Check if current transfer fits the DMA buffer */
 		dma->curr_xfer_len = curr_remaining_bytes /
-- 
2.17.1
