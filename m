From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 1/6] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
Date: Mon,  9 Mar 2020 16:56:19 +0200
Message-ID: <20200309145624.10026-2-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309145624.10026-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The SPI_MCR_PCSIS macro assumes that the controller has a number of chip
select signals equal to 6. That is not always the case, but actually is
described through the driver-specific " signals equal to 6. That is not
always the case, but actually is described through the driver-specific
"spi-num-chipselects" device tree binding. LS1028A for example only has
4 chip selects.

Don't write to the upper bits of the PCSIS field, which are reserved in
the reference manual.

Fixes: 349ad66c0ab0 ("spi:Add Freescale DSPI driver for Vybrid VF610 platform")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0683a3fbd48c..0ce26c1cbf62 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -22,7 +22,7 @@
 
 #define SPI_MCR				0x00
 #define SPI_MCR_MASTER			BIT(31)
-#define SPI_MCR_PCSIS			(0x3F << 16)
+#define SPI_MCR_PCSIS(x)		((x) << 16)
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
 #define SPI_MCR_XSPI			BIT(3)
@@ -1197,7 +1197,10 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	unsigned int mcr = SPI_MCR_PCSIS;
+	unsigned int mcr;
+
+	/* Set idle states for all chip select signals to high */
+	mcr = SPI_MCR_PCSIS(GENMASK(dspi->ctlr->num_chipselect - 1, 0));
 
 	if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
 		mcr |= SPI_MCR_XSPI;
-- 
2.17.1
