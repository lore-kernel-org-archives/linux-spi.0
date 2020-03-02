From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 4/6] spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode
Date: Mon,  2 Mar 2020 02:19:56 +0200
Message-ID: <20200302001958.11105-5-olteanv@gmail.com>
References: <20200302001958.11105-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200302001958.11105-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

XSPI allows for 2 extra features:
- Command cycling (use a single TX command with more than 1 word in the
  TX FIFO).
- Increased word size (from 16 bits to 32 bits)

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 55ccb3d0f683..d21cc5cdc8a4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -179,6 +179,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[LS2085A] = {
@@ -191,6 +192,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_TCFQ_MODE,
 		.max_clock_factor	= 8,
 		.ptp_sts_supported	= true,
+		.xspi_mode		= true,
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
-- 
2.17.1
