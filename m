From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] spi: spi-fsl-dspi: Convert the instantiations that support it to DMA
Date: Mon,  2 Mar 2020 02:19:58 +0200
Message-ID: <20200302001958.11105-7-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200302001958.11105-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

The A-011218 eDMA/DSPI erratum affects most of the older Layerscape SoCs
with DSPI, and its workaround is a bit intrusive.

After this patch, there are no users of TCFQ mode that don't also
support XSPI (previously there was LS2085A).

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c26a42f8ecbc..c357c3247232 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -147,42 +147,49 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 4,
 	},
 	[LS1021A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
+		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
-		.trans_mode		= DSPI_TCFQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
+		.dma_bufsize		= 8,
 		.max_clock_factor	= 8,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
-- 
2.17.1
