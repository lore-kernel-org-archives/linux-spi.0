From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/3] ARM: dspi: Provide per DSPI instance of the MCR register (SLAVE mode)
Date: Tue, 18 Sep 2018 11:34:36 +0200
Message-ID: <20180918093437.26799-3-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The vf610 Vybryd can work in two DSPI modes - namely master and slave.
Already we do support master mode.
This commit serves as a prerequisite to add support for slave mode. For
slave mode we do need to preserve the MCR register value to change its
"mode" bit (31) according to the supported state.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7cb3ab0a35a0..472385f0a842 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -126,6 +126,7 @@
 #define DMA_COMPLETION_TIMEOUT	msecs_to_jiffies(3000)
 
 struct chip_data {
+	u32 mcr_val;
 	u32 ctar_val;
 	u16 void_write_data;
 };
@@ -696,9 +697,9 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		else
 			dspi->bytes_per_word = 4;
 
-		regmap_update_bits(dspi->regmap, SPI_MCR,
-				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
-				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+		regmap_write(dspi->regmap, SPI_MCR, dspi->cur_chip->mcr_val |
+			     SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
+
 		regmap_write(dspi->regmap, SPI_CTAR(0),
 			     dspi->cur_chip->ctar_val |
 			     SPI_FRAME_BITS(transfer->bits_per_word));
@@ -767,6 +768,11 @@ static int dspi_setup(struct spi_device *spi)
 			return -ENOMEM;
 	}
 
+	chip->mcr_val = SPI_MCR_MASTER | SPI_MCR_PCSIS;
+
+	if (dspi->devtype_data->xspi_mode)
+		chip->mcr_val |= SPI_MCR_XSPI;
+
 	pdata = dev_get_platdata(&dspi->pdev->dev);
 
 	if (!pdata) {
@@ -964,8 +970,6 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS |
-		     (dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0));
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 	if (dspi->devtype_data->xspi_mode)
 		regmap_write(dspi->regmap, SPI_CTARE(0),
-- 
2.11.0
