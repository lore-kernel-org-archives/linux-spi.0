From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
Date: Mon,  9 Mar 2020 23:07:51 +0200
Message-ID: <20200309210755.6759-3-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309210755.6759-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

In XSPI mode, the 32-bit PUSHR register can be written to separately:
the higher 16 bits are for commands and the lower 16 bits are for data.

This has nicely been hacked around, by defining a second regmap with a
width of 16 bits, and effectively splitting a 32-bit register into 2
16-bit ones, from the perspective of this regmap_pushr.

The problem is the assumption about the controller's endianness. If the
controller is little endian (such as anything post-LS1046A), then the
first 2 bytes, in the order imposed by memory layout, will actually hold
the TXDATA, and the last 2 bytes will hold the CMD.

So take the controller's endianness into account when performing split
writes to PUSHR. The obvious and simple solution would have been to call
regmap_get_val_endian(), but that is an internal regmap function and we
don't want to change regmap just for this. Therefore, we just re-read
the "big-endian" device tree property.

Fixes: 58ba07ec79e6 ("spi: spi-fsl-dspi: Add support for XSPI mode registers")
Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
Changes in v2:
Parse "big-endian" device tree bindings instead of taking the decision
based on compatible SoC.

 drivers/spi/spi-fsl-dspi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0ce26c1cbf62..0483abd403a4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -103,10 +103,6 @@
 #define SPI_FRAME_BITS(bits)		SPI_CTAR_FMSZ((bits) - 1)
 #define SPI_FRAME_EBITS(bits)		SPI_CTARE_FMSZE(((bits) - 1) >> 4)
 
-/* Register offsets for regmap_pushr */
-#define PUSHR_CMD			0x0
-#define PUSHR_TX			0x2
-
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
 struct chip_data {
@@ -240,6 +236,13 @@ struct fsl_dspi {
 
 	int					words_in_flight;
 
+	/*
+	 * Offsets for CMD and TXDATA within SPI_PUSHR when accessed
+	 * individually (in XSPI mode)
+	 */
+	int					pushr_cmd;
+	int					pushr_tx;
+
 	void (*host_to_dev)(struct fsl_dspi *dspi, u32 *txdata);
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
@@ -670,12 +673,12 @@ static void dspi_pushr_cmd_write(struct fsl_dspi *dspi, u16 cmd)
 	 */
 	if (dspi->len > dspi->oper_word_size)
 		cmd |= SPI_PUSHR_CMD_CONT;
-	regmap_write(dspi->regmap_pushr, PUSHR_CMD, cmd);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_cmd, cmd);
 }
 
 static void dspi_pushr_txdata_write(struct fsl_dspi *dspi, u16 txdata)
 {
-	regmap_write(dspi->regmap_pushr, PUSHR_TX, txdata);
+	regmap_write(dspi->regmap_pushr, dspi->pushr_tx, txdata);
 }
 
 static void dspi_xspi_write(struct fsl_dspi *dspi, int cnt, bool eoq)
@@ -1256,6 +1259,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct fsl_dspi *dspi;
 	struct resource *res;
 	void __iomem *base;
+	bool big_endian;
 
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!ctlr)
@@ -1281,6 +1285,7 @@ static int dspi_probe(struct platform_device *pdev)
 
 		/* Only Coldfire uses platform data */
 		dspi->devtype_data = &devtype_data[MCF5441X];
+		big_endian = true;
 	} else {
 
 		ret = of_property_read_u32(np, "spi-num-chipselects", &cs_num);
@@ -1302,6 +1307,15 @@ static int dspi_probe(struct platform_device *pdev)
 			ret = -EFAULT;
 			goto out_ctlr_put;
 		}
+
+		big_endian = of_device_is_big_endian(np);
+	}
+	if (big_endian) {
+		dspi->pushr_cmd = 0;
+		dspi->pushr_tx = 2;
+	} else {
+		dspi->pushr_cmd = 2;
+		dspi->pushr_tx = 0;
 	}
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-- 
2.17.1
