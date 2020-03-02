From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 5/6] spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA modes
Date: Mon,  2 Mar 2020 02:19:57 +0200
Message-ID: <20200302001958.11105-6-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

There's no reason to keep this .ptp_sts_supported property explicitly in
devtype_data, since it can be deduced from the operating mode alone.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d21cc5cdc8a4..c26a42f8ecbc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -122,7 +122,6 @@ enum dspi_trans_mode {
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode	trans_mode;
 	u8			max_clock_factor;
-	bool			ptp_sts_supported;
 	bool			xspi_mode;
 	int			fifo_size;
 	int			dma_bufsize;
@@ -150,48 +149,41 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 	[LS1021A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS1012A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1043A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS1046A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 16,
 	},
 	[LS2080A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.fifo_size		= 4,
 	},
 	[LX2160A] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
-		.ptp_sts_supported	= true,
 		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
@@ -1246,7 +1238,8 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
 
-	ctlr->ptp_sts_supported = dspi->devtype_data->ptp_sts_supported;
+	if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
+		ctlr->ptp_sts_supported = true;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.17.1
