From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 10/12] spi: spi-fsl-dspi: Add support for LS1028A
Date: Sun, 15 Mar 2020 00:43:38 +0200
Message-ID: <20200314224340.1544-11-olteanv@gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200314224340.1544-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

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

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
None.

Changes in v3:
Removed the dma_bufsize variable (obsoleted by 03/12).

Changes in v2:
Switch to DSPI_XSPI_MODE.

 drivers/spi/spi-fsl-dspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 86255d38ffcf..b6d7e6f383ec 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -124,6 +124,7 @@ struct fsl_dspi_devtype_data {
 enum {
 	LS1021A,
 	LS1012A,
+	LS1028A,
 	LS1043A,
 	LS1046A,
 	LS2080A,
@@ -151,6 +152,11 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
+	[LS1028A] = {
+		.trans_mode		= DSPI_XSPI_MODE,
+		.max_clock_factor	= 8,
+		.fifo_size		= 4,
+	},
 	[LS1043A] = {
 		/* Has A-011218 DMA erratum */
 		.trans_mode		= DSPI_XSPI_MODE,
@@ -1059,6 +1065,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
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
