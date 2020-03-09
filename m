From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 4/6] spi: spi-fsl-dspi: Add support for LS1028A
Date: Mon,  9 Mar 2020 23:07:53 +0200
Message-ID: <20200309210755.6759-5-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is similar to the DSPI instantiation on LS1028A, except that:
 - The A-011218 erratum has been fixed, so DMA works
 - The endianness is different, which has implications on XSPI mode

Some benchmarking with the following command:

spidev_test --device /dev/spidev2.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 20000000

shows that in DMA mode, it can achieve around 2400 kbps, and in XSPI
mode, the same command goes up to 4700 kbps. This is somewhat to be
expected, since the DMA buffer size is extremely small at 8 bytes, the
winner becomes whomever can prepare the buffers for transmission
quicker, and DMA mode has higher overhead there. So XSPI FIFO mode has
been chosen as the operating mode for this chip.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 43d2d9fc8b92..cf8a141bbaf2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -125,6 +125,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -153,6 +154,12 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.dma_bufsize		= 8,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1100,6 +1107,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 	}, {
 		.compatible = "fsl,ls1012a-dspi",
 		.data = &devtype_data[LS1012A],
+	}, {
+		.compatible = "fsl,ls1028a-dspi",
+		.data = &devtype_data[LS1028A],
 	}, {
 		.compatible = "fsl,ls1043a-dspi",
 		.data = &devtype_data[LS1043A],
-- 
2.17.1
